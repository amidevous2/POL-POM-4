#!/bin/bash
# Date : (2012-06-16 17-38)
# Last revision : changelog
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-16 17-38)
#   Initial script.
# [Pierre Etchemaite] (2013-12-13 01-17)
#   ?
# [Dadu042] (2020-03-20 19:30). Script tested with GOG v2.0.0.9.
#   Wine 1.4.1 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="commandos_2_3"
PREFIX="Commandos_2_3_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Commandos 2 and 3"
SHORTCUT_NAME1="Commandos 2: Men of Courage"
SHORTCUT_NAME2="Commandos 3: Destination Berlin"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1258
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Pyro Studios / Digital Game Factory" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 3 "d6a7a1edbfbd67c299bd6a06ad12213d" "1edd8f72249d94e1990ec578ac49b1d1" "de6ec7365d8044bad1f6325d60103e66"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "comm2.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Commandos 2 and 3/Commandos 2/Manual.PDF"
# C:\GOG Games\Commandos 2 and 3\Commandos 2\Readme.rtf

POL_Shortcut "Commandos3.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Commandos 2 and 3/Commandos 3/manual.pdf"
# C:\GOG Games\Commandos 2 and 3\Commandos 3\Readme.rtf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYXmgAKCRDlMfrJqhPK
R7xjAJ9wK3fN6dckjOMr/CxLDua2JDBqXgCfanfm6PED7qJWO3LJL5bUTsoOAqE=
=39v+
-----END PGP SIGNATURE-----
