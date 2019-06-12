DOTFILES = $(PWD)
BREW := /usr/local/bin/brew

.PHONEY: install update

install: | core link taps packages cask bash vim tmux

update:
	@brew update
	@brew upgrade
	@brew cask upgrade
	@vim +PluginUpdate +qall
	@$(HOME)/.tmux/plugins/tpm/bin/update_plugins all

core:
	@if ! xcode-select -p 1>/dev/null; then xcode-select --install; fi

brew: | $(BREW)
	brew update

$(BREW):
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

taps: | brew
	brew tap homebrew/cask

packages: | brew
	brew reinstall \
		ack \
		cmake \
		ctags \
		git \
		macvim \
		reattach-to-user-namespace \
		tmux \
		tree

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
	@rm -rf $(HOME)/.vim
	@mkdir -p $(HOME)/.vim/tmp $(HOME)/.vim/bundle $(HOME)/.vim/.vimundo
	@git clone https://github.com/VundleVim/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall
	@$(HOME)/.vim/bundle/YouCompleteMe/install.py

tmux: | link # TODO
	@if "test ! -d ~/.tmux/plugins/tpm" "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"

link:
	@ln -fs $(PWD)/vim/vimrc $(HOME)/.vimrc
	@ln -fs $(PWD)/tmux/tmux.conf $(HOME)/.tmux.conf
	@ln -fs $(PWD)/bash/bashrc $(HOME)/.bashrc
	@ln -fs $(PWD)/alacritty/alacritty.yml $(HOME)/.alacritty.yml
	@ln -fs $(PWD)/git/gitignore $(HOME)/.gitignore
