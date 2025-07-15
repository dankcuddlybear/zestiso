#!/bin/sh
ExplicitPkgSelection() {
    echo "Loading packages, this may take a while."
    notify-send --urgency=low --app-name="Package reinstaller" --icon="package-reinstall" --category=network "Loading packages..." "This may take a while."
    PKGS_EXP="$(pacman -Qqe)"
    PKG_CHOICES=""
    for PKG in $PKGS_EXP; do
        PKG_CHOICES="$PKG_CHOICES $PKG $PKG off"
    done
    PKG_SELECTION="$(kdialog --checklist "This list contains packages explicitly installed by the user. Select one or more packages to reinstall." $PKG_CHOICES)"
    PKG_SELECTION="$(echo "$PKG_SELECTION" | xargs)"
    [ -z "$PKG_SELECTION" ] && break
    kdialog --yesno "The following package(s) will be reinstalled:\n$PKG_SELECTION\n\nDo you want to continue?" &> /dev/null || break
}
while true; do
    kdialog --yesnocancel "What would you like to do?" --yes-label "Reinstall packages" --no-label "Reinstall dependencies" &> /dev/null
    case $? in
        0) ExplicitPkgSelection;;
        1) DependencyPkgSelection;;
        2) exit;;
    esac
done
