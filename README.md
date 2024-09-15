ZestISO is a set of scripts and presets to easily customise, build and install Arch Linux.

The official Arch Linux releases are built with archiso, so this is what I am using for ZestISO. Archiso reads a custom profile (preset) and builds the ISO (the Arch Linux boot/install media).
You can specify what software/services you want to include, system configuration and first-boot setup, ISO info/build options and more.
ArchISO has a few limitations however:
 - The only supported boot loaders are Syslinux for legacy BIOS systems, and GRUB or Systemd-boot for modern UEFI systems.
 - ArchISO only supports booting an initramfs created with mkinitcpio using udev (busybox) init system. Systemd init and Dracut/Booster are not supported.

In the ZestISO software repositories, you'll find custom software packages and bundles to help you quickly and easily install and configure software and services. Each package includes all the necessary components required for use, and when installed, will set up everything for you. There is no need to do anything manually, just install the package and you're done.
Here are some of the most important packages available:
 - Networking
 - Cellular modems
 - Bluetooth
 - Printing and scanning
 - A choice of graphical desktop environments including KDE Plasma and XFCE (sorry, those are the only ones right now).
