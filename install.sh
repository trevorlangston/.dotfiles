#!/bin/bash

DOTFILES=$HOME/.dotfiles

echo "#------------------------#"
echo "Installing Packages"
echo "#------------------------#"

sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y

sudo apt install -y \
    ack \
    apt-file \
    apt-transport-https \
    bc \
    bison \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    dconf-cli \
    dmenu \
    dunst \ # notifications
    exuberant-ctags \
    feh \
    flex \
    gcc \
    git \
    gnupg-agent \
    htop \
    libelf-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libncurses5-dev \
    libssl-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev
    make \
    nasm \
    nitrogen \
    pavucontrol \
    pkg-config \
    python3-dev \
    python3-pip \
    screenfetch \
    software-properties-common \
    tmux \
    vim \
    vim-gtk3 \
    xclip

sudo apt autoremove -y

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable

# alacritty
git clone https://github.com/alacritty/alacritty.git $HOME/src/github.com/alacritty
PWD=$HOME/src/github.com/alacritty/alacritty; cargo build --release
PWD=$HOME/src/github.com/alacritty/alacritty; sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
PWD=$HOME/src/github.com/alacritty/alacritty; sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
PWD=$HOME/src/github.com/alacritty/alacritty; sudo desktop-file-install extra/linux/Alacritty.desktop
PWD=$HOME/src/github.com/alacritty/alacritty; sudo update-desktop-database

# TODO
# echo "#------------------------#"
# echo "Docker"
# echo "#------------------------#"
#
# sudo systemctl enable docker
# sudo getent group docker || sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# docker run hello-world

echo "#------------------------#"
echo "Installing Python Modules"
echo "#------------------------#"

python3 -m pip install flake8
python3 -m pip install numpy
python3 -m pip install boto3
python3 -m pip install matplotlib
python3 -m pip install pandas

echo "#------------------------#"
echo "Setting up Fonts"
echo "#------------------------#"

cp -r -u $PWD/fonts/* $HOME/.local/share/fonts

echo "#------------------------#"
echo "Linking Dotfiles"
echo "#------------------------#"

$DOTFILES/link.sh

echo "#------------------------#"
echo "Repos"
echo "#------------------------#"

mkdir -p $HOME/src/github.com/trevorlangston
git clone https://github.com/trevorlangston/clone.git $HOME/src/github.com/trevorlangston/clone
chmod +x $HOME/src/github.com/trevorlangston/clone/clone.sh

# mkdir -p $HOME/src/github.com/aruhier
# git clone https://github.com/aruhier/gnome-terminal-colors-solarized.git $HOME/src/github.com/aruhier/gnome-terminal-colors-solarized

echo "#------------------------#"
echo "Installing Vim Plugins"
echo "#------------------------#"

rm -rf $HOME/.vim
mkdir -p $HOME/.vim/tmp $HOME/.vim/bundle $HOME/.vim/.vimundo
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
python3 $HOME/.vim/bundle/youcompleteme/install.py --clang-completer

echo "#------------------------#"
echo "Installing Tmux Plugins"
echo "#------------------------#"

tmux source $HOME/.tmux.conf
rm -rf $HOME/.tmux/plugins
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
tmux # TODO must detach from session before continuing
$HOME/.tmux/plugins/tpm/bin/install_plugins;
tmux kill-session -t 0

echo "#------------------------#"
echo "Finishing Up"
echo "#------------------------#"

source $HOME/.bashrc

printf "\nYou may want to:\n"
echo "* run 'ln -fs $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig'"
echo "* setup github ssh key"
echo "* run 'nitrogen $HOME/Wallpapers'"
