if [ "$POL_ARCH" = "amd64" ]; then
    cd "$WINEPREFIX/drive_c/windows/syswow64"
else
    cd "$WINEPREFIX/drive_c/windows/system32"
fi
POL_Debug_Message "Installing atmlib.dll"
 
POL_Call POL_SP2_Extract atmlib.dll
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYW3fCwAKCRDlMfrJqhPK
Rzh0AJ48x/1F7jjePqSbqZHK9IS5B0CMowCghHjRzeshwA2fzvVup31o4qA5VgM=
=xdjF
-----END PGP SIGNATURE-----
