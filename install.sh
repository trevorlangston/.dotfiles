DOTFILES=$HOME/.dotfiles

echo "#------------------------#"
echo "Installing Packages"
echo "#------------------------#"

sudo add-apt-repository ppa:kgilmer/speed-ricer -y
sudo add-apt-repository ppa:kelleyk/emacs - y

sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y

sudo apt install -y \
    ack \
    apt-transport-https \
    build-essential \
    ca-certificates \
    cmake \
    compton \
    ctags \
    curl \
    dconf-cli \
    dunst \
    emacs26 \
    feh \
    git \
    gnome-tweak-tool \
    gnupg-agent \
    htop \
    i3-gaps \
    i3-gaps-session \
    i3-gaps-wm \
    make \
    nasm \
    nitrogen \
    python3-dev \
    python3-pip \
    screenfetch \
    software-properties-common \
    tmux \
    vim \
    xclip

echo "#------------------------#"
echo "Installing Python Modules"
echo "#------------------------#"

python3 -m pip install flake8
python3 -m pip install numpy
python3 -m pip install boto3
python3 -m pip install matplotlib

echo "#------------------------#"
echo "Setting up Fonts"
echo "#------------------------#"

cp -r -u $PWD/fonts/* $HOME/.local/share/fonts

echo "#------------------------#"
echo "Linking Dotfiles"
echo "#------------------------#"

mkdir -p $HOME/.config/i3status
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
ln -fs $DOTFILES/gtk/gtk.css $HOME/.config/gtk-3.0/gtk.css
ln -fs $DOTFILES/lint/flake8 $HOME/.config/flake8
ln -fs $DOTFILES/Wallpapers/ $HOME/Wallpapers
ln -fs $DOTFILES/compton/compton.conf $HOME/.config/compton.conf

echo "#------------------------#"
echo "Repos"
echo "#------------------------#"

mkdir -p $HOME/src/github.com/trevorlangston
git clone https://github.com/trevorlangston/clone.git $HOME/src/github.com/trevorlangston/clone
chmod +x $HOME/src/github.com/trevorlangston/clone/clone.sh

mkdir -p $HOME/src/github.com/aruhier
git clone https://github.com/aruhier/gnome-terminal-colors-solarized.git $HOME/src/github.com/aruhier/gnome-terminal-colors-solarized

echo "#------------------------#"
echo "Configuring gnome-terminal"
echo "#------------------------#"

dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/ < $DOTFILES/gnome-terminal/backup.txt
$HOME/src/github.com/aruhier/gnome-terminal-colors-solarized/install.sh -s dark --install-dircolors

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
