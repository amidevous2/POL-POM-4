#!/bin/bash
# PlayOnLinux Function
# Date : (2019-12-24 19:20)
# Last revision : see changelog
# Author : Dadu042
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Dadu042] (2019-12-24 19:20)
#   First script.
# [Dadu042] (2020-01-09 12:50)
#   Fix comment.
#   Warn 64bits NOK.

if [ "$POL_ARCH" == "amd64" ]; then
        POL_Debug_Fatal "$(eval_gettext '64-bit not supported')"
fi

FORCE_MODE=$1
 
# Downloading Mono 3.12
mkdir -p "$POL_USER_ROOT"/ressources/mono312/
cd "$POL_USER_ROOT"/ressources/mono312/
POL_Download_Resource "https://download.mono-project.com/archive/3.12.1/windows-installer/mono-3.12.1-gtksharp-2.12.26-win32-0.msi" "6d71614574b15219d03df5bbfe501907" "mono312"
  
# Check if it is already installed
CHECK_MONO312=`find $WINEPREFIX -name "mono-3.12.1.dll"`
if [ "$CHECK_MONO312" == "" ] || [ "$FORCE_MODE" == "--force" ]; then
        POL_Wine start msiexec /i "mono-3.12.1-gtksharp-2.12.26-win32-0.msi" /silent
        POL_Wine_WaitEx
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhcVfAAKCRDlMfrJqhPK
R2x4AKCU4CKVQcpJ/CchwDti7JQyoZuocwCglAhY+p1Dp9cDeT4772UcnnAily0=
=+/YZ
-----END PGP SIGNATURE-----
