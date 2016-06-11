install: install-bash install-vim install-powerline install-byobu
install-bash:
	rm -f ~/.bashrc
	ln -s `pwd`/bashrc ~/.bashrc
	rm -f ~/.bash_aliases
	ln -s `pwd`/bash_aliases ~/.bash_aliases

install-byobu:
	rm -f ~/.byobu
	ln -s `pwd`/byobu ~/.byobu

install-powerline:
	mkdir ~/.config
	rm -f ~/.config/powerline
	ln -s `pwd`/powerline ~/.config/powerline

install-vim:
	ifeq ($(OS),Windows_NT)
		VIMDIR = vimfiles
		VIMRC = vimrc
		GVIMRC = gvimrc
	else
		VIMDIR = .vim
		VIMRC = vimrc
		GVIMRC = gvimrc
	endif
	rm -rf ~/$(VIMDIR)
	ln -s `pwd`/vim ~/$(VIMDIR)
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ./installer.sh
	sh ./installer.sh `pwd`/vim/dein
	rm -f ./installer.sh
