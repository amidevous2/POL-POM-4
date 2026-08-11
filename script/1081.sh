# RealName: Microsoft Core Fonts

POL_Call POL_Internal_InstallFonts
OLDDIR="$PWD"
POL_Debug_Message "Installing microsoft fonts"
[ -z "$WINEPREFIX" ] && POL_Debug_Fatal "WINEPREFIX not set"

# It's a symlink? If yes, remove it
rm "$WINEPREFIX/drive_c/windows/Fonts" 2> /dev/null
mkdir -p "$WINEPREFIX/drive_c/windows/Fonts"

cp "$POL_USER_ROOT/fonts/"* "$WINEPREFIX/drive_c/windows/Fonts/"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO8PxMACgkQ5TH6yaoTykcx3gCeLtCbpHNi7yPaP7IhtLOOUz6K
fgQAniwWOISP8zVE2PjZkfCJwQQmJsQ4
=xsjP
-----END PGP SIGNATURE-----
