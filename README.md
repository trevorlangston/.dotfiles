# Dotfiles

## Setup (for macOS)

### Bash 
1. `echo "if [ -f ~/.bashrc ]; then . ~/.bashrc; fi" > ~/.bash_profile`
2. `ln -s ~/.dotfiles/bash/bashrc ~/.bashrc`

### Tmux 
1. `brew install tmux`
2. `brew install reattach-to-user-namespace`
3. `ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf`

### Vim 
1. `ln -s ~/.dotfiles/vim/vimrc ~/.vimrc`
2. `brew install macvim --with-override-system-vim`
3. `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
4. Launch vim and run `:PluginInstall`
5. Follow special instructions for [youcompleteme](https://github.com/Valloric/YouCompleteMe)

### Git
1. `git config --global core.excludesfile ~/.gitignore` 
2. `ln -s ~/.dotfiles/git/gitignore ~/.gitignore`
3. `ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig`
