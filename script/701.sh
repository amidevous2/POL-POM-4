#!/bin/bash
# Date : (2012-07-29 22-02)
# Last revision : (2017-11-06 22:59)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com
  
# Installing DLL
POL_Download_Resource "https://web.archive.org/web/20061224003406/http://download.microsoft.com/download/5/0/c/50c42d0e-07a8-4a2b-befb-1a403bd0df96/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" "0c0f6e300800e49472e9b2e0890a09c1"
 
cd "$WINEPREFIX/drive_c/windows/temp"
cabextract "$POL_USER_ROOT/ressources/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" -F WININET.DLL
 
 
if [ "$POL_ARCH" = "amd64" ]; then
        cp -f WININET.DLL ../syswow64/wininet.dll
else
        cp -f WININET.DLL ../system32/wininet.dll
fi
 
# Overriding DLL
POL_Wine_OverrideDLL "native, builtin" "wininet"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRxdPwAKCRDlMfrJqhPK
R7/gAJ9vcWUqTw9CCvTZAe/jNPpUmXqofwCeI0f8eWvQvpLderVRFtAzTE0VVRc=
=xK3Q
-----END PGP SIGNATURE-----
