#!/bin/bash
# Date : (2011-17-07 21-00)
# Last revision : (2013-06-20 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading DLL 
POL_Download_Resource "http://files.playonlinux.com/wintrust_dll.zip" "561b8b996bcad43fc6d05853cd39fc6b"

# Installing DLL
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing wintrust DLL...')" "$TITLE"
cd "$WINEPREFIX/drive_c/windows/temp"
unzip "$POL_USER_ROOT/ressources/wintrust_dll.zip"
if [ "$POL_ARCH" == "amd64" ]; then
	cp -f wintrust.dll ../syswow64/
else
	cp -f wintrust.dll ../system32/
fi

POL_Wine regsvr32 wintrust.dll

# Overriding dll
POL_Call POL_Function_OverrideDLL "native" "wintrust"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDhGoACgkQ5TH6yaoTykfizQCcCLmMYXTbUjFFfxE9BhSG1C1x
hRQAnA6o550zAppBLnekyyZXh6MA+tmh
=lsfG
-----END PGP SIGNATURE-----
