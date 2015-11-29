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
	rm -f ~/.config/powerline
	ln -s `pwd`/powerline ~/.config/powerline

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	touch ./vim/vimrc_cred

