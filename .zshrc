# デフォルトパス
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# コマンドの履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# oh-my-zshの設定
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# cdrでディレクトリ履歴の管理
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

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

# terraformの設定
export PATH="$PATH:/opt/terraform/terraform_0.6.6_darwin_amd64"

# aws-cliの補完
source /usr/local/bin/aws_zsh_completer.sh

# tmuxの自動起動
if [ -z $TMUX ]; then
  tmux
fi

