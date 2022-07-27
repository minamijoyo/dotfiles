# デフォルトパス
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# デフォルトのエディタ
export EDITOR=vim
alias vi="reattach-to-user-namespace vim"

# EDITOR変数がvim系だとtmuxがvi-mode用にbindkeyが上書きされるので
# 行頭と行末の移動だけEmacs風のCtrl+A/Eでできるように戻す
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# neovimのためにXDGの設定
export XDG_CONFIG_HOME=$HOME/.config

# コマンドの履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS           # 前と重複する行は記録しない
setopt HIST_IGNORE_ALL_DUPS       # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_SPACE          # 行頭がスペースのコマンドは記録しない
setopt HIST_FIND_NO_DUPS          # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_REDUCE_BLANKS         # 余分な空白は詰めて記録
setopt HIST_NO_STORE              # histroyコマンドは記録しない
setopt INC_APPEND_HISTORY         # 履歴をインクリメンタルに追加
setopt SHARE_HISTORY              # 他のセッションの履歴をリアルタイムで共有する

# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにしてvimなどでキーバインドを使えるようにする
setopt no_flow_control

# ターミナルの文字コードの設定
export LC_CTYPE=ja_JP.UTF-8

# asdfの設定
source $(brew --prefix asdf)/libexec/asdf.sh

# zplugの設定
export ZPLUG_HOME="$(brew --prefix)/opt/zplug"
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
# zplug "~/src/github.com/crowdworksjp/cw-cli-tools", from:local, at:use-aws-vault

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# 補完の有効化
autoload -Uz compinit && compinit

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

# goの設定
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# terraformの設定
autoload -U +X bashcompinit && bashcompinit
complete -C $GOPATH/bin/terraform terraform
complete -o nospace -C $GOPATH/bin/tfschema tfschema

# よく使うコマンドのエイリアス
alias dosh="docker-compose run --rm --name dosh --service-ports -e COLUMNS=$(tput cols) -e LINES=$(tput lines) rails /bin/bash"
alias dc="docker-compose"
alias wdir="echo ~/work/tmp/`date '+%Y%m%d'`"
alias mkdirw="mkdir `wdir`"
alias cdw="cd `wdir`"
alias cdroot='(){ cd `git rev-parse --show-toplevel` }'
alias vim="reattach-to-user-namespace vim"
alias tfp="terraform plan"
alias tfip="terraform init && terraform plan"
alias ave='(){ aws-vault exec --duration=4h $@ }'
alias avl='(){ open -na "Google Chrome" --args --incognito --user-data-dir=$HOME/Library/Application\ Support/Google/Chrome/aws-vault/$@  $(aws-vault login --duration=4h $@ --stdout) }'

# 環境変数の管理にdirenvを使う
eval "$(direnv hook zsh)"

# tmuxの自動起動
if [ -z $TMUX ]; then
  tmux
fi
