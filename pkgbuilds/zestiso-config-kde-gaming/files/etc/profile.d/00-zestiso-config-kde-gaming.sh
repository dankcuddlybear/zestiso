## Copy custom KDE Plasma config to user home directory
## if the specific file is not found
if [ ! -z "$XDG_SESSION_DESKTOP" ] && \
[ "$XDG_SESSION_DESKTOP" == "KDE" ] && \
[ ! -f "/home/$USER/.config/KDE/zestiso-config-kde-gaming" ]; then
	cp -r /usr/share/KDE/zestiso-config-kde-gaming/.config "/home/$USER/"
	cp -r /usr/share/KDE/zestiso-config-kde-gaming/.local "/home/$USER/"
	cp /usr/share/KDE/zestiso-config-kde-gaming/.gtkrc-2.0 "/home/$USER/"
fi
