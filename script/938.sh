#!/bin/bash
# Date : Unknown
# Last revision : (2021-10-18 18:32)
# Author : Tinou
# Updated by : GNU_Raziel
# Only For : http://www.playonlinux.com
# Used by old games like Rayman 2

if [ "$POL_ARCH" = "amd64" ]; then
    cd "$WINEPREFIX/drive_c/windows/syswow64"
else
    cd "$WINEPREFIX/drive_c/windows/system32"
fi
POL_Call POL_SP2_Extract dinput.dll

# Overriding DLL
POL_Wine_OverrideDLL "native,builtin" "dinput"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxgUAAKCRDlMfrJqhPK
R71TAKCIZXr2IvauH+wUWPYT+BFT8e+kWgCfbxk18eiellZgmauW25Mc++W0ag8=
=4poG
-----END PGP SIGNATURE-----
