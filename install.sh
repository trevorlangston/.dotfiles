echo "#------------------------#"
echo "Installing Packages"
echo "#------------------------#"

sudo add-apt-repository ppa:kgilmer/speed-ricer -y

sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y

sudo apt install -y \
    ack \
    build-essential \
    cmake \
    ctags \
    dunst \
    feh \
    git \
    gnome-tweak-tool \
    i3-gaps \
    i3-gaps-wm \
    i3-gaps-session \
    make \
    python3-dev \
    screenfetch \
    tmux \
    vim \
    xclip

echo "#------------------------#"
echo "Setting up Fonts"
echo "#------------------------#"
cp -r $PWD/fonts/* $HOME/.local/share/fonts

echo "#------------------------#"
echo "Linking Dotfiles"
echo "#------------------------#"

ln -fs $PWD/ack/ackrc $HOME/.ackrc
ln -fs $PWD/vim/vimrc $HOME/.vimrc
ln -fs $PWD/tmux/tmux.conf $HOME/.tmux.conf
ln -fs $PWD/bash/bashrc $HOME/.bashrc
ln -fs $PWD/gnu/inputrc $HOME/.inputrc
ln -fs $PWD/alacritty/alacritty.yml $HOME/.alacritty.yml
ln -fs $PWD/git/gitignore $HOME/.gitignore
ln -fs $PWD/git/gitconfig $HOME/.gitconfig
ln -fs $PWD/xmodmap/Xmodmap $HOME/.Xmodmap
ln -fs $PWD/xinitrc/xinitrc $HOME/.xinitrc
ln -fs $PWD/i3/config $HOME/.config/i3/config
mkdir -p $HOME/.config/i3status
ln -fs $PWD/i3/statusbar $HOME/.config/i3status/config

echo "#------------------------#"
echo "Configuring gnome-terminal"
echo "#------------------------#"
dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/ < $PWD/gnome-terminal/profile

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
