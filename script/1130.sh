mkdir -p "$WINEPREFIX/drive_c/windows/Resources/Themes/luna"
cd "$WINEPREFIX/drive_c/windows/Resources/Themes/luna"

POL_Download_Resource "$SITE/divers/luna.msstyles" "ece435ddcbeeed521b7da04d4bf0881c"
cp "$POL_USER_ROOT/ressources/luna.msstyles" "$WINEPREFIX/drive_c/windows/Resources/Themes/luna/"
POL_Download_Resource "$SITE/divers/luna.reg" "36eeed3521d1b5e2c3c52d30ced6d1ee"

POL_Wine regedit "$POL_USER_ROOT/ressources/luna.reg"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/sRTAACgkQ5TH6yaoTykc3zgCdHNMKbvn+tO5aEpQODF2N+tkA
+HcAn1JaR3o0V9BfKpYqFOC/+BBwOWWv
=gZpU
-----END PGP SIGNATURE-----
