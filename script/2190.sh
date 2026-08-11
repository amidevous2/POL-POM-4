#!/bin/bash
# Date : (2012-05-15 15-33)
# Last revision : (2014-07-20 22-47)
# Wine version used : 1.7.8
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="lionheart_legacy_of_the_crusader"
PREFIX="Lionheart_gog"
WORKING_WINE_VERSION="1.7.8"

TITLE="GOG.com - Lionheart: Legacy of the Crusader"
SHORTCUT_NAME="Lionheart: Legacy of the Crusader"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Reflexive Entertainment / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "f96963f2621970ab07f65a9760e68136"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Lionheart.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Lionheart - Legacy of the Crusader/MANUAL.PDF"
# C:\GOG Games\Lionheart - Legacy of the Crusader\ReadMe.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPMM9wACgkQ5TH6yaoTykdRRwCfew3T1GwJNMnckMjyYKpW3GlW
Fr0An3qRA4q9WBxb0rKgoQ/BrQcWdP3p
=LhEZ
-----END PGP SIGNATURE-----
