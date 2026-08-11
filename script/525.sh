#!/bin/bash
# PlayOnLinux Function
 
# Date : (2009-11-19 21-50)
# Author : Berillions
# Licence : 
# Depend : none
 
if [ "$POL_ARCH" = "amd64" ]; then
    cd "$WINEPREFIX/drive_c/windows/syswow64"
else
    cd "$WINEPREFIX/drive_c/windows/system32"
fi
POL_Call POL_SP2_Extract riched20.dll
POL_Wine_OverrideDLL "native,builtin" "riched20"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxf1AAKCRDlMfrJqhPK
R9gRAKCYh82KRuf4/Fl2ItPnSUoDEM5LxwCgsCNhglH9YJFsdKueep0slm9Lf/0=
=krRY
-----END PGP SIGNATURE-----
