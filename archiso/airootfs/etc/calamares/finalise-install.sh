#!/bin/bash
UNINSTALL_PKG=""
MarkPkgForRemoval() {
	(pacman -Qi $1 &> /dev/null) && UNINSTALL_PKG="$1 $UNINSTALL_PKG"
}

## Modify mkinitcpio preset
sed -i "/PRESETS=('archiso')/c\PRESETS=('default')" /etc/mkinitcpio.d/linux.preset

## Remove unnecessary services
echo "Disabling unnecessary services..."
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
echo "Uninstalling unnecessary packages..."
pacman --noconfirm -Rus $UNINSTALL_PKG &> /dev/null

echo "Marking packages as dependencies..."
pacman --asdeps -D bash iptables-nft libglvnd noto-fonts qt6-multimedia-gstreamer phonon-qt6-gstreamer-git wireplumber

## Enable sudo for wheel members
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/g_wheel

## Remove files needed only by ArchISO
rm -rf /etc/polkit-1/rules.d/49-nopasswd_global.rules \
/etc/sddm.conf.d/autologin.conf \
/etc/ssh/sshd_config.d/10-archiso.conf \
/etc/sudoers.d/g_wheel_nopasswd \
/etc/systemd/system/getty@tty1.service.d \
/etc/systemd/journald.conf.d/volatile-storage.conf \
/etc/systemd/system/getty@tty1.service.d/autologin.conf \
/etc/calamares

## Exit gracefully even if errors occurred
exit 0
