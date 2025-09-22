#!/bin/bash
## Automatically remove drivers for GPUs not present
UNNEEDED_PKGS=""
if (! (lspci | grep -i "VGA compatible controller: NVIDIA" &> /dev/null)); then
    echo "No NVIDIA gpus found, drivers will be uninstalled."
	UNNEEDED_PKGS="$UNNEEDED_PKGS bundle-nvidia-free"
	UNNEEDED_PKGS="$UNNEEDED_PKGS bundle-nvidia-pro"
	UNNEEDED_PKGS="$UNNEEDED_PKGS bundle-nvidia-pro-340xx"
	UNNEEDED_PKGS="$UNNEEDED_PKGS bundle-nvidia-pro-390xx"
	UNNEEDED_PKGS="$UNNEEDED_PKGS bundle-nvidia-pro-470xx"
	UNNEEDED_PKGS="$UNNEEDED_PKGS bundle-nvidia-pro-525xx"
else echo "Found NVIDIA GPU(s)"; fi
if (! (lspci | grep -i "VGA compatible controller: Intel" &> /dev/null)); then
    echo "No Intel gpus found, drivers will be uninstalled."
	UNNEEDED_PKGS="$UNNEEDED_PKGS bundle-intel-gpu"
else echo "Found Intel GPU(s)"; fi
if (! (lspci | grep -i "VGA compatible controller: Advanced Micro Devices" &> /dev/null)); then
    echo "No AMD gpus found, drivers will be uninstalled."
	UNNEEDED_PKGS="$UNNEEDED_PKGS bundle-amd-gpu"
else echo "Found AMD GPU(s)"; fi

## Automatically remove microcode for CPUs not present
CPU_VENDOR_ID="$(lscpu | grep -i "Vendor ID:" | cut -d ':' -f 2 | xargs)"
[ -z "$CPU_VENDOR_ID" ] && CPU_VENDOR_ID="GenericCPU"
if [ "$CPU_VENDOR_ID" != "GenuineIntel" ]; then
    echo "No Intel CPU found, microcode will be uninstalled."
	UNNEEDED_PKGS="$UNNEEDED_PKGS intel-ucode"
else echo "Found Intel CPU"; fi
if [ "$CPU_VENDOR_ID" != "AuthenticAMD" ]; then
    echo "No AMD CPU found, microcode will be uninstalled."
	UNNEEDED_PKGS="$UNNEEDED_PKGS amd-ucode"
else echo "Found AMD CPU"; fi

## Check which unneeded packages are still present, and add them to a list to uninstall
PKGS_TO_UNINSTALL=""
echo "Checking installed packages..."
for PKG in $UNNEEDED_PKGS; do
    pacman -Qi $PKG &> /dev/null && PKGS_TO_UNINSTALL="$PKGS_TO_UNINSTALL $PKG"
done
echo "To remove: $PKGS_TO_UNINSTALL"

## Uninstall unneeded packages
pacman --noconfirm -Rus $PKGS_TO_UNINSTALL

echo "Marking dependencies..."
pacman --asdeps -D bash gnu-free-fonts iptables-nft lib32-sdl12-compat libglvnd mkinitcpio noto-fonts ntfs-3g qt6-multimedia-gstreamer pacman phonon-qt6-gstreamer-git polkit wireplumber

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

## Enable sudo for wheel members
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/10_wheel

## Remove files needed only by ArchISO
(pacman -Qi lightdm &> /dev/null) || rm -rf /etc/lightdm
rm -f /version /etc/mkinitcpio.conf.system /etc/sudoers.d/10-installer
rm -rf /etc/calamares

## Exit gracefully even if errors occurred
exit 0
