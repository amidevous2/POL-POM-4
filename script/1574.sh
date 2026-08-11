POL_SetupWindow_wait "Please wait while we are fixing your Steam installation ..." "$TITLE"

sleep 2

POL_LoadVar_PROGRAMFILES
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"

for file in package/*; do unzip -o $file; done

POL_debug_message "Steam fixed"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlEiSq8ACgkQ5TH6yaoTykf6ggCfeR4AYyAqhWgf5vdZXhzqAtxY
+v0AnjXbhI7m8W0J03e1IomMWFmNIfIG
=IbaZ
-----END PGP SIGNATURE-----
