#!/bin/sh
## Create users
useradd -m arch; passwd -d arch; gpasswd -a arch wheel
passwd -d root

## Uncomment mirrors in pacman mirrorlist
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist

## Enable important system services
systemctl enable fstrim.timer systemd-timesyncd


## Initialise Pacman keyring
pacman-key --init
pacman-key --populate

## Add Chaotic-AUR keys
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB

## Replace mkinitcpio.conf so that mkinitcpio is properly configured for Arch install
mv /etc/mkinitcpio.conf.system /etc/mkinitcpio.conf

## Delete hooks/scripts only used for ArchISO image generation
sh -c "rm -- $(grep -Frl 'remove from airootfs' /etc/pacman.d/hooks/)"
rm -f /etc/pacman.d/scripts/archiso-setup.sh
