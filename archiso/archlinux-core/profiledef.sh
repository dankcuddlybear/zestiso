#!/usr/bin/env bash
# shellcheck disable=SC2034
iso_name="arch"
iso_label="ARCH_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%y%m%d)"
iso_publisher="ZestISO <https://github.com/dankcuddlybear/zestiso>"
iso_application="ARCH"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz')
bootstrap_tarball_compression=('xz')
file_permissions=(
  ["/usr/share/libalpm/scripts/archiso-setup.sh"]="0:0:755"
)
