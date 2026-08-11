 #!/bin/bash
# Date : (2014-10-11 17-01)
# Wine version used : 1.6.2
# Distribution used to test : OpenSuse 13.1
# Author : Benjamin Hardy

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - Omikron: The Nomad Soul"
PREFIX="omikron"
WORKING_WINE_VERSION="1.6.2"
SHORTCUT_NAME="Omikron"
GOGID="omikron_the_nomad_soul"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Quantic Dream" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "b1dc7b912b2fdd604d434c1d73fda9dd"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

Set_OS win7
# virtual desktop required to avoid crash on launch
Set_Desktop On 800 600

POL_Wine_reboot

POL_Shortcut "Runtime.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Omikron - The Nomad Soul/Omikron the Nomad Soul - Manual.pdf"

POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlQ5ZyQACgkQ5TH6yaoTykepdQCcCRDeWHHElwFoL33BH5Qvt5gm
y50AnjsRAvskH6ysaWUid+8YFp/uepfA
=wKng
-----END PGP SIGNATURE-----
