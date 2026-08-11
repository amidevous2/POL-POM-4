#!/bin/bash
# PlayOnLinux Function
# Date : (2011-14-05 21-00)
# Last revision : (2019-03-04 22:17)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com


# Downloading XMLlite
mkdir -p "$POL_USER_ROOT"/ressources/xmllite
POL_Download_Resource "http://files.playonlinux.com/xmllite_dll.zip" "fb5af0866fdb619b952f96c4c9c0ab2a" "xmllite"
POL_Download_Resource "https://github.com/dankegel/winezeug/raw/master/winetricks_files/winetest.cat" "012c2f2e9a415688736e6e3f98db26f4" "xmllite"

# Installing XMLlite 
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing XMLlite...')" "$TITLE"
mkdir -p "$WINEPREFIX/drive_c/windows/system32/catroot/{f750e6c3-38ee-11d1-85e5-00c04fc295ee}"
cp -f "$POL_USER_ROOT"/ressources/xmllite/winetest.cat "$WINEPREFIX/drive_c/windows/system32/catroot/{f750e6c3-38ee-11d1-85e5-00c04fc295ee}/oem0.cat"

cd "$WINEPREFIX"/drive_c/windows/temp
unzip "$POL_USER_ROOT"/ressources/xmllite_dll.zip
if [ "$POL_ARCH" == "amd64" ]; then
	cp -f xmllite.dll ../syswow64/
else
	cp -f xmllite.dll ../system32/
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNaZ7AAKCRDlMfrJqhPK
RwvlAKCyscaWXPdmmnaYTW3lKMp8RA0ZWwCgpoYuUYDXCgHkW8X8QT5PI012E5I=
=/OWO
-----END PGP SIGNATURE-----
