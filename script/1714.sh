#!/bin/bash
# Date : (2013-05-25 16-00)
# Last revision : (2013-05-31 22-00)
# Wine version used : 1.4.1
# Distribution used to test : Fedora 17
# Author : TonyFlow
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="imperialism_2_the_age_of_exploration"
PREFIX="Imperialism2_gog"
WORKING_WINE_VERSION="1.4.1"
 
TITLE="GOG.com - Imperialism 2: The Age of Exploration"
SHORTCUT_NAME="Imperialism II - Age of Exploration"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1714
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Frog City Software / Ubisoft" "http://www.gog.com/gamecard/$GOGID" "TonyFlow" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "49c71a331613c1476ffa00a8bd982029"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install
 
# The game require a cdrom drive, in order to avoid the
# the "D:\Epsilon\win_cd.cpp@407 _winCdPlay" error popup
ln -sf / "$WINEPREFIX/dosdevices/p:"
cat <<_EOFINI_ > "$POL_USER_ROOT/tmp/cdrom.reg"
REGEDIT4
 
[HKEY_LOCAL_MACHINE\Software\Wine\Drives]
"P:"="cdrom"
_EOFINI_
# Define the cdrom drive into the registry
POL_Wine regedit.exe "$POL_USER_ROOT/tmp/cdrom.reg"
rm "$POL_USER_ROOT/tmp/cdrom.reg"
 
# "800x600 16bit"
POL_SetupWindow_VMS "1"
 
# GoG work!
Set_OS winxp
 
# Doesn't hurt ;)
POL_Wine_reboot
 
GOGPATH="$GOGROOT/Imperialism II - Age of Exploration"
POL_Shortcut "Imperialism II.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGPATH/Imperialism II - Manual.pdf"
#POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGPATH/Imperialism II - Tech Tree.pdf"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGpQNEACgkQ5TH6yaoTykeiBgCfccURvQ4RW3yJKmwpwpZKhcEm
h2EAnA4lCrZJY1yFoT7bnlX5A5GZi46j
=mImW
-----END PGP SIGNATURE-----
