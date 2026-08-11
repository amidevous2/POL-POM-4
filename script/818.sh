#!/bin/bash
# Date : (2011-03-16 21:00)
# Last revision : (2021-10-18 17:52)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading MSvc90
cd "$POL_USER_ROOT/ressources/"
POL_Download_Resource "http://files.playonlinux.com/microsoft.vc90.crt.zip" "710598c9c1d03fc913146a9aa6681db8" ""

# Installing MSvc90
POL_Wine_WaitBefore "MSvc90 DLLs"
cd "$WINEPREFIX/drive_c/windows/temp"
unzip "$POL_USER_ROOT/ressources/microsoft.vc90.crt.zip"
if [ "$POL_ARCH" = "amd64" ]; then
    cp Microsoft.vc90.crt/*.* ../syswow64/
else
    cp Microsoft.vc90.crt/*.* ../system32/
fi
rm -rf Microsoft.vc90.crt

# Overriding dll
POL_Wine_OverrideDLL "native,builtin" "msvcr90"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxfvQAKCRDlMfrJqhPK
R8HWAJ4338t99DDwqNYeGxHX57/MfFiB1wCfXsPk5YzDgH8w6JeOsn7q6RwNw5U=
=+dTE
-----END PGP SIGNATURE-----
