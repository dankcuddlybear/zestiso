if [ ! -f "/home/$USER/.config/dotfiles-installer" ]; then
	cp -r /etc/dotfiles/* "/home/$USER/"
	cp -r /etc/dotfiles/.* "/home/$USER/"
	touch "/home/$USER/.config/dotfiles-installer"
fi
