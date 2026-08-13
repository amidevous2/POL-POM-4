#!/bin/bash
# Date : (2013-09-06)
# Last Revision : x
# Wine version used : 
# Distribution used to test : Debian Jessie (Testing repositories)
# Author : VisitntX visitntx@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [VisitntX] (2013-09-06)
#   Initial script.
# [Dadu042] (2020-04-29 13-00)
#   Wine 1.4.1 -> 4.0.4

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="daikatana"
PREFIX="Daikatana_gog"
WORKING_WINE_VERSION="4.0.4"

TITLE="GOG.com - Daikatana"
SHORTCUT_NAME="Daikatana"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1817
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ion Storm Inc. / Square Enix" "http://www.gog.com/en/gamecard/$GOGID" "VisitntX" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "af495c91f8e334cee3c7e853e1a29d13"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# Setting the Windows Version
Set_OS winxp

# Cleaning Wine by rebooting
POL_Wine_reboot

POL_Shortcut "daikatana.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Daikatana/Daikatana_-_Manual_-_PC.pdf"

POL_SetupWindow_Close

exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqqOdQAKCRDlMfrJqhPK
R2IzAJ9FEP+lL0b6Q9/hRSfhS414skXzlACfaw/42YHYirz75O3m1wUAq62326k=
=YwJ5
-----END PGP SIGNATURE-----
