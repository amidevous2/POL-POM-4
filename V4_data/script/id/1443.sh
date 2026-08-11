#!/bin/bash
# Date : (2012-10-21 18-24)
# Last revision : (2014-06-28 16-17)
# Wine version used : 1.4.1, 1.5.15, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-10-21 18-24)
#   Initial script.
# [Pierre Etchemaite] (2014-06-28 16-17)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.6.2 (outdated) -> system.
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="sam_max_the_devils_playhouse"
PREFIX="SamAndMaxS3_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Sam and Max: The Devils Playhouse"
SHORTCUT_NAME1="Sam and Max S3E1: The Penal Zone"
SHORTCUT_NAME2="Sam and Max S3E2: The Tomb of Sammun-Mak"
SHORTCUT_NAME3="Sam and Max S3E3: They Stole Max's Brain!"
SHORTCUT_NAME4="Sam and Max S3E4: Beyond the Alley of the Dolls"
SHORTCUT_NAME5="Sam and Max S3E5: The City That Dares Not Sleep"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1443
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Telltale Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "eaed94182264460188c73ccf85eff2bc"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_d3dx9_36

# "/nogui" doesn't look required, did they fix something?
POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "SamMax301.exe" "$SHORTCUT_NAME1" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME1.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME1"
POL_Shortcut "SamMax302.exe" "$SHORTCUT_NAME2" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME2.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME2"
POL_Shortcut "SamMax303.exe" "$SHORTCUT_NAME3" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME3.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME3"
POL_Shortcut "SamMax304.exe" "$SHORTCUT_NAME4" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME4.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME4"
POL_Shortcut "SamMax305.exe" "$SHORTCUT_NAME5" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME5.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME5"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCZrAAKCRDlMfrJqhPK
R+eXAJ4uiRgHdRCkltks1nWemdGXUSc+OQCfbLkgVBQ6lbMSzqGQv5zrFSqLeh4=
=5+kU
-----END PGP SIGNATURE-----
