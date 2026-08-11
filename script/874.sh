#!/bin/bash
# Date : (2011-17-07 21-00)
# Last revision : (2013-06-20 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading DLL 
POL_Download_Resource "http://files.playonlinux.com/msasn1_dll.zip" "aad8973e4c071b14c600448a44e3a86a"

# Installing DLL
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing msasn1 DLL...')" "$TITLE"
cd "$WINEPREFIX/drive_c/windows/temp"
unzip "$POL_USER_ROOT/ressources/msasn1_dll.zip"
if [ "$POL_ARCH" == "amd64" ]; then
	cp -f msasn1.dll ../syswow64/
else
	cp -f msasn1.dll ../system32/
fi

# Overriding dll
POL_Call POL_Function_OverrideDLL "native" "msasn1"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDhVcACgkQ5TH6yaoTykfdSgCfT39n12f/92DmcZ7qvbV4kSme
shoAmwfSL+GATYhG0xQ/4G0QOMcfffWD
=E8mb
-----END PGP SIGNATURE-----
