#!/bin/bash
# PlayOnLinux Function
# Date : (2010-09-07 19:00)
# Last revision : (2021-10-18 17:51)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading MSvc80
cd "$POL_USER_ROOT"/ressources/
POL_Download_Resource "http://files.playonlinux.com/microsoft.vc80.crt.zip" "53accbf0e1e7a67415ddcdd44f8e226e" ""

# Installing MSvc80
POL_Wine_WaitBefore "MSvc80 DLLs"
cd "$WINEPREFIX"/drive_c/windows/temp
unzip "$POL_USER_ROOT"/ressources/microsoft.vc80.crt.zip
if [ "$POL_ARCH" = "amd64" ]; then
    cp Microsoft.VC80.CRT/*.* ../syswow64/
else
    cp Microsoft.VC80.CRT/*.* ../system32/
fi
rm -rf Microsoft.VC80.CRT

# Overriding dll
POL_Wine_OverrideDLL "native,builtin" "msvcr80"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxfkAAKCRDlMfrJqhPK
R79NAJoCXhWblQdwpFOQ2pVjfpoQJlrMwwCfbZdeozRT2G3yv4U26qZ+ypSOaeg=
=1rwn
-----END PGP SIGNATURE-----
