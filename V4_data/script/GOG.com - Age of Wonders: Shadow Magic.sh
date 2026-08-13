#!/bin/bash
# Date : (2011-12-11 20-52)
# Last revision : see changelog
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-10-27 16-07)
#   Initial script.
# [Dadu042] (2020-01-19 22:00)
#  Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="age_of_wonders_shadow_magic"
PREFIX="AgeOfWonders3_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Age of Wonders: Shadow Magic"
SHORTCUT_NAME="Age of Wonders: Shadow Magic"
SHORTCUT_EDITOR="$SHORTCUT_NAME - $(eval_gettext 'Editor')"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1020
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Triumph Studios" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "bf8bb46a311c729feabf09602600ae97"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_Call POL_Install_directplay

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Direct3D: off; Cursor: colors
cat <<_EOFINI_ > "$POL_USER_ROOT/tmp/aow3_video.reg"
REGEDIT4

[HKEY_CURRENT_USER\Software\Triumph Studios\Age of Wonders Shadow Magic\Video]
"Cursor Mode"=dword:00000002
"Use Direct3D"=dword:00000000
_EOFINI_
POL_Wine regedit "$POL_USER_ROOT/tmp/aow3_video.reg"
rm "$POL_USER_ROOT/tmp/aow3_video.reg"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Launcher.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "AoWSMCompat" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Age of Wonders - Shadow Magic/QuickStart.pdf"
# C:\GOG Games\Age of Wonders - Shadow Magic\Readme.html

# C:\GOG Games\Age of Wonders - Shadow Magic\AoWSMSetup.exe
#POL_Shortcut "AoWSMEd.exe" "$SHORTCUT_EDITOR" "$SHORTCUT_NAME - Editor.png" "" "Game;StrategyGame;"

POL_Shortcut "AoWSM.exe" "$SHORTCUT_NAME (alternate)" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
# Now the trick: Shadow magic needs a "slow" wineserver to be responsive!
# http://appdb.winehq.org/objectManager.php?sClass=version&iId=3101&iTestingId=14987
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME (alternate)" "POL_Wine_AutoSetVersionEnv"
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME (alternate)" "wineserver -k"
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME (alternate)" "nice -19 wineserver"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYaWAAKCRDlMfrJqhPK
RyflAJ9ztEdErNDEMp4YIePbv75UgG2ldwCggg/7hUVvDpvB9oQV8Rp23utPfhI=
=nGeC
-----END PGP SIGNATURE-----
