# デフォルトパス
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# デフォルトのエディタ
export EDITOR=vim

# コマンドの履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# oh-my-zshの設定
export ZSH=~/.oh-my-zsh
ZSH_THEME=""
plugins=(git)
source $ZSH/oh-my-zsh.sh

# プロンプト設定
# robbyrussellベースでカスタマイズ
#local rails_var=""
#if [ -n "$BUNDLE_GEMFILE" ]; then
#  rails_var="* "
#fi
local ret_status="%(?:%{$fg[green]%}:%{$fg[red]%}%s)"
PROMPT='[%{$fg[blue]%}%c%{$reset_color%}$(git_prompt_info)]${ret_status}$ %{$reset_color%}'
RPROMPT='${BUNDLE_GEMFILE}'

ZSH_THEME_GIT_PROMPT_PREFIX="@%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} x%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""


# cdrでディレクトリ履歴の管理
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# 今日日付の作業ディレクトリ作成と移動用のエイリアス
alias wdir="echo ~/work/tmp/`date '+%Y%m%d'`"
alias mkdirw="mkdir `wdir`"
alias cdw="cd `wdir`"

# anyframeでpecoと連携
fpath=($HOME/.zsh/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init

bindkey '^r' anyframe-widget-put-history

bindkey '^rr' anyframe-widget-cdr
bindkey '^r^r' anyframe-widget-cdr

bindkey '^rg' anyframe-widget-cd-ghq-repository
bindkey '^r^g' anyframe-widget-cd-ghq-repository

bindkey '^rb' anyframe-widget-checkout-git-branch
bindkey '^r^b' anyframe-widget-checkout-git-branch

# rbenvの設定
export PATH="$HOME/.rbenv/shims:$PATH"

# tfenvの設定
export PATH="$HOME/src/github.com/kamatama41/tfenv/bin:$PATH"

# goの設定
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# aws-cliの補完
source /usr/local/bin/aws_zsh_completer.sh

# gcloudの設定
if [ -f $HOME/google-cloud-sdk/path.zsh.inc ]; then
  source $HOME/google-cloud-sdk/path.zsh.inc
fi
if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then
  source $HOME/google-cloud-sdk/completion.zsh.inc
fi

# cw-cli-toolsの設定
export PATH=$PATH:~/src/github.com/crowdworksjp/cw-cli-tools/bin

EC2_SSH_USER=morita

# aws-cliからタグ指定で動的にインスタンスのIPアドレスなどの一覧を取得する
function get-ec2list() {
  filter_tag_name=${1:-Name}
  filter_tag_value=${2:-\*}
  print_tag_name=${3:-attached_asg}
  filter="Name=tag:$filter_tag_name,Values=$filter_tag_value"
  query=".Reservations[] | .Instances[] | select(.State.Name == \"running\") | select(has(\"PublicIpAddress\")) | [.PublicIpAddress,.InstanceId,.State.Name,.LaunchTime,(.Tags[] | select(.Key == \"Name\") | .Value // \"\"),(.Tags[] | select(.Key == \""$print_tag_name"\") | .Value // \"\")] | join(\"\t\")"
  aws ec2 describe-instances --filter "$filter" | jq -r "$query"
}

# タグからIPアドレスを解決してsshする。複数該当する場合はどれか一つ。
function ec2ssh() {
  filter_tag_name=${1:-Name}
  filter_tag_value=${2:-\*}
  target_host=$(get-ec2list $filter_tag_name $filter_tag_value | sort | head -n 1 | cut -f 1)
  ssh $EC2_SSH_USER@$target_host
}

# タグからIPアドレスを解決してtmux-csshで全台同時にsshしてキー入力を同期する
# tmux-csshはtmuxのセッション内から実行できないのでbindkey+dでデタッチしてから実行すること
function ec2cssh() {
  filter_tag_name=${1:-Name}
  filter_tag_value=${2:-\*}
  target_hosts=$(get-ec2list $filter_tag_name $filter_tag_value | sort | cut -f 1 | tr '\n' ' ')
  sh -c "tmux-cssh -u $EC2_SSH_USER $target_hosts"
}

# sshホストキーの削除
function delete-hostkey() {
  ssh-keygen -R $1
}

# sshホストキーの追加
function add-hostkey() {
  ssh-keyscan -H $1 >> ~/.ssh/known_hosts
}

# sshホストキーの更新
function update-hostkey() {
  delete-hostkey $1
  add-hostkey $1
}

# タグからIPアドレス解決してsshホストキーをまとめて更新
function update-hostkeys() {
  filter_tag_name=${1:-Name}
  filter_tag_value=${2:-\*}
  target_hosts=($(get-ec2list $filter_tag_name $filter_tag_value | sort | cut -f 1 | tr '\n' ' '))
  for target_host in $target_hosts; do
    update-hostkey $target_host
  done
}

# よくログインするサーバへのエイリアス
alias update-hostkeys-app='update-hostkeys Name app-production'
alias update-hostkeys-proxy='update-hostkeys Name reverse-proxy-production'

function pssh() {
  aws_profile_name=$1
  ssh_proxy=$2
  echo "Fetching ec2 host..."
  local selected_host=$(myaws ec2 ls --profile=${aws_profile_name} --fields='InstanceId PublicIpAddress LaunchTime Tag:Name Tag:attached_asg' | sort -k4 | peco | cut -f2)
  if [ -n "${selected_host}" ]; then
    if [ -z "${ssh_proxy}" ]; then
      BUFFER="ssh $EC2_SSH_USER@${selected_host}"
    else
      BUFFER="ssh -t $EC2_SSH_USER@${ssh_proxy} ssh devops@${selected_host}"
    fi
    zle accept-line
  fi
  zle clear-screen
}

function pssh-main() { pssh main}
function pssh-dev() { pssh dev}
function pssh-prod-with-proxy() { pssh main main}
function pssh-stg-with-proxy() { pssh main dev}
function pssh-dev-with-proxy() { pssh dev dev}
zle -N pssh-main
zle -N pssh-dev
zle -N pssh-prod-with-proxy
zle -N pssh-stg-with-proxy
zle -N pssh-dev-with-proxy
bindkey '^rm' pssh-main
bindkey '^re' pssh-dev
bindkey '^rp' pssh-prod-with-proxy
bindkey '^rs' pssh-stg-with-proxy
bindkey '^rd' pssh-dev-with-proxy

# ghqとpecoの連携
function peco-ghq () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ghq
bindkey '^rg' peco-ghq

# hubとpecoの連携
function peco-hub-pr () {
    local pr=$(hub issue 2> /dev/null | grep 'pull' | peco --query "$LBUFFER" | sed -e 's/.*( \(.*\) )$/\1/')
    if [ -n "$pr" ]; then
        BUFFER="open ${pr}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-hub-pr
bindkey '^rh' peco-hub-pr

# カレントリポジトリのgitconfigをminamijoyoに設定
function set-git-config-minamijoyo() {
  git config user.name "Masayuki Morita"
  git config user.email "minamijoyo@gmail.com"
}

# ctagsの設定
alias ctags="`brew --prefix`/bin/ctags"

# vimとclipboardの連携
alias vi="vim"
alias vim="reattach-to-user-namespace vim"

# sttyのCtrl + S と Ctrl + Q の割り当てを解除してvimなどで使えるようにする
stty stop undef
stty start undef

# tmuxの自動起動
if [ -z $TMUX ]; then
  tmux
fi

# dinghy用の環境変数の読み込み
eval "$(dinghy env)"

# 環境変数の管理にdirenvを使う
eval "$(direnv hook zsh)"

# よく使うコマンドのエイリアス
alias dosh="docker-compose run --rm --service-ports rails /bin/bash"
alias domy="mycli -h `dinghy ip` -u root crowdworks_dev"
