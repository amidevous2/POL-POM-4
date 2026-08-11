#!/bin/bash
# Date : (2011-01-08 21-00)
# Last revision : (2013-06-20 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading DLL 
POL_Download_Resource "http://files.playonlinux.com/mfc42_dll.zip" "f5dd68a47a94dd7daff780e262dc4095"
POL_Download_Resource "http://files.playonlinux.com/mfc42u_dll.zip" "3ab284635aa5eb0eed2c7c680d77d6c6"

# Installing DLL
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing mfc42 DLLs...')" "$TITLE"
cd "$WINEPREFIX"/drive_c/windows/temp
unzip "$POL_USER_ROOT"/ressources/mfc42_dll.zip
unzip "$POL_USER_ROOT"/ressources/mfc42u_dll.zip
if [ "$POL_ARCH" == "amd64" ]; then
	cp -f mfc42.dll ../syswow64/
	cp -f mfc42u.dll ../syswow64/
else
	cp -f mfc42.dll ../system32/
	cp -f mfc42u.dll ../system32/
fi

POL_Wine regsvr32 mfc42.dll
POL_Wine regsvr32 mfc42u.dll

# Overriding dll
POL_Call POL_Function_OverrideDLL "native" "mfc42" "mfc42u"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDhJQACgkQ5TH6yaoTykf1yACeOX8xg/XMgZo80eeSmcEAG0gQ
DsQAnRS+O94LX630RGYMVpwj3mQ2qGoz
=bd4q
-----END PGP SIGNATURE-----
