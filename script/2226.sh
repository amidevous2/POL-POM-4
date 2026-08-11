#!/bin/bash
# Date : (2014-08-18 09-00)
# Distribution used to test : Kubuntu 14.04 - 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.4
  
POL_Debug_Message "Installing crypt32.dll..."

if [ "$POL_ARCH" = "amd64" ]; then
    Path32Bit="$WINEPREFIX/drive_c/windows/syswow64"
else
    Path32Bit="$WINEPREFIX/drive_c/windows/system32"
fi

cd "$POL_USER_ROOT/tmp"

POL_Call POL_SP2_Extract crypt32.dll
POL_Call POL_SP2_Extract msasn1.dll

cp "$POL_USER_ROOT/tmp/msasn1.dll" "$Path32Bit/msasn1.dll"
cp "$POL_USER_ROOT/tmp/crypt32.dll" "$Path32Bit/crypt32.dll"

POL_Wine_OverrideDLL "native, builtin" "crypt32.dll"
  
# Cleanup TMP folder
  
rm "$POL_USER_ROOT/tmp/crypt32.dll"
rm "$POL_USER_ROOT/tmp/msasn1.dll"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxfOwAKCRDlMfrJqhPK
R6e0AKCsw9jECMj7UL4rGGXP/3+Qo25I3gCfWQUcysKj7NbTrFUlagXwawzFv0Q=
=zDp1
-----END PGP SIGNATURE-----
