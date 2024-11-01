#!/bin/bash
PKG_SELECTION="$(echo "$(kdialog --checklist "Select extra software (default: everything)\nClick to select (highlighted) or deselect (not highlighted)" \
- "[ Extra software ]" off \
firefox "  firefox: Fast, Private & Safe Web Browser" on \
firefox-i18n-en-gb "  firefox-i18n-en-gb: English (British) language pack for Firefox" on \
gparted "  gparted: Disk partition editor" on \
libreoffice-fresh "  libreoffice-fresh: Free and powerful office suite with new features and program enhancements" on \
libreoffice-fresh-en-gb "  libreoffice-fresh-en-gb: English (GB) language pack for LibreOffice Fresh" on \
nano "  nano: Command-line text editor" on \
testdisk "  testdisk: Testdisk+Photorec: Data/photo recovery tool" on \
vlc "  vlc: Multimedia player supporting a wide variety of multimedia formats and streams" on \
- "[ Additional functionality ]" off \
bundle-filesystems "  bundle-filesystems: Support for additional filesystems - all-in-one bundle" on \
bundle-wine "  bundle-wine: Windows applications and games compatibility - all-in-one bundle" on \
- "[ KDE applications ]" off \
discover "  discover: KDE Plasma software download centre" on \
dolphin-plugins "  dolphin-plugins: Extra plugins for Dolphin KDE file manager" on \
filelight "  filelight: View disk usage information" on \
isoimagewriter "  isoimagewriter: Program to write hybrid ISO files onto USB disks" on \
kalarm "  kalarm: Personal alarm scheduler" on \
kamoso "  kamoso: A webcam recorder from KDE community" on \
kbackup "  kbackup: A program that lets you back up any directories or files" on \
kcharselect "  kcharselect: Character Selector" on \
kcolorchooser "  kcolorchooser: Colour picker" on \
kdeconnect "  kdeconnect: Adds communication between KDE and your smartphone" on \
kdepim-addons "  kdepim-addons: Addons for KDE PIM applications (email, calendar, contacts, etc.)" on \
kdeplasma-addons "  kdeplasma-addons: Extra addons for KDE Plasma desktop" on \
kfind "  kfind: Find Files/Folders" on \
kgpg "  kgpg: GPG key manager" on \
kmail "  kmail: KDE mail client" on \
kolourpaint "  kolourpaint: Paint Program" on \
krecorder "  krecorder: Audio recorder for Plasma Mobile and other platforms" on \
krename "  krename: A very powerful batch file renamer" on \
ktimer "  ktimer: Countdown Launcher" on \
ktorrent "  ktorrent: A powerful BitTorrent client for KDE" on \
okteta "  okteta: KDE hex editor for viewing and editing the raw data of files" on \
okular "  okular: Document Viewer" on \
plasma-vault "  plasma-vault: Plasma applet and services for creating encrypted vaults" on \
sweeper "  sweeper: System Cleaner" on \
yakuake "  yakuake: A drop-down terminal emulator based on KDE konsole technology" on \
- "[ KDE games ]" off \
khangman "  khangman: Hangman Game" on \
kblocks "  kblocks: The classic falling blocks game" on \
kbreakout "  kbreakout: A Breakout-like game" on \
kmahjongg "  kmahjongg: A tile matching game for one or two players" on \
kmines "  kmines: The classic Minesweeper game" on \
knights "  knights: Chess board by KDE with XBoard protocol support" on \
kpat "  kpat: Offers a selection of solitaire card games" on \
ksudoku "  ksudoku: A logic-based symbol placement puzzle" on \
ktouch "  ktouch: Touch Typing Tutor" on \
picmi "  picmi: A nonogram logic game for KDE" on \
- "[ Themes and wallpapers ]" off \
zestiso-branding "  zestiso-branding: Show ZestISO in system info" on \
zestiso-wallpapers "  zestiso-wallpapers: ZestISO wallpapers" on \
)" | sed 's/"//g')"
OPT_PKG="firefox firefox-i18n-en-gb gparted libreoffice-fresh libreoffice-fresh-en-gb nano testdisk vlc bundle-filesystems bundle-wine discover dolphin-plugins filelight isoimagewriter kalarm kamoso kbackup kcharselect kcolorchooser kdeconnect kdepim-addons kdeplasma-addons kfind kgpg kmail kolourpaint krecorder krename ktimer ktorrent okteta okular plasma-vault sweeper yakuake khangman kblocks kbreakout kmahjongg kmines knights kpat ksudoku ktouch picmi zestiso-branding zestiso-wallpapers"
UNINSTALL_PKG=""; for PKG in $OPT_PKG; do
[[ " $PKG_SELECTION " != *" $PKG "* ]] && UNINSTALL_PKG="$UNINSTALL_PKG $PKG"
done
if [ ! -z "$UNINSTALL_PKG" ]; then
echo "The following packages have been de-selected and will now be uninstalled."
echo "After that, you will have to re-install them manually should you need them in the future:"
echo "$UNINSTALL_PKG"
pacman --noconfirm -Rus $UNINSTALL_PKG
fi
