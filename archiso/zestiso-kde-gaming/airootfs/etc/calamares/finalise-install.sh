#!/bin/bash
UNINSTALL_PKG=""
MarkPkgForRemoval() {
	(pacman -Qi $1 &> /dev/null) && UNINSTALL_PKG="$1 $UNINSTALL_PKG"
}

## Create mkinitcpio preset
rm /etc/mkinitcpio.d/*.preset
KERNEL_NAME="$(ls /boot/vmlinu* | cut -d ' ' -f 1 | cut -c 15-)"
echo "# mkinitcpio preset file for the '$KERNEL_NAME' package" > /etc/mkinitcpio.d/$KERNEL_NAME.preset
echo >> /etc/mkinitcpio.d/$KERNEL_NAME.preset
echo "#ALL_config=\"/etc/mkinitcpio.conf\"" >> /etc/mkinitcpio.d/$KERNEL_NAME.preset
echo "ALL_kver=\"/boot/vmlinuz-$KERNEL_NAME\"" >> /etc/mkinitcpio.d/$KERNEL_NAME.preset
echo >> /etc/mkinitcpio.d/$KERNEL_NAME.preset
echo "PRESETS=('default')" >> /etc/mkinitcpio.d/$KERNEL_NAME.preset
echo "#default_config=\"/etc/mkinitcpio.conf\"" >> /etc/mkinitcpio.d/$KERNEL_NAME.preset
echo "default_image=\"/boot/initramfs-$KERNEL_NAME.img\"" >> /etc/mkinitcpio.d/$KERNEL_NAME.preset
echo "#default_uki=\"/efi/EFI/Linux/arch-$KERNEL_NAME.efi\"" >> /etc/mkinitcpio.d/$KERNEL_NAME.preset
echo "#default_options=\"--splash /usr/share/systemd/bootctl/splash-arch.bmp\"" >> /etc/mkinitcpio.d/$KERNEL_NAME.preset

## Remove unnecessary services
echo "Removing unnecessary packages..."
if (! (lspci | grep -i "VMware" &> /dev/null)) && \
(! (lsusb | grep -i "VMware" &> /dev/null)); then
	systemctl --now disable vmtoolsd vmware-vmblock-fuse &> /dev/null
	MarkPkgForRemoval open-vm-tools; MarkPkgForRemoval gtkmm3; MarkPkgForRemoval libxtst
fi
if (! (lspci | grep -i "Hyper-V" &> /dev/null)) && \
(! (lsusb | grep -i "Hyper-V" &> /dev/null)); then
	systemctl --now disable hv_fcopy_daemon hv_kvp_daemon hv_vss_daemon &> /dev/null
	MarkPkgForRemoval hyperv
fi
if (! (lspci | grep -i "VirtualBox" &> /dev/null)) && \
(! (lsusb | grep -i "VirtualBox" &> /dev/null)); then
	systemctl --now disable vboxservice &> /dev/null
	MarkPkgForRemoval virtualbox-guest-utils; MarkPkgForRemoval virtualbox-guest-utils-nox
fi
if (! (lspci | grep -i "Virtio" &> /dev/null)) && \
(! (lspci | grep -i "QXL" &> /dev/null)) && \
(! (lspci | grep -i "Cirrus" &> /dev/null)) && \
(! (lsusb | grep -i "Virtio" &> /dev/null)); then
	systemctl --now disable qemu-guest-agent &> /dev/null
	MarkPkgForRemoval qemu-guest-agent
fi
if (! (lspci | grep -i "VGA compatible controller: NVIDIA" &> /dev/null)); then
	MarkPkgForRemoval bundle-nvidia-free
	MarkPkgForRemoval bundle-nvidia-pro
	MarkPkgForRemoval bundle-nvidia-pro-340xx
	MarkPkgForRemoval bundle-nvidia-pro-390xx
	MarkPkgForRemoval bundle-nvidia-pro-470xx
	MarkPkgForRemoval bundle-nvidia-pro-525xx
fi
if (! (lspci | grep -i "VGA compatible controller: Intel" &> /dev/null)); then
	MarkPkgForRemoval bundle-intel-gpu
fi
if (! (lspci | grep -i "VGA compatible controller: Advanced Micro Devices" &> /dev/null)); then
	MarkPkgForRemoval bundle-amd-gpu
fi
if [ "$(lscpu | grep -i "Vendor ID:" | cut -d ':' -f 2 | xargs)" != "GenuineIntel" ]; then
	MarkPkgForRemoval intel-ucode
fi
if [ "$(lscpu | grep -i "Vendor ID:" | cut -d ':' -f 2 | xargs)" != "AuthenticAMD" ]; then
	MarkPkgForRemoval amd-ucode
fi
MarkPkgForRemoval arch-install-scripts
MarkPkgForRemoval archinstall
MarkPkgForRemoval boost1.86-libs
MarkPkgForRemoval calamares
MarkPkgForRemoval edk2-shell
MarkPkgForRemoval memtest86+
MarkPkgForRemoval memtest86+-efi
MarkPkgForRemoval mkinitcpio-archiso
MarkPkgForRemoval mkinitcpio-netconf
MarkPkgForRemoval mkinitcpio-nfs-utils
MarkPkgForRemoval pv
MarkPkgForRemoval syslinux
MarkPkgForRemoval zestiso-archiso-files
MarkPkgForRemoval zestiso-archiso-files-dev
MarkPkgForRemoval zestiso-branding

echo "Uninstalling unnecessary packages..."
pacman --noconfirm -Rus $UNINSTALL_PKG &> /dev/null

echo "Marking dependencies..."
pacman --asdeps -D bash gnu-free-fonts iptables-nft lib32-sdl12-compat libglvnd mkinitcpio noto-fonts ntfs-3g qt6-multimedia-gstreamer pacman phonon-qt6-gstreamer-git polkit wireplumber &> /dev/null

## Enable sudo for wheel members
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/10_wheel

## Remove files needed only by ArchISO
(pacman -Qi lightdm &> /dev/null) || rm -rf /etc/lightdm
rm -f /etc/mkinitcpio.conf.system /etc/sudoers.d/10-installer
rm -rf /etc/calamares

## Exit gracefully even if errors occurred
exit 0
