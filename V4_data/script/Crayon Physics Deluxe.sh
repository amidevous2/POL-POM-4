#!/bin/bash

# Authors : Twinoatl
# Last Revision : 03/12/2009
# Maintener : berillions
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources" 
 
GAME_NAME="Crayon Physics Deluxe"
GAME_PREFIX="CrayonPhysicsDeluxe"
 
if [ "$POL_LANG" == "fr" ]
then
 
LNG_WAIT="Installation en cours..."
LNG_FILE="Veuillez sélectionner l'installeur de $GAME_NAME"
else
LNG_WAIT="Installing..."
LNG_FILE="Please select the $GAME_NAME installer"
fi
 
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$GAME_NAME" "Kloonigames" "http://www.crayonphysics.com/" "twinoatl" "$GAME_PREFIX"
 
select_prefix "$REPERTOIRE/wineprefix/$GAME_PREFIX"
POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

POL_SetupWindow_browse "$LNG_FILE" "$GAME_NAME" ""

POL_SetupWindow_wait_next_signal "$LNG_WAIT" "$GAME_NAME"
wine "$APP_ANSWER"
POL_SetupWindow_detect_exit
 
POL_SetupWindow_make_shortcut "${GAME_PREFIX}" "$PROGRAMFILES/Crayon Physics Deluxe" "crayon.exe" "" "${GAME_NAME}"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEsACgkQ5TH6yaoTykdyQQCdE3exuqQ+3DeLTqdujrcG9OQg
iOwAn2BXxLATjAG1+YQrOrQEXiSCPbnT
=A6c4
-----END PGP SIGNATURE-----
