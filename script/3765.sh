#!/bin/bash
# PlayOnLinux Function
# Date : (2019-12-24 18:25)
# Last revision : see changelog
# Author : Dadu042
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Dadu042] (2019-12-24 18:25)
#   First script.
# [Dadu042] (2020-01-09 12:50)
#   Fix comment.
#   Warn 64bits NOK.
# [Dadu042] (2020-07-05 14:00)
#   Fix POL_Wine_WaitExit

if [ "$POL_ARCH" == "amd64" ]; then
        POL_Debug_Fatal "$(eval_gettext '64-bit not supported')"
fi

FORCE_MODE=$1

# Downloading Mono 4.81
mkdir -p "$POL_USER_ROOT"/ressources/mono481/
cd "$POL_USER_ROOT"/ressources/mono481/
POL_Download_Resource "https://download.mono-project.com/archive/4.8.1/windows-installer/mono-4.8.1.0-gtksharp-2.12.44-win32-0.msi" "78227471a45a764a7e0b834c05be15aa" "mono481"
 
# Check if it is already installed
CHECK_MONO481=`find $WINEPREFIX -name "mono-4.8.1.dll"`
if [ "$CHECK_MONO481" == "" ] || [ "$FORCE_MODE" == "--force" ]; then
        POL_Wine start msiexec /i "mono-4.8.1.0-gtksharp-2.12.44-win32-0.msi" /silent
        POL_Wine_WaitExit "Mono"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXwID9wAKCRDlMfrJqhPK
R5c2AJ4i4vkvmri7YdX/9u1pZqDRt1JN8gCdE//uSr+AOV/Tt6b3J9E5TCx/aKA=
=kgap
-----END PGP SIGNATURE-----
