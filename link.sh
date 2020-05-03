#!/bin/bash

DOTFILES=$HOME/.dotfiles

mkdir -p $HOME/.config/i3status
ln -fs $DOTFILES/alacritty/alacritty.yml $HOME/.alacritty.yml
ln -fs $DOTFILES/dig/digrc $HOME/.digrc
ln -fs $DOTFILES/ack/ackrc $HOME/.ackrc
ln -fs $DOTFILES/vim/vimrc $HOME/.vimrc
ln -fs $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
ln -fs $DOTFILES/bash/bashrc $HOME/.bashrc
ln -fs $DOTFILES/gnu/inputrc $HOME/.inputrc
ln -fs $DOTFILES/git/gitignore $HOME/.gitignore
ln -fs $DOTFILES/xmodmap/Xmodmap $HOME/.Xmodmap
ln -fs $DOTFILES/xinitrc/xinitrc $HOME/.xinitrc
ln -fs $DOTFILES/i3/config $HOME/.config/i3/config
ln -fs $DOTFILES/i3/statusbar $HOME/.config/i3status/config
ln -fs $DOTFILES/lint/flake8 $HOME/.config/flake8
ln -fs $DOTFILES/Wallpapers/ $HOME/Wallpapers
