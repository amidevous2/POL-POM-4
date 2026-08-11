#!/bin/bash
# Distribution used to test : Fedora 12
# Depend : ImageMagick, unzip

# CHANGELOG
# [Quentin PÂRIS] (2014 ?)
#   First script.
# [Dadu042] (2019-11-14)
#   Wine 1.7.40 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

## Note : Try to install this patch ftp://largedownloads.ea.com/pub/patches/battlefield_1942_patch_v1.6.19.exe to fix no-cd problem

TITLE="Battlefield 1942"
PREFIX="Battlefield1942"
WINEVERSION="2.22"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Blizzard" "http://www.electronicarts.com" "Quentin PÂRIS" "$PREFIX" 

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
S
POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" = "CD" ]; then
	POL_Call POL_Wine_InstallCDROM "1" "w" "Setup.exe"
	SetupFile="$CDROM/Setup.exe"
fi

if [ "$INSTALL_METHOD" = "LOCAL" ]; then 
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SetupFile="$APP_ANSWER"
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$SetupFile"

if [ "$INSTALL_METHOD" = "CD" ]; then
	POL_Call POL_Wine_InstallCDROM "2" "w" "data1.cab"
fi

POL_Wine_WaitExit

POL_Shortcut "BF1942.exe" "$TITLE" "" "" "Game;Shooter"
POL_SetupWindow_message "$(eval_gettext 'Be careful! To run $TITLE with $APPLICATION_TITLE, you must install a No-CD patch even if you have a legal version.\n\nPlease remember that $APPLICATION_TITLE is strongly against piracy, and will never support it.')" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iFsEABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXr+HRgAKCRDlMfrJqhPK
R6sQAJjOVcto413I02mmN0mzYpMYWp0WAJdznxDXQrb+Lz0aZZZyg7rUWhV2
=YQ6c
-----END PGP SIGNATURE-----
