## Copy custom KDE Plasma config to user home directory
## if the specific file is not found
if [ ! -z "$XDG_SESSION_DESKTOP" ] && \
[ "$XDG_SESSION_DESKTOP" == "KDE" ] && \
[ ! -f "/home/$USER/.config/KDE/kde-core-meta" ]; then
	cp -r /usr/share/KDE/kde-core-meta/custom-user-config/.config "/home/$USER/"
	cp -r /usr/share/KDE/kde-core-meta/custom-user-config/.local "/home/$USER/"
	cp /usr/share/KDE/kde-core-meta/custom-user-config/.gtkrc-2.0 "/home/$USER/"
fi
