# Dotfiles

## Setup (for osx)

### Tmux 
1. `brew install tmux`
2. `brew install reattach-to-user-namespace`
3. `ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf`

### Vim 
1. `brew install macvim --with-override-system-vim`
2. `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
3. Launch vim and run `:PluginInstall`

