## Copy custom KDE Plasma config to user home directory
## if the specific file is not found
if [ ! -z "$XDG_SESSION_DESKTOP" ] && \
[ "$XDG_SESSION_DESKTOP" == "KDE" ] && \
[ ! -f "/home/$USER/.config/KDE/bundle-kde" ]; then
	cp -r /usr/share/KDE/bundle-kde/custom-user-config/.config "/home/$USER/"
	cp -r /usr/share/KDE/bundle-kde/custom-user-config/.local "/home/$USER/"
	cp /usr/share/KDE/bundle-kde/custom-user-config/.gtkrc-2.0 "/home/$USER/"
fi
