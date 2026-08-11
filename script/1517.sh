#!/bin/bash
# Date : (2012-12-21 16-46)
# Last revision : see changelog
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-12-21 16-46)
#   Initial script, for the GOG release.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.4.1 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="pharaoh_cleopatra"
PREFIX="PharaohCleopatra_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Pharaoh and Cleopatra"
SHORTCUT_NAME="Pharaoh Gold"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1517
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Impression Games / Activision" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "04631d3942f7e16fd5d96bf2238c0528"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "1"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Pharaoh.exe" "$SHORTCUT_NAME" "" "" "Game;StrategyGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Pharaoh Gold/Pharaoh - manual.pdf"
# C:\GOG Games\Pharaoh Gold\Readme.txt
# C:\GOG Games\Pharaoh Gold\Cleopatra - manual.pdf
# C:\GOG Games\Pharaoh Gold\Pharaoh - reference card.pdf
# C:\GOG Games\Pharaoh Gold\Pharaoh - Mission Editor Guide.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwxdgAKCRDlMfrJqhPK
R/U2AJ9CeOG27FyuAkMBEBxr7IIX4VLy5wCcD6LjNhA8SPs7nsnimI3VmgoWkwY=
=rykQ
-----END PGP SIGNATURE-----
