install: install-bash
install-bash:
	rm -f ~/.bashrc
	ln -s `pwd`/bashrc ~/.bashrc
	rm -f ~/.bash_profile
	ln -s `pwd`/bash_profile ~/.bash_profile
	rm -f ~/.bash_aliases
	ln -s `pwd`/bash_aliases ~/.bash_aliases


