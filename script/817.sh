#!/bin/bash
# Date : (2011-16-03 21:00)
# Last revision : (2013-06-20 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# Downloading DLL 
POL_Download_Resource "http://files.playonlinux.com/dinput8_dll.zip" "fa4bccb986f289d2bb8c7dbeb78b7380"

# Installing DLL
cd "$WINEPREFIX/drive_c/windows/temp"
unzip -o "$POL_USER_ROOT/ressources/dinput8_dll.zip"
if [ "$POL_ARCH" == "amd64" ]; then
	cp -f dinput8.dll ../syswow64/
else
	cp -f dinput8.dll ../system32/
fi

POL_Wine regsvr32 dinput8.dll

# Overriding dll
POL_Wine_OverrideDLL "native,builtin" "dinput8"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDhkUACgkQ5TH6yaoTykfOjwCfd6URJ4X9Muni3DlPpdZDIRdS
EugAmgL0M7v2JpAvahvvsVCliC8dHJbO
=QWT9
-----END PGP SIGNATURE-----
