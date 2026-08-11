#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Robot Karol"
PREFIX="RobotKarol"
WINEVERSION="1.8.1"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Landesministerium Bayern" "www.mebis.bayern.de" "Bleuzen" "$PREFIX"
 
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

Set_OS "win7"
 
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"

POL_Wine "$APP_ANSWER"

POL_SetupWindow_wait "$(eval_gettext 'Waiting for installation to finish')" "$TITLE"
 
POL_Shortcut "karol.exe" "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUSWgAAKCRDlMfrJqhPK
R8QfAJ9THX2WZtynsal2kL2sQ0TGJyC3sACgiNaCqo3Vyn3zLOu36VH1+KhQEgk=
=UCdH
-----END PGP SIGNATURE-----
