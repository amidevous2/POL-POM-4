#!/bin/bash
# Date : (2011-03-04 21:00)
# Last revision : (2021-10-18 17:49)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading MSvc100
POL_Download_Resource "http://files.playonlinux.com/microsoft.vc100.crt.zip" "5fc2ade663d069f4a0f98ad6d45beabe" ""

# Installing MSvc100
POL_Wine_WaitBefore "MSvc100 DLLs"
cd "$WINEPREFIX/drive_c/windows/temp"
unzip "$POL_USER_ROOT/ressources/microsoft.vc100.crt.zip"
if [ "$POL_ARCH" = "amd64" ]; then
    cp Microsoft.VC100/* ../syswow64/
else
    cp Microsoft.VC100/* ../system32/
fi
rm -rf Microsoft.VC100

# Overriding dll
POL_Wine_OverrideDLL "native,builtin" "msvcr100"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxfdAAKCRDlMfrJqhPK
RyBcAJ9Chp5bJbcUAdgVm1bfYrwn7C3YNgCfWDSM/CkCN9mKhYC/A+mwWHMHcic=
=n8ks
-----END PGP SIGNATURE-----
