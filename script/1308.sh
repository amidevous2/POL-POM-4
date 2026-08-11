POL_Debug_LogToPrefix "Installing MFC40.DLL"
POL_Wine_WaitBefore "MFC40.DLL"

POL_Download_Resource "https://web.archive.org/web/20070316220826/http://activex.microsoft.com/controls/vc/mfc40.cab" "57b92899066e127dcb578b36ac6f6f4d"
cabextract -d "$POL_USER_ROOT/tmp" "$POL_USER_ROOT/ressources/mfc40.cab"

if [ "$POL_ARCH" = "amd64" ]; then
    cd "$WINEPREFIX/drive_c/windows/syswow64"
else
    cd "$WINEPREFIX/drive_c/windows/system32"
fi

cabextract "$POL_USER_ROOT/tmp/mfc40.exe" -F '*40.dll'
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlbYYDIACgkQ5TH6yaoTykfAtACgrurOxjvzUQzjjn5j3Pu+m2mN
fc8An1lTrQijO9oDPZ18tKTX/GlBe2ae
=xL89
-----END PGP SIGNATURE-----
