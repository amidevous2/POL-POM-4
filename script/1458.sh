#!/bin/bash
# PlayOnLinux Function
# Date : (2012-11-10 14:55)
# Last revision : (2012-11-10 15:14)
# Author : petch
# Only For : http://www.playonlinux.com

POL_Download_Resource "http://files.playonlinux.com/nop.zip" "a4bddfcad9e9b927eb1bfceaf289f6f0"

POL_Debug_Message "Installing nop.exe"

if [ "$POL_ARCH" = "amd64" ]; then
        targetdir="$WINEPREFIX/drive_c/windows/syswow64"
else
        targetdir="$WINEPREFIX/drive_c/windows/system32"
fi

POL_System_ExtractSingleFile "nop.zip" "nop.exe" "$targetdir/nop.exe"

while [ -n "$1" ]; do
    cp "$targetdir/nop.exe" "$1"
    shift
done

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlCeaz4ACgkQ5TH6yaoTykdJOACfSRiRHNMoS4V+i8E8HP7kUC7K
iu4An2PQXxRi1hvxLFTB0Odhm/lngf7a
=OFPk
-----END PGP SIGNATURE-----
