#!/bin/bash
# Date : (2013-09-07)
# Last Revision : 
# Wine version used :
# Distribution used to test : Debian Jessie (Testing repositories)
# Author : VisitntX visitntx@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [VisitntX] (2013-09-07)
#   Initial script.
# [Dadu042] (2020-04-30 10-00)
#   Wine 4.1 -> 4.0.4 (more common)
#

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="blood_2_the_chosen_expansion"
PREFIX="Blood2TheChosen_gog"
WORKING_WINE_VERSION="4.0.4"

TITLE="GOG.com - Blood 2: The Chosen and The Nightmare Levels"
SHORTCUT_NAME="Blood 2 - The Chosen"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Monolith Productions / Interplay" "http://www.gog.com/en/gamecard/$GOGID" "VisitntX" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "270856258089999be199541c4f29af13"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

# Setting Windows Version
Set_OS winxp

# Cleaning Wine by rebooting
POL_Wine_reboot

POL_Shortcut "BLOOD2.exe" "$SHORTCUT_NAME" "" "" "Game;ActionGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/Blood II/Manual.pdf"

POL_SetupWindow_Close

exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqqN3AAKCRDlMfrJqhPK
R/CyAJ9Fo0eqb5VQmNK74oi1U6xoaIky7wCfUqzM4luwQ9MtGRs/VZKyRPFBfjE=
=VcLs
-----END PGP SIGNATURE-----
