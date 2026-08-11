# Date : (2015-08-23 09-45)
# Author : Petch

if [ "$POL_ARCH" = "amd64" ]; then
    cd "$WINEPREFIX/drive_c/windows/syswow64"
else
    cd "$WINEPREFIX/drive_c/windows/system32"
fi
POL_Call POL_SP2_Extract mspatcha.dll
POL_Wine_OverrideDLL "native,builtin" "mspatcha"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxfZgAKCRDlMfrJqhPK
R+oEAJ0XXooBW0Aog8IOcdFRNAxee6u2+QCfVLFbhU4whVZJpcu0S16oof3twfA=
=OQrb
-----END PGP SIGNATURE-----
