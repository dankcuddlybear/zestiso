#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="zestiso"
iso_label="ZEST_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="ZestISO <https://github.com/dankcuddlybear/zestiso>"
iso_application="ZestISO"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
	["/etc/pacman.d/scripts/archiso-setup.sh"]="0:0:755"
	["/etc/polkit-1/rules.d"]="0:0:750"
	["/etc/sudoers.d"]="0:0:750"
)
