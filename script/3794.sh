#!/bin/bash
# PlayOnLinux Function
# Date : (2020-01-09 13:01)
# Last revision : see changelog
# Author : Dadu042
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Dadu042] (2020-01-09 13:01)
#   First script.
# [Dadu042] (2020-07-05 14:00)
#   Fix POL_Wine_WaitExit
# [Dadu042] (2022-03-30 14:00)
#   Fix download path.

if [ "$POL_ARCH" == "amd64" ]; then
        POL_Debug_Fatal "$(eval_gettext '64-bit not supported.')"
fi

FORCE_MODE=$1
 
# Download Mono
mkdir -p "$POL_USER_ROOT"/ressources/mono5.20/
cd "$POL_USER_ROOT"/ressources/mono5.20/
POL_Download_Resource "https://download.mono-project.com/archive/5.20.1/windows-installer/mono-5.20.1.34-gtksharp-2.12.45-win32-0.msi" "4b86ba73fe7f7bd2db74777c4e9d44f2" "mono5.20"
  
# Check if it is already installed
CHECK_MONO481=`find $WINEPREFIX -name "mono-5.20.1.dll"`
if [ "$CHECK_MONO481" == "" ] || [ "$FORCE_MODE" == "--force" ]; then
        POL_Wine start msiexec /i "mono-5.20.1.34-gtksharp-2.12.45-win32-0.msi" /silent
        POL_Wine_WaitExit "Mono"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYkR5OwAKCRDlMfrJqhPK
R+rsAJ4inBJzuzwae3h0pKHoiUK7w9nmeACcDmHiCDVtXv7erQK593jJ0+JxeW4=
=1HJh
-----END PGP SIGNATURE-----
