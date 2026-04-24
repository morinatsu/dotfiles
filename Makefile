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

install: install-bash install-vim install-textlint
install-bash:
	rm -f ~/.bashrc
	ln -s `pwd`/bashrc ~/.bashrc
	rm -f ~/.bash_profile
	ln -s `pwd`/bash_profile ~/.bash_profile
	rm -f ~/.bash_aliases
	ln -s `pwd`/bash_aliases ~/.bash_aliases


install-vim:
	rm -rf ~/$(VIMDIR)
	ln -s `pwd`/vim ~/$(VIMDIR)
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ./installer.sh
	sh ./installer.sh `pwd`/vim/dein
	rm -f ./installer.sh
	rm -rf ~/$(UNDODIR)
	mkdir -p ~/$(UNDODIR)

install-textlint:
	rm -f ~/.textlintrc
	ln -s `pwd`/textlintrc ~/.textlintrc

