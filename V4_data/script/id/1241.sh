#!/bin/bash
# Date : (2012-06-03 00-19)
# Last revision : (2013-06-29 18-09)
# Wine version used : 1.4.1, 1.5.5
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="kingpin_life_of_crime"
PREFIX="KingpinLOC_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Kingpin: Life of Crime"
SHORTCUT_NAME="Kingpin: Life of Crime"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1241
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Xatrix Entertainment / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "b2084430278605d5b2670a5a3293096a"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "kingpin.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
# Report a shorter version string http://www.linuxpoweruser.com/?cat=6
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'export __GL_ExtensionStringVersion=17700'
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Kingpin - Life of Crime/MANUAL.PDF"
# C:\GOG Games\Kingpin - Life of Crime\readme.txt
# C:\GOG Games\Kingpin - Life of Crime\kprad\radiant.exe (QERadiant Editor)

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHPOs4ACgkQ5TH6yaoTykd74gCdENuhW2sRWXQlEAASPvZKnUPE
zHAAn1nustX+6q3teQsIcfddzpRePmpE
=J/+3
-----END PGP SIGNATURE-----
