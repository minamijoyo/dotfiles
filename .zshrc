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

# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにしてvimなどでキーバインドを使えるようにする
setopt no_flow_control

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

# terraformの設定
autoload -U +X bashcompinit && bashcompinit
complete -C $GOPATH/bin/terraform terraform
complete -o nospace -C $GOPATH/bin/tfschema tfschema

# myawsの設定
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

# よく使うコマンドのエイリアス
alias dosh="docker-compose run --rm --service-ports rails /bin/bash"
alias wdir="echo ~/work/tmp/`date '+%Y%m%d'`"
alias mkdirw="mkdir `wdir`"
alias cdw="cd `wdir`"
alias ctags="`brew --prefix`/bin/ctags"
alias vim="reattach-to-user-namespace vim"

# 環境変数の管理にdirenvを使う
eval "$(direnv hook zsh)"

# tmuxの自動起動
if [ -z $TMUX ]; then
  tmux
fi
