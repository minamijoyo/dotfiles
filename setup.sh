#!/bin/bash

set -e

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install package
brew bundle --file Brewfile

# Create symlink
rcup -v -d .
