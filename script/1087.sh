#!/bin/bash
# PlayOnLinux Function

# Date : (2012-03-03 18-48)
# Last revision : (2012-03-03 18-48)
# Author : SuperPlumus

# CHANGELOG
# [SuperPlumus] (2012-03-03 19-32)
#   Initial writting (for X3 : Terran Conflict)

cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "http://download.microsoft.com/download/E/E/1/EE17FF74-6C45-4575-9CF4-7FC2597ACD18/directx_feb2010_redist.exe" "4cf007a355cb5f34a3c5c400113b33c3"

POL_Wine_WaitBefore "DxDiag"

mkdir -p "$POL_USER_ROOT/tmp/dxdiag"
DXDIAG_TEMP="$POL_USER_ROOT/tmp/dxdiag"

cabextract -d "$DXDIAG_TEMP" -L -F "dxnt.cab" "$POL_USER_ROOT/ressources/directx_feb2010_redist.exe"

if [ "$POL_ARCH" = "amd64" ]; then
    cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F "dxdiag.exe" "$DXDIAG_TEMP/dxnt.cab"
    cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F "dxdiagn.dll" "$DXDIAG_TEMP/dxnt.cab"
else
    cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F "dxdiag.exe" "$DXDIAG_TEMP/dxnt.cab"
    cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F "dxdiagn.dll" "$DXDIAG_TEMP/dxnt.cab"
fi

mkdir -p "$WINEPREFIX/drive_c/windows/help"
cabextract -d "$WINEPREFIX/drive_c/windows/help" -L -F "dxdiag.chm" "$DXDIAG_TEMP/dxnt.cab"

POL_Wine_OverrideDLL native dxdiag.exe dxdiagn

POL_Call POL_Install_devenum
POL_Call POL_Install_quartz

rm -rf "$POL_USER_ROOT/tmp/dxdiag"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlCQmugACgkQ5TH6yaoTykeN7QCfXPeiU+wywP1XleUBPygCL4/7
z78AnR6P4uqDmGldTT81pkymrDvbKe19
=EfP8
-----END PGP SIGNATURE-----
