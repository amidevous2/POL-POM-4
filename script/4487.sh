#!/bin/bash
# PlayOnLinux Function
# Date : see changelog
# Last revision : see changelog
# Author : Dadu042
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Dadu042] (2022-03-30 13:00)
#   First script. Add 64bits support.


FORCE_MODE=$1
  
# Download Mono
mkdir -p "$POL_USER_ROOT"/ressources/mono6.12.0/
cd "$POL_USER_ROOT"/ressources/mono6.12.0/

if [ "$POL_ARCH" == "x86" ]; then
    POL_Download_Resource "https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0-gtksharp-2.12.45-win32-0.msi" "ffe866680cbac4fc9e8e20e52277efa9" "mono6.12.0"
fi
if [ "$POL_ARCH" == "amd64" ]; then
    POL_Download_Resource "https://download.mono-project.com/archive/6.12.0/windows-installer/mono-6.12.0-x64-0.msi" "27626b057fdeca298cd11f79ee73cf17" "mono6.12.0"
fi

   
# Check if it is already installed
CHECK_MONO481=`find $WINEPREFIX -name "mono-6.12.0.dll"`
if [ "$CHECK_MONO481" == "" ] || [ "$FORCE_MODE" == "--force" ]; then

    if [ "$POL_ARCH" == "x86" ]; then
        POL_Wine start msiexec /i "mono-6.12.0-gtksharp-2.12.45-win32-0.msi" /silent
        POL_Wine_WaitExit "Mono"
    fi
    if [ "$POL_ARCH" == "amd64" ]; then
        POL_Wine start msiexec /i "mono-6.12.0-x64-0.msi" /silent
        POL_Wine_WaitExit "Mono"
    fi

fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYm530QAKCRDlMfrJqhPK
R33xAJ9FaAy38WBlXPjpWqGteIC1TjuZiQCfV18IHraW697VFzhPWF4UQNxws+Y=
=O8UO
-----END PGP SIGNATURE-----
