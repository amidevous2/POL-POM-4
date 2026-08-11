#!/bin/bash
# Date : (2012-07-29 22-02)
# Last revision : (2019-10-30 10-53)
# Author : Quentin PÂRIS
 
# Installing DLL
POL_Download_Resource "http://web.archive.org/web/20160129053851/http://download.microsoft.com/download/E/6/A/E6A04295-D2A8-40D0-A0C5-241BFECD095E/W2KSP4_EN.EXE" "a4ef6c91d418418b287cefe31f958175"
 
cd "$WINEPREFIX/drive_c/windows/temp"
cabextract "$POL_USER_ROOT/ressources/W2KSP4_EN.EXE" -F i386/new/winhttp.dl_
cabextract i386/new/winhttp.dl_ -d i386/new
 
 
if [ "$POL_ARCH" = "amd64" ]; then
        cp -f i386/new/winhttp.dll ../syswow64/winhttp.dll
else
        cp -f i386/new/winhttp.dll ../system32/winhttp.dll
fi
 
# Overriding DLL
POL_Wine_OverrideDLL "native, builtin" "winhttp"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXc1PSQAKCRDlMfrJqhPK
RwGmAJ0Qrzukp1tes47jwKdOlay2H2bDaACeIl7rUE6tCMWtfyF2dK0rCZMZV8Y=
=OoIj
-----END PGP SIGNATURE-----
