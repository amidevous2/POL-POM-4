#!/bin/bash
# Date : (2012-02-28 21-20)
# Last revision : (2013-11-20 22-20)
# Wine version used : 1.4, 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="incoming_incoming_forces"
PREFIX="IncomingForces_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Incoming and Incoming Forces"
SHORTCUT_NAME1="Incoming"
SHORTCUT_NAME2="Incoming Forces"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1080
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Rage Software / Kalypso Media Digital" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "01ff8a920b690790106cba00afa5e135"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# Needed for Incoming only
POL_Call POL_Install_vcrun2008

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "incoming.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME1"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Incoming and Incoming Forces/Incoming/Manual.pdf"
# C:\GOG Games\Incoming and Incoming Forces\Incoming\readme.txt

POL_Shortcut "forces.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Incoming and Incoming Forces/Incoming Forces/Manual.pdf"
# C:\GOG Games\Incoming and Incoming Forces\Incoming Forces\asc\language\manuals\English_readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKNLm8ACgkQ5TH6yaoTykdh7gCfbBSKEQsmf1qMvos9sfsqT7+v
XtgAnjeq/LkUpFL0OvJAWxPkwQT4Vnk+
=odDt
-----END PGP SIGNATURE-----
