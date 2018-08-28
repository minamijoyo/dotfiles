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

# 補完の有効化
autoload -U compinit
compinit

# zplugの設定
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# プライベートリポジトリのプラグインも使うのでzplugのgitをssh経由にする
ZPLUG_PROTOCOL=ssh

# 標準的なコマンドの補完
zplug "zsh-users/zsh-completions"
# コマンド履歴のサジェスト
zplug "zsh-users/zsh-autosuggestions"
# コマンド入力中の上下キーでの履歴の絞込
zplug "zsh-users/zsh-history-substring-search", defer:3
# コマンドのシンタックスハイライト
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# gitのブランチ情報をプロンプトに表示
zplug "olivierverdier/zsh-git-prompt", use:zshrc.sh
# peco/percol/fzfなどでフィルタ絞込するためのフレームワーク
zplug "mollifier/anyframe"
# CWべんりスクリプト
zplug "crowdworksjp/cw-cli-tools"
# zplug "~/src/github.com/crowdworksjp/cw-cli-tools", from:local, at:use-myaws-instead-of-cw-ssh

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

# zsh-users/zsh-history-substring-searchの設定
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# mollifier/anyframeの設定
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

# assume-role
source $(which assume-role)

# cw-cli-toolsの設定
CW_CLI_TOOLS_SSH_USER=morita
zle -N cw-ssh-main-without-proxy
zle -N cw-ssh-dev-without-proxy
zle -N cw-ssh-prod-with-proxy
zle -N cw-ssh-stg-with-proxy
zle -N cw-ssh-dev-with-proxy
bindkey '^rm' cw-ssh-main-without-proxy
bindkey '^re' cw-ssh-dev-without-proxy
bindkey '^rp' cw-ssh-prod-with-proxy
bindkey '^rs' cw-ssh-stg-with-proxy
bindkey '^rd' cw-ssh-dev-with-proxy

# よく使うコマンドのエイリアス
alias dosh="docker-compose run --rm --service-ports rails /bin/bash"
alias wdir="echo ~/work/tmp/`date '+%Y%m%d'`"
alias mkdirw="mkdir `wdir`"
alias cdw="cd `wdir`"
alias ctags="`brew --prefix`/bin/ctags"
alias vim="reattach-to-user-namespace vim"
alias tfp="terraform plan | tee -a /dev/stderr | iconv -f utf-8 -t utf-8 -c | landscape"

# 環境変数の管理にdirenvを使う
eval "$(direnv hook zsh)"

# tmuxの自動起動
if [ -z $TMUX ]; then
  tmux
fi
