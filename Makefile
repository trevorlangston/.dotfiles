DOTFILES = $(PWD)
BREW := /usr/local/bin/brew
UNAME := $(shell uname)
objects = link vim tmux

ifeq ($(UNAME), Linux)
	objects := packages-ubuntu $(objects)
else
	objects := core taps bash packages-mac $(objects)
endif

.PHONY: install
install: $(objects)

.PHONY: update
update:
	vim +PluginUpdate +qall
	$(HOME)/.tmux/plugins/tpm/bin/update_plugins all

ifeq ($(UNAME), Linux)
	sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y
else
	brew update
	brew upgrade
	brew cask upgrade
endif

core:
	@echo "Installing xcode"
	@if ! xcode-select -p 1>/dev/null; then xcode-select --install; fi

brew: | $(BREW)
	@brew update

$(BREW):
	@echo "Installing homebrew"
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

taps: | brew
	@brew tap homebrew/cask

packages-mac: | brew
	brew reinstall \
		ack \
		cmake \
		ctags \
		git \
		macvim \
		reattach-to-user-namespace \
		tmux \
		tree

packages-ubuntu:
	sudo apt install -y \
		ack \
		build-essential \
		cmake \
		ctags \
		dunst \
		feh \
		git \
		gnome-tweak-tool \
		i3 \
		make \
		python3-dev \
		screenfetch \
		tmux \
		vim \
		xclip

cask: | brew taps
	brew cask reinstall \
		alacritty \
		flux \
		google-chrome \
		slack \
		spectacle \
		spotify

bash: | link
	@echo "if [ -f ~/.bashrc ]; then . ~/.bashrc; fi" > $(HOME)/.bash_profile

vim: | link
	@echo "Setting up vim"
	@rm -rf $(HOME)/.vim
	@mkdir -p $(HOME)/.vim/tmp $(HOME)/.vim/bundle $(HOME)/.vim/.vimundo
	@git clone https://github.com/VundleVim/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall
ifeq ($(UNAME), Linux)
	@python3 $(HOME)/.vim/bundle/youcompleteme/install.py --clang-completer
else
	@$(HOME)/.vim/bundle/youcompleteme/install.py --clang-completer
endif

tmux: | link
	@echo "Installing tmux plugins"
	@if [ ! -d $(HOME)/.tmux/plugins/tpm ]; \
		then \
			git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
			$(HOME)/.tmux/plugins/tpm/bin/install_plugins; \
		fi
link:
	@echo "Linking dot files"
	@ln -fs $(PWD)/ack/ackrc $(HOME)/.ackrc
	@ln -fs $(PWD)/vim/vimrc $(HOME)/.vimrc
	@ln -fs $(PWD)/tmux/tmux.conf $(HOME)/.tmux.conf
	@ln -fs $(PWD)/bash/bashrc $(HOME)/.bashrc
	@ln -fs $(PWD)/gnu/inputrc $(HOME)/.inputrc
	@ln -fs $(PWD)/alacritty/alacritty.yml $(HOME)/.alacritty.yml
	@ln -fs $(PWD)/git/gitignore $(HOME)/.gitignore
	@ln -fs $(PWD)/xmodmap/Xmodmap $(HOME)/.Xmodmap
	@ln -fs $(PWD)/xinitrc/xinitrc $(HOME)/.xinitrc
