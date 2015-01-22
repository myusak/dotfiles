brew update
brew upgrade

brew install binutils
brew install coreutils
brew install findutils
brew install boost
brew install objective-caml
brew install opam
brew install pandoc
brew install ctags
brew install lua
brew install lua-jit
brew install nkf
brew install rbenv
brew install ruby-build
brew install tmux
brew install reattach-to-user-namespace
brew install tree

opam init
eval `opam config env`
opam install omake

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

brew cask install \
    bettertouchtool \
    iterm2 macvim-kaoriya \
    evernote dropbox \
    skype \
    android-studio google-japanese-ime google-chrome google-drive \
    virtualbox genymotion
