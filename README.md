# Setup for macOS

- Update macOS to the latest
- Sign In Apple ID.
- Generate a new ssh key and register it to GitHub.

```
$ ssh-keygen -t ed25519 -C "minamijoyo@gmail.com"
$ pbcopy < ~/.ssh/id_ed25519.pub
$ ssh -T git@github.com
$ ssh-add ~/.ssh/id_ed25519
```

- Install xcode to use git.

```
$ xcode-select --install
```

- Clone this repository and run the setup script.

```
$ git clone git@github.com:minamijoyo/dotfiles.git $HOME/src/github.com/minamijoyo/dotfiles
$ cd $HOME/src/github.com/minamijoyo/dotfiles
$ ./setup.sh
```
