#!/bin/bash
# PlayOnLinux Function
# Date : (2010-06-11 21:00)
# Last revision : (2010-09-02 21:00)
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

APP=$1
MODE=$2
DLL=$3

cd "$POL_USER_ROOT/ressources"
if [ -e "$POL_USER_ROOT/ressources/app_dll_override.reg" ]; then
	rm -r app_dll_override.reg
fi

echo "REGEDIT4" > app_dll_override.reg
echo "" >> app_dll_override.reg
echo "[HKEY_CURRENT_USER\\Software\\Wine\\AppDefaults\\$APP\\DllOverrides]" >> app_dll_override.reg
until [ "$DLL" == "" ]; do
	if [ "$DLL" = "comctl32" ]; then
		rm -rf "$WINEPREFIX/winsxs/manifests/x86_microsoft.windows.common-controls_6595b64144ccf1df_6.0.2600.2982_none_deadbeef.manifest"
	fi
	echo "\"$DLL\"=\"$MODE\"" >> app_dll_override.reg
	shift
	DLL="$3"
done

POL_Wine regedit app_dll_override.reg
rm -rf app_dll_override.reg
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPNNGcACgkQ5TH6yaoTykefsACfbLCUMUeng1mIc56hrX0iaafV
EqoAn22z6W5SFeoIsehP/98yK7PFcYQV
=xCsH
-----END PGP SIGNATURE-----
