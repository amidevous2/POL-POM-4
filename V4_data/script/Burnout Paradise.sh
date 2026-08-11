#!/bin/bash
# Date : (2014-07-14)
# Wine version used : Latest
# Author : Anonymau5
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Burnout Paradise"
PREFIX="Burnout_Paradise"
 
EDITOR="Valve"
GAME_URL="http://store.steampowered.com/app/24740/"
AUTHOR="Anonymau5"
 
# Starting the script
# POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_SetID 1742
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
 
# Installing mandatory dependencies
POL_Call POL_Install_steam
 
# Begin game installation
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "steam.exe" steam://install/24740/
POL_Wine_WaitExit "$TITLE"
 
# Making shortcut
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/24740"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPFURUACgkQ5TH6yaoTykcj0ACeMJ2HVEr67zMDgbsFsVylmtgW
2/kAoK/yu2F36Wfkki/77QdSgD58Nclz
=hlN3
-----END PGP SIGNATURE-----
