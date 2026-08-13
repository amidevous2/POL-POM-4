#!/bin/bash
# Date : (2009-05-25 12-45)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : N/A
# Author : Tinou
# Licence : Retail
#
# CHANGELOG
# [Tinou] (2009-05-25 12-45)
#   Initial script.
# [Dadu042] (2020-01-16 22:00)
#   Wine 1.2.1-ddraw -> 2.22

# Translated from V2 to V3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

VERSIONWINE="2.22"
TITLE="Worms World Party"
PREFIX="WormsWorldParty" 
 

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Team 17" "http://www.team17.com" "Tinou" "$PREFIX" 

POL_Wine_SelectPrefix "$PREFIX"
POL_SetupWindow_prefixcreate "$VERSIONWINE"

if [ "$POL_SELECTED_FILE" ]; then
	SetupFile="$POL_SELECTED_FILE"
else
	POL_SetupWindow_InstallMethod "CD,LOCAL"
	if [ "$INSTALL_METHOD" = "CD" ]; then
		POL_SetupWindow_cdrom

                POL_SetupWindow_check_cdrom "installer/Setup.exe"
                SetupFile="$CDROM/installer/Setup.exe"
        fi
 
        if [ "$INSTALL_METHOD" = "LOCAL" ]; then
                cd "$HOME"
                POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
                SetupFile="$APP_ANSWER"
        fi
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupFile"

cd "$WINEPREFIX/drive_c/Team17/Worms World Party"
POL_Download "$SITE/divers/Worms_World_Party_Patch_SP1.exe" "d1ebc3c034cdf04cebdb159c1eb31a6b"
unzip Worms_World_Party_Patch_SP1.exe
Set_Managed off

POL_Shortcut "wwp.exe" "Worms World Party" "" "" "Game;"
Set_Desktop On 800 600
wineserver -k
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDSFgAKCRDlMfrJqhPK
R5XFAJ0cNG/fpI4IJxZ7JH5h1XxWhqvSlgCgmNnhQ1QTjMYuGKFHPoYmKwTa/UY=
=F+/Z
-----END PGP SIGNATURE-----
