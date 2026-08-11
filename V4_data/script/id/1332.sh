#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Marine Malice 2 : Le Mystère de l'Ecole Hantée"
PREFIX="MarineMalice2"

WINEVERSION="1.4-scummvm_support"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Ubisoft" "" "Tinou" "$PREFIX"
 
POL_RequiredVersion 4.0.18 || POL_Debug_Fatal "This program requires $APPLICATION_TITLE 4.0.18"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "FREDDI2.EXE"

LNG_ID="fr"
LNG_NAME="French"

POL_Wine_WaitBefore "$TITLE"
mkdir -p "$WINEPREFIX/drive_c/Marine2"

cd "$WINEPREFIX/drive_c/Marine2" || POL_Debug_Fatal "Directory not found $WINEPREFIX/drive_c/Marine2"

cat << EOF > freddi2.polcfg
[freddi2]
platform=pc
gameid=freddi2
description=Marine Malice 2
language=$LNG_ID
guioptions=sndNoSpeech lang_$LNG_NAME
subtitles=false
EOF

POL_System_CopyDirectory "$CDROM" "$WINEPREFIX/drive_c/Marine2"

POL_Shortcut "freddi2.polcfg"  "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlAO0BIACgkQ5TH6yaoTykdmaQCdFkOx4+oso13Ewx7S/J5n16UK
cTkAn3f1J2+VbTVbvSHsnJPYBhgkioeY
=EIBR
-----END PGP SIGNATURE-----
