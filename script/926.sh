#!/bin/bash
# Date : (2011-08-18 21:00)
# Last revision : (2013-01-23 00:13)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Checking if GFWL is installed
if [ -e "$WINEPREFIX/drive_c/windows/system32/xlive/sqmapi.dll" -o -e "$WINEPREFIX/drive_c/windows/syswow64/xlive/sqmapi.dll" ]; then
	# Downloading GFWL
	# Since we cannot validate the file with a hash (changes too often), do not put it into resources
	# Otherwise in case of corrupted download, the only solution for the user is to clean his cache
	# Download is not that large anyway (~22MB)
	cd "$POL_USER_ROOT/tmp"
	POL_SetupWindow_download "$(eval_gettext 'Downloading Game For Windows Live...')" "$TITLE" "http://download.microsoft.com/download/D/6/0/D60F0E11-CF52-42B9-A13A-E7DAB124F08F/xliveredist.msi"

	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Remove Game For Windows Live...')" "$TITLE"
	# Product codes are located in [HKEY_LOCAL_MACHINE/Software/Microsoft/Windows/Current/Version/Uninstall]
	POL_Wine msiexec /uninstall xliveredist.msi /q

	# Removing dll Override
	POL_Wine_OverrideDLL "builtin" "xlive"
else
	POL_SetupWindow_message "$(eval_gettext 'Game For Windows Live is not installed\nskipping uninstall routine.')" "$TITLE"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlD/HTMACgkQ5TH6yaoTykd4gACfSd6DdiUe2ApKs3EwWA5ldM/N
RGkAn1W9KkctJsSm1OQalpTS2ylvbSmZ
=Rj4i
-----END PGP SIGNATURE-----
