install: install-bash install-vim

install-bash:
	rm -f ~/.bashrc
	ln -s `pwd`/bashrc ~/.bashrc
	rm -f ~/.bash_aliases
	ln -s `pwd`/bash_aliases ~/.bash_aliases

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	touch ./vim/vimrc_cred

