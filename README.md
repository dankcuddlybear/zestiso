# ZestISO
ZestISO is a collection of tools to help create your own free Arch Linux based operating system. You can install it on as many devices as you want, and each one will be set-up and ready to go with your favourite software and settings.

## How the build process works
The official Arch Linux releases are built with archiso, so this is what I am using for ZestISO. Archiso reads a custom profile (preset) and builds the ISO (the Arch Linux boot/install media).
You can specify what software/services you want to include, system configuration and first-boot setup, ISO info/build options and more.
ArchISO has a few limitations however:
 - The only supported boot loaders are Syslinux for legacy BIOS systems, and GRUB or Systemd-boot for modern UEFI systems.
 - ArchISO only supports booting an initramfs created with mkinitcpio using udev (busybox) init system. Systemd init and Dracut/Booster are not supported.

## ZestISO software repositories
In the ZestISO software repositories, you'll find custom software packages and bundles to help you quickly and easily install and configure software and services. Each package includes all the necessary components required for use, and when installed, will set up everything for you. There is no need to do anything manually, just install the package and you're done.
Here are some of the most important packages available:
 - Networking
 - Cellular modems
 - Bluetooth
 - Printing and scanning
 - A choice of graphical desktop environments including KDE Plasma and XFCE (sorry, those are the only ones right now).

## Building ZestISO
You will need a computer running Arch Linux x86_64.
1) Install required dependencies while updating databases and installed packages:
```
sudo pacman --needed -Syu archiso base-devel git
```
2) Clone the ZestISO Github repository, and enter the ZestISO ArchISO profile folder:
```
git clone https://github.com/dankcuddlybear/zestiso.git
cd zestiso/zestiso-profile
```
3) To add or remove repositories, edit pacman.conf. This configuration file is only used to build the ISO. These repositories will not be available in the final image after booting. To add repositories to the final image, you need to edit airootfs/etc/pacman.conf.
4) By default, the core, extra, multilib, zestiso and chaotic-aur repositories are enabled. For ArchISO the alci_repo repository is also enabled (needed for Calamares installer). If you want to use Chaotic-AUR, you will need to first add the keys and mirrorlist to your system:
```
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
```
Make sure you also add keys for other repositories you need if necessary.
4) Edit packages.x86_64 to include whatever software packages you want. Do not remove any entries with warnings not to remove them.
5) The file profiledef.sh defines properties for the ISO, such as the filename, label, version, file permissions and more. Bootloader configuration is found inside the folders grub (for UEFI) and syslinux (for BIOS). The airootfs folder contains files to include in the root filesystem in the final ISO image. See https://gitlab.archlinux.org/archlinux/archiso/-/blob/master/docs/README.profile.rst for more information.
6) The file airootfs/etc/pacman.d/scripts/archiso-setup.sh is a script that will finish setting up the ISO after pacman has finished installing packages. For example, uncomment mirrors in the pacman mirrorlist, enable services, initialise pacman keyring and add keys. The script will automatically add keys for Chaotic-AUR. Make sure to add commands to add keys for any custom repositories you need. Make sure to enable whatever services you need.
7) OPTIONAL: configure default hostname (airootfs/etc/hostname), system locale (airootfs/etc/locale.conf and airootfs/etc/locale.gen), console keyboard layout and font (airootfs/etc/vconsole.conf) and timezone (ln -sf /usr/share/zoneinfo/Region/City airootfs/etc/localtime).
8) Go back to the zestiso folder. If you have 16GB RAM or less, run this command to build the ISO:
```
sudo mkarchiso -v ./zestiso-profile
```
If you have more than 16GB RAM, you can use the /tmp directory in RAM to avoid storing temporary files on the disk:
```
sudo mkarchiso -v -w /tmp/zestiso-tmp ./zestiso-profile
```
