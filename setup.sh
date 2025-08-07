#!/bin/bash

set -e

# Setup for macOS
# - Update macOS to the latest
# - Sign In Apple ID.
# - Change hostname
#
# Install brew
# $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# $ eval "$(/opt/homebrew/bin/brew shellenv)"
#
# Login to GitHub
# $ brew install git
# $ brew install --cask git-credential-manager
# $ git credential-manager configure
# $ brew install gh
# $ gh auth login
#
# zplugがsshに依存しているのでssh鍵も必要
# $ mkdir -p ~/.ssh
# $ chmod 700 ~/.ssh
# $ curl --silent https://api.github.com/meta | jq --raw-output '"github.com "+.ssh_keys[]' >> ~/.ssh/known_hosts
# $ chmod 600 ~/.ssh/known_hosts
# $ ssh-keygen -t ed25519 -C "minamijoyo@gmail.com"
# $ pbcopy < ~/.ssh/id_ed25519.pub
# $ ssh -T git@github.com
# $ ssh-add ~/.ssh/id_ed25519
#
# Clone this repository and run the setup script.
# $ git clone https://github.com/minamijoyo/dotfiles $HOME/src/github.com/minamijoyo/dotfiles
# $ cd $HOME/src/github.com/minamijoyo/dotfiles
# $ ./setup.sh

# Install Rosetta 2
sudo softwareupdate --install-rosetta

# Install packages
brew bundle --file Brewfile

asdf plugin add terraform
asdf plugin add opentofu
asdf plugin add golang
asdf plugin add python
asdf plugin add poetry
asdf plugin add ruby
asdf plugin add nodejs

# Create directories
mkdir -p ~/work/tmp
mkdir -p ~/.terraform.d/plugin-cache

# Create symlinks
RCRC=rcrc rcup -v

# Dock
## Dockからすべてのアプリを消す
defaults write com.apple.dock persistent-apps -array

# Finder
## 拡張子まで表示
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
## 隠しファイルを表示
defaults write com.apple.Finder "AppleShowAllFiles" -bool "true"

# Keyboard
## キーのリピート速度
defaults write NSGlobalDomain KeyRepeat -int 2
## キーのリピート認識時間
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# その他
## 不要なアプリを削除
## iCloud => Macを探す => on
## 1Password/Google/Slack などいろいろSignIn
## キーボード => 入力ソース => + => 日本語 => ひらがな (Google)
## VPN
## Dash => Preferences => Snippets でスニペット読み込み
## Grammarlyのインストール

# iTerm2の設定
# Settings => Profiles => Default => Window => Transparency: 30
#                                 => Colors => Color Presets: Dark Background
# シェルプロンプトのカスタマイズなどがグローバルなPythonに依存
# asdf install python latest
# asdf set --home python latest
#
# aws-vaultの設定
# ~/.aws/config を設定
# アクセスキーを登録
# aws-vault add xxx
# aws-vault exec xxx --no-session -- aws sts get-caller-identity
# タイムアウトを調整
# open ~/Library/Keychains/aws-vault.keychain-db

# raycastの設定
# Store => Google Chrome => Install
#       => GitHub => Install
# Settings => Extensions => Search Bookmarks => Alias: bk
# GitHub => My Issues => Login
#
# aiderの設定
# sudo mkdir -p /etc/aider
# sudo ln -s $(pwd)/aiderignore /etc/aider/.aiderignore
