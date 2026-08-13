#!/bin/bash
# Date : (2012-05-18 16-10)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Ubuntu 12.04 LTS
# Author : Jan Nytra jannytra@seznam.cz
#    updated by Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Jan Nytra] (2012-05-18 16-10)
#   Initial script.
# [Pierre Etchemaite] (2013-11-26 20-44)
#   ?
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.4.1 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="knights_and_merchants_the_peasants_rebellion"
PREFIX="KnightsAndMerchantsTPR_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Knights and Merchants: The Peasants Rebellion"
SHORTCUT_NAME="Knights and Merchants: The Peasants Rebellion"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1271
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Joymania Development / TopWare Interactive " "http://www.gog.com/gamecard/$GOGID" "Jan Nytra" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "b8c40001f25a429f2e35d8a216e74ced"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "KM_TPR.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Knights and Merchants - The Peasants Rebellion/manual.pdf"
# C:\GOG Games\Knights and Merchants - The Peasants Rebellion/readme.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYaZQAKCRDlMfrJqhPK
RwBlAJ9qJlRvS/iLwbhoSF/K7Y3/X6AhcgCfbNP+RInITRWbMhthIP8OLY39pLg=
=F+FA
-----END PGP SIGNATURE-----
