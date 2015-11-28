# デフォルトパス
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# oh-my-zshの設定
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# cdrでディレクトリ履歴の管理
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

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

