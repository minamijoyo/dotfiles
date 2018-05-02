# デフォルトパス
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# デフォルトのエディタ
export EDITOR=nvim
alias vi="nvim"

# neovimのためにXDGの設定
export XDG_CONFIG_HOME=$HOME/.config

# コマンドの履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# zplugの設定
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# 標準的なコマンドの補完
zplug "zsh-users/zsh-completions"
# コマンド履歴のサジェスト
zplug "zsh-users/zsh-autosuggestions"
# コマンドのシンタックスハイライト
zplug "zsh-users/zsh-syntax-highlighting"
# gitのブランチ情報をプロンプトに表示
zplug "olivierverdier/zsh-git-prompt", use:zshrc.sh
# pecoなどで絞込
zplug "mollifier/anyframe"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# プロンプト設定
local ret_status="%(?:%{$fg[green]%}:%{$fg[red]%}%s)"
PROMPT='[%{$fg[cyan]%}%c%{$reset_color%}@$(git_super_status)]${ret_status}$ %{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

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

# anyframeの設定
bindkey '^r' anyframe-widget-put-history

bindkey '^rr' anyframe-widget-cdr
bindkey '^r^r' anyframe-widget-cdr

bindkey '^rg' anyframe-widget-cd-ghq-repository
bindkey '^r^g' anyframe-widget-cd-ghq-repository

bindkey '^rb' anyframe-widget-checkout-git-branch
bindkey '^r^b' anyframe-widget-checkout-git-branch

# rbenvの設定
export PATH="$HOME/.rbenv/shims:$PATH"

# goの設定
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
eval "$(goenv init -)"

# javaの設定
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# aws-cliの補完
# source /usr/local/bin/aws_zsh_completer.sh

# gcloudの設定
if [ -f $HOME/google-cloud-sdk/path.zsh.inc ]; then
  source $HOME/google-cloud-sdk/path.zsh.inc
fi
if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then
  source $HOME/google-cloud-sdk/completion.zsh.inc
fi

# terraformの設定
autoload -U +X bashcompinit && bashcompinit
complete -C $GOPATH/bin/terraform terraform
complete -o nospace -C $GOPATH/bin/tfschema tfschema

# cw-cli-toolsの設定
export PATH=$PATH:~/src/github.com/crowdworksjp/cw-cli-tools/bin

EC2_SSH_USER=morita

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
alias vim="reattach-to-user-namespace vim"

# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにしてvimなどでキーバインドを使えるようにする
setopt no_flow_control

# tmuxの自動起動
if [ -z $TMUX ]; then
  tmux
fi

# 環境変数の管理にdirenvを使う
eval "$(direnv hook zsh)"

# よく使うコマンドのエイリアス
alias dosh="docker-compose run --rm --service-ports rails /bin/bash"
