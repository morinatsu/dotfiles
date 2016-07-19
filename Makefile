ifeq ($(OS),Windows_NT)
VIMDIR := vimfiles
VIMRC := vimrc
GVIMRC := gvimrc
UNDODIR := .local/undodir
else
VIMDIR := .vim
VIMRC := vimrc
GVIMRC := gvimrc
UNDODIR := .local/undodir
endif

install: install-bash install-vim install-powerline install-byobu install-textlint
install-bash:
	rm -f ~/.bashrc
	ln -s `pwd`/bashrc ~/.bashrc
	rm -f ~/.bash_aliases
	ln -s `pwd`/bash_aliases ~/.bash_aliases

install-byobu:
	rm -rf ~/.byobu
	ln -s `pwd`/byobu ~/.byobu
	rm -rf ~/.fuc
	ln -s `pwd`/fuc ~/.fuc

install-powerline:
	@if [ ! -d ~/.config ]; then \
	    mkdir -f ~/.config; \
	fi
	rm -f ~/.config/powerline
	ln -s `pwd`/powerline ~/.config/powerline

install-vim:
	rm -rf ~/$(VIMDIR)
	ln -s `pwd`/vim ~/$(VIMDIR)
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ./installer.sh
	sh ./installer.sh `pwd`/vim/dein
	rm -f ./installer.sh
	rm -rf ~/$(UNDODIR)
	mkdir ~/$(UNDODIR)

install-textlint:
	rm -f ~/.textlintrc
	ln -s `pwd`/textlintrc ~/.textlintrc

