#!/bin/sh
## Create users
useradd -m live; passwd -d live; gpasswd -a live wheel
passwd -d root

## Uncomment mirrors in pacman mirrorlist
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist

## Enable important system services
systemctl enable fstrim.timer systemd-timesyncd

# Enable display manager
systemctl enable sddm || \
systemctl enable lightdm || \
systemctl enable gdm

## Initialise Pacman keyring
pacman-key --init
pacman-key --populate

## Add Chaotic-AUR keys
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB

## Replace mkinitcpio.conf so that mkinitcpio is properly configured for Arch install
cp -f /etc/mkinitcpio.conf.system /etc/mkinitcpio.conf

## Generate locales if not already done
[ $(localectl list-locales | grep -c ".UTF-8") -le 1 ] && locale-gen

## Delete hooks/scripts only used for ArchISO image generation
rm -f /etc/pacman.d/hooks/zzzz-archiso-setup.hook
rm -f /etc/pacman.d/scripts/archiso-setup.sh
