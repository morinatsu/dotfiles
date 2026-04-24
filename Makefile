install: install-bash
install-bash:
	rm -f ~/.bashrc
	ln -s `pwd`/bashrc ~/.bashrc
	rm -f ~/.profile
	ln -s `pwd`/profile ~/.profile
	rm -f ~/.bash_aliases
	ln -s `pwd`/bash_aliases ~/.bash_aliases


