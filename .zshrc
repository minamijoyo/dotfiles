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

# anyframeでpecoと連携
fpath=($HOME/.zsh/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init

bindkey '^r' anyframe-widget-cdr
bindkey '^rb' anyframe-widget-checkout-git-branch

bindkey '^rr' anyframe-widget-execute-history
bindkey '^r^r' anyframe-widget-execute-history

bindkey '^rp' anyframe-widget-put-history
bindkey '^r^p' anyframe-widget-put-history

bindkey '^rg' anyframe-widget-cd-ghq-repository
bindkey '^r^g' anyframe-widget-cd-ghq-repository

bindkey '^rk' anyframe-widget-kill
bindkey '^r^k' anyframe-widget-kill

bindkey '^ri' anyframe-widget-insert-git-branch
bindkey '^r^i' anyframe-widget-insert-git-branch

bindkey '^rf' anyframe-widget-insert-filename
bindkey '^r^f' anyframe-widget-insert-filename

# rbenvの設定
export PATH="$HOME/.rbenv/shims:$PATH"

# goの設定
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# terraformの設定
export PATH="$PATH:/opt/terraform/terraform_0.6.16_darwin_amd64"

# aws-cliの補完
source /usr/local/bin/aws_zsh_completer.sh

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
alias ec2ssh-app='ec2ssh Name app-production'
alias ec2ssh-app-3='ec2ssh Name app-production-rails3'
alias ec2ssh-app-4='ec2ssh Name app-production-rails4'
alias ec2ssh-proxy='ec2ssh Name reverse-proxy-production'
alias ec2ssh-app-1='ec2ssh attached_asg app-production-asg-1'
alias ec2ssh-app-2='ec2ssh attached_asg app-production-asg-2'
alias ec2ssh-app-31='ec2ssh attached_asg app-production-rails3-asg-1'
alias ec2ssh-app-32='ec2ssh attached_asg app-production-rails3-asg-2'
alias ec2ssh-app-41='ec2ssh attached_asg app-production-rails4-asg-1'
alias ec2ssh-app-42='ec2ssh attached_asg app-production-rails4-asg-2'
alias ec2ssh-proxy-1='ec2ssh attached_asg reverse-proxy-production-asg-1'
alias ec2ssh-proxy-2='ec2ssh attached_asg reverse-proxy-production-asg-2'

alias ec2cssh-app='ec2cssh Name app-production'
alias ec2cssh-app-3='ec2cssh Name app-production-rails3'
alias ec2cssh-app-4='ec2cssh Name app-production-rails4'
alias ec2cssh-proxy='ec2cssh Name reverse-proxy-production'
alias ec2cssh-app-1='ec2cssh attached_asg app-production-asg-1'
alias ec2cssh-app-2='ec2cssh attached_asg app-production-asg-2'
alias ec2cssh-app-31='ec2cssh attached_asg app-production-rails3-asg-1'
alias ec2cssh-app-32='ec2cssh attached_asg app-production-rails3-asg-2'
alias ec2cssh-app-41='ec2cssh attached_asg app-production-rails4-asg-1'
alias ec2cssh-app-42='ec2cssh attached_asg app-production-rails4-asg-2'
alias ec2cssh-proxy-1='ec2cssh attached_asg reverse-proxy-production-asg-1'
alias ec2cssh-proxy-2='ec2cssh attached_asg reverse-proxy-production-asg-2'

alias update-hostkeys-app='update-hostkeys Name app-production'
alias update-hostkeys-app-3='update-hostkeys Name app-production-rails3'
alias update-hostkeys-app-4='update-hostkeys Name app-production-rails4'
alias update-hostkeys-proxy='update-hostkeys Name reverse-proxy-production'

# get-ec2listの出力をpeco連携してsshできるようにする
function peco-ec2ssh() {
  echo "Fetching ec2 host..."
  local selected_host=$(get-ec2list Name \* attached_asg | sort | peco | cut -f 1)
  if [ -n "${selected_host}" ]; then
    BUFFER="ssh $EC2_SSH_USER@${selected_host}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ec2ssh
bindkey '^re' peco-ec2ssh

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

# ctagsの設定
alias ctags="`brew --prefix`/bin/ctags"

# vimとclipboardの連携
alias vi="vim"
alias vim="reattach-to-user-namespace vim"

# tmuxの自動起動
if [ -z $TMUX ]; then
  tmux
fi

# 環境変数の管理にdirenvを使う
eval "$(direnv hook zsh)"

