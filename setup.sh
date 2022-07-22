#!/bin/bash

set -e

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null

# Install package
brew bundle --file Brewfile

# Create symlink
rcup -v -d .
