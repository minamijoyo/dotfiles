# デフォルトパス
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

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
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
RPROMPT='${BUNDLE_GEMFILE}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"


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

# terraformの設定
export PATH="$PATH:/opt/terraform/terraform_0.6.6_darwin_amd64"

# aws-cliの補完
source /usr/local/bin/aws_zsh_completer.sh

# ec2-listでEC2インスタンスの一覧を動的に取得してssh先をpecoで選択できるようにする
function peco-ec2ssh() {
  echo "Fetching ec2 host..."
  local selected_host=$(ec2list | sort | peco | cut -f 3)
  if [ -n "${selected_host}" ]; then
    BUFFER="ssh morita@${selected_host} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ec2ssh
bindkey '^re' peco-ec2ssh

# ctagsの設定
alias ctags="`brew --prefix`/bin/ctags"

# vimとclipboardの連携
alias vi="vim"
alias vim="reattach-to-user-namespace vim"

# tmuxの自動起動
if [ -z $TMUX ]; then
  tmux
fi

