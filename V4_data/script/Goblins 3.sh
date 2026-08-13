#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Goblins 3"
PREFIX="Goblins3"

WINEVERSION="1.4-scummvm_support"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Coktel" "" "Tinou" "$PREFIX"
 
POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "This program requires $APPLICATION_TITLE 4.0.18"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "GOB3.EXE"
POL_SetupWindow_menu_num "$(eval_gettext 'Please select the game language')" "$TITLE" "$(eval_gettext 'English')~$(eval_gettext 'French')" "~"
if [ "$APP_ANSWER" = "0" ]; then
	LNG_ID="en"
	LNG_NAME="English"
fi
if [ "$APP_ANSWER" = "1" ]; then
	LNG_ID="fr"
	LNG_NAME="French"
fi


POL_Wine_WaitBefore "$TITLE"
mkdir -p "$WINEPREFIX/drive_c/Goblins3"

cd "$WINEPREFIX/drive_c/Goblins3" || POL_Debug_Fatal "Directory not found $WINEPREFIX/drive_c/Goblins3"

cat << EOF > gob3.polcfg
[gob3]
platform=pc
gameid=gob3
description=Gobliiins 3
language=$LNG_ID
guioptions=sndNoSpeech lang_$LNG_NAME
EOF

POL_System_CopyDirectory "$CDROM" "$WINEPREFIX/drive_c/Goblins3"

POL_Shortcut "gob3.polcfg"  "Goblins 3"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/LYZcACgkQ5TH6yaoTykeYvACgkOClqi1hoEyiHIOVV5Sb+/rF
gW4An3tGv2Od+iUDaDLGMtIDSw9Kp7kZ
=MUTa
-----END PGP SIGNATURE-----
