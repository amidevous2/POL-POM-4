#!/bin/bash
# PlayOnLinux Function
  
# Date : (2015-08-31 22-48)
# Author : Petch
# Licence :
# Depend : none
  
if [ "$POL_ARCH" = "amd64" ]; then
    cd "$WINEPREFIX/drive_c/windows/syswow64"
else
    cd "$WINEPREFIX/drive_c/windows/system32"
fi
POL_Call POL_SP2_Extract usp10.dll
POL_Wine_OverrideDLL "native,builtin" "usp10"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYW3e9AAKCRDlMfrJqhPK
R26zAJ4mEz1qW4eNxQj4jLF+VNB4zkfeAACdFpxfGoi1S7/MPxh2ul3RTunOtE0=
=ze8f
-----END PGP SIGNATURE-----
