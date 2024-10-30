#!/bin/sh
exit

## Need to clean up code








kdialog --checklist "Select software" \
---						"[KDE Plasma desktop applications]" off \
discover				"  Discover software centre" on \
filelight				"  Filelight disk usage analyser" on \
isoimagewriter			"  ISO image writer" on \
kalarm					"  Kalarm alarm clock" on \
kamoso					"  Kamoso camera" on \
kate					"  Kate advanced text editor" on \
kbackup					"  Kbackup backup utility" on \
kcalc					"  Kcalc calculator" on \
kcharselect				"  Kcharselect character selector" on \
kcolorchooser			"  Kcolorchooser colour picker" on \
kdeconnect				"  KDEConnect smartphone synchronisation" on \
kdepim-addons			"  KDE PIM (Personal Information Manager) addons" on \
kdeplasma-addons		"  KDE Plasma Addons" on \
kgpg					"  KGPG GPG key manager" on \
khelpcenter				"  KDE Help Centre" on \
kmail 					"  Kmail email client" on \
kolourpaint
konsole
krecorder
krename
ktimer
ktorrent
kwalletmanager
okteta
okular
packagekit-qt6
plasma-systemmonitor
plasma-vault
spectacle
sweeper
yakuake






---						"[Extra software]" off \
firefox					"  Firefox privacy-focused web browser" on \
firefox-i18n-en-gb		"  Firefox British English language pack" on \
libreoffice-fresh		"  LibreOffice office suite (fresh)" on \
libreoffice-fresh-en-gb	"  LibreOffice fresh British English language pack" on \
vlc						"  VLC media player" on \
---						"[System tools]" off \
gparted					"  Gparted disk partitioning tool" on \
nano					"  Nano command-line text editor" on \
testdisk				"  Testdisk/Photorec data recovery tool" on \
---						"[Extra functionality]" off \
bundle-wine 			"  WINE Windows application compatibility layer" on \
bundle-filesystems		"  Additional filesystems support" on \





kdegames "KDE games" on \
wine "WINE" on \
waydroid "Waydroid" on
