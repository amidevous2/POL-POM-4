# Prevent GoG installer from installing Acrobat Reader or Foxit in each prefix
POL_Call POL_Function_SetNativeExtension "pdf"

# Required for installer v2
POL_Call POL_Install_gdiplus

POL_Wine_WaitBefore "$TITLE"

POL_Wine "$POL_GoG_location" "$@" || POL_Debug_Fatal "$(eval_gettext 'Error while installing archive')"

GOGROOT="$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com"
[ -d "$GOGROOT" ] || GOGROOT="$WINEPREFIX/drive_c/GOG Games"

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlETgUkACgkQ5TH6yaoTykfzqwCdHcwOa4xSiZd1STF29r3KUH3+
ijsAn15TjuXc1kVmKZ/LiD+kfThCI+z7
=+pV7
-----END PGP SIGNATURE-----
