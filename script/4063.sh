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
# [Dadu042] (2020-05-19 16:00)
#   64 bits compatible.
# [Dadu042] (2020-07-05 14:00)
#   Fix POL_Wine_WaitExit

if [ "$POL_ARCH" == "x32" ]; then
        POL_Debug_Fatal "$(eval_gettext '32-bit not supported')"
fi
 
FORCE_MODE=$1
 
# Downloading Mono 4.81
mkdir -p "$POL_USER_ROOT"/ressources/mono481_64b/
cd "$POL_USER_ROOT"/ressources/mono481_64b/
POL_Download_Resource "https://download.mono-project.com/archive/4.8.1/windows-installer/mono-4.8.1.0-x64-0.msi" "4f9b2e6ed0d1b3ab3d799f8cf34587d6" "mono481"
  
# Check if it is already installed
CHECK_MONO481=`find $WINEPREFIX -name "mono-4.8.1.dll"`
if [ "$CHECK_MONO481" == "" ] || [ "$FORCE_MODE" == "--force" ]; then
        POL_Wine start msiexec /i "mono-4.8.1.0-x64-0.msi" /silent
        POL_Wine_WaitExit "Mono"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXwIEWgAKCRDlMfrJqhPK
R8blAJ99Q9F2fztJzcu3ujnthE5WEIVGbACfeQ14W74pK4ayTjLMmbsNEEx7G/k=
=uw9c
-----END PGP SIGNATURE-----
