#!/bin/bash
# PlayOnLinux Function

# Date : (2012-03-03 19-48)
# Last revision : (2012-03-03 19-48)
# Author : SuperPlumus

# CHANGELOG
# [SuperPlumus] (2012-03-03 19-49)
#   Initial writting (for X3 : Terran Conflict)

cd "$POL_USER_ROOT/ressources"
POL_Download_Resource "http://download.microsoft.com/download/E/E/1/EE17FF74-6C45-4575-9CF4-7FC2597ACD18/directx_feb2010_redist.exe" "4cf007a355cb5f34a3c5c400113b33c3"

POL_Wine_WaitBefore "amstream.dll"

mkdir -p "$POL_USER_ROOT/tmp/amstream"

cabextract -d "$POL_USER_ROOT/tmp/amstream" -L -F "dxnt.cab" "$POL_USER_ROOT/ressources/directx_feb2010_redist.exe"

if [ "$POL_ARCH" = "amd64" ]; then
    cabextract -d "$WINEPREFIX/drive_c/windows/syswow64" -L -F "amstream.dll" "$POL_USER_ROOT/tmp/amstream/dxnt.cab"
else
    cabextract -d "$WINEPREFIX/drive_c/windows/system32" -L -F "amstream.dll" "$POL_USER_ROOT/tmp/amstream/dxnt.cab"
fi

POL_Wine regsvr32 amstream.dll
POL_Wine_OverrideDLL native amstream

rm -rf "$POL_USER_ROOT/tmp/amstream"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlBUxK8ACgkQ5TH6yaoTykd6BACgkWh97ABHolbgx+p/kKalhPqp
VxAAn1wjZIVF+6LYrzJqtTo+dydaqbCq
=nyiI
-----END PGP SIGNATURE-----
