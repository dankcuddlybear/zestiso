#!/bin/bash
## Modify mkinitcpio preset
sed -i "/PRESETS=('archiso')/c\PRESETS=('default')" /etc/mkinitcpio.d/linux.preset

## Show software selection dialog
chmod +x /etc/calamares/select-software.sh
/etc/calamares/select-software.sh

## Remove unnecessary packages
UNINSTALL_PKG=""; echo "Detecting hardware..."
MarkPkgForRemoval() {
	for PKG in $@; do (pacman -Qi $PKG &> /dev/null) && UNINSTALL_PKG="$1 $UNINSTALL_PKG"; done
}
if (! (lspci | grep "VGA" | grep -i "Advanced Micro Devices" &> /dev/null)) && \
(! (lspci | grep "VGA" | grep "AMD" &> /dev/null)) && \
(! (lspci | grep "VGA" | grep "ATI" &> /dev/null)); then
	MarkPkgForRemoval bundle-amd-gpu
fi; if (! (lspci | grep "VGA" | grep "Intel" &> /dev/null)); then
	MarkPkgForRemoval bundle-intel-gpu
fi; if (! (lspci | grep "VGA" | grep -i "NVIDIA" &> /dev/null)); then
	MarkPkgForRemoval bundle-nvidia-foss bundle-nvidia-pro bundle-nvidia-pro-340xx bundle-nvidia-pro-390xx bundle-nvidia-pro-470xx bundle-nvidia-pro-525xx
	MarkPkgForRemoval cuda cuda-tools cudnn libva-nvidia-driver \
	nvidia nvidia-dkms nvidia-lts nvidia-open nvidia-open-dkms nvidia-prime nvidia-settings nvidia-utils \
	nvtop opencl-nvidia vulkan-nouveau xf86-video-nouveau \
	lib32-nvidia-utils lib32-opencl-nvidia lib32-vulkan-nouveau lib32-nvidia-390xx-utils lib32-nvidia-470xx-utils lib32-nvidia-525xx-utils \
	lib32-nvidia-utils-beta lib32-opencl-nvidia-390xx lib32-opencl-nvidia-470xx lib32-opencl-nvidia-525xx lib32-opencl-nvidia-beta \
	libva-nvidia-driver-git nouveau-fw nvidia-340xx nvidia-340xx-dkms nvidia-340xx-settings nvidia-340xx-utils \
	nvidia-390xx-dkms nvidia-390xx-settings nvidia-390xx-utils nvidia-470xx-dkms nvidia-470xx-settings nvidia-470xx-utils \
	nvidia-525xx-dkms nvidia-525xx-settings nvidia-525xx-utils nvidia-beta-dkms nvidia-exec nvidia-open-beta nvidia-open-beta-dkms \
	nvidia-open-dkms-git nvidia-open-git nvidia-settings-beta nvidia-utils-beta opencl-nvidia-340xx opencl-nvidia-390xx opencl-nvidia-470xx \
	opencl-nvidia-525xx opencl-nvidia-beta physx
fi; if (! (lspci | grep -i "VMware" &> /dev/null)) && \
(! (lsusb | grep -i "VMware" &> /dev/null)); then
	systemctl --now disable vmtoolsd vmware-vmblock-fuse &> /dev/null
	MarkPkgForRemoval open-vm-tools gtkmm3 libxtst
fi; if (! (lspci | grep -i "Hyper-V" &> /dev/null)) && \
(! (lsusb | grep -i "Hyper-V" &> /dev/null)); then
	systemctl --now disable hv_fcopy_daemon hv_kvp_daemon hv_vss_daemon &> /dev/null
	MarkPkgForRemoval hyperv
fi; if (! (lspci | grep -i "VirtualBox" &> /dev/null)) && \
(! (lsusb | grep -i "VirtualBox" &> /dev/null)); then
	systemctl --now disable vboxservice &> /dev/null
	MarkPkgForRemoval virtualbox-guest-utils virtualbox-guest-utils-nox
fi; if (! (lspci | grep -i "Virtio" &> /dev/null)) && \
(! (lspci | grep -i "QXL" &> /dev/null)) && \
(! (lspci | grep -i "Cirrus" &> /dev/null)) && \
(! (lsusb | grep -i "Virtio" &> /dev/null)); then
	systemctl --now disable qemu-guest-agent &> /dev/null
	MarkPkgForRemoval qemu-guest-agent
fi
echo "Cleaning up packages..."
pacman --noconfirm -Rus $UNINSTALL_PKG &> /dev/null
pacman --asdeps -D bash iptables-nft lib32-sdl12-compat libglvnd noto-fonts ntfs-3g qt6-multimedia-gstreamer phonon-qt6-gstreamer-git polkit wireplumber &> /dev/null

echo "Finalising install..."

## Enable sudo for wheel members
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/g_wheel

## Remove files needed only by ArchISO
rm -rf /etc/polkit-1/rules.d/49-nopasswd_global.rules \
/etc/sddm.conf.d/autologin.conf \
/etc/sudoers.d/g_wheel_nopasswd \
/etc/systemd/system/getty@tty1.service.d \
/etc/systemd/journald.conf.d/volatile-storage.conf \
/etc/systemd/system/getty@tty1.service.d/autologin.conf
rm -rf /etc/calamares

## Exit gracefully even if errors occurred
exit 0
