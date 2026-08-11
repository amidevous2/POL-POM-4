#!/bin/bash
# Date : (2017-05-09 22:00)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Ubuntu 17.04 64bit
# Author : LinuxScripter
# Script licence : GPLv3
# Program licence : Proprietary
#
# CHANGELOG
# [LinuxScripter] (2017-05-09)
#   First script.
# [Dadu042] (2019-12-08)
#   Wine 2.0.3 -> 2.22
#   Fix category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Cultures 2 Gates of Asgard"
PREFIX="Cultures2"
EDITOR="JoWood"
AUTHOR="LinuxScripter"
WORKING_WINE_VERSION="2.22"
  
# Starting the script
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$AUTHOR" "$PREFIX"
  
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Downloading wine if necessary and creating 32-bit prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Installing mandatory dependencies
  
POL_SetupWindow_InstallMethod "DVD,LOCAL"
if [ "$INSTALL_METHOD" = "DVD" ]; then
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Cultures.ico"
POL_Wine start /unix "$CDROM/Setup.exe"
POL_Wine_WaitExit "$TITLE"
else
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
fi
  
# Making shortcut
POL_Shortcut "Cultures2.exe" "$TITLE" "" "" "Game;StrategyGame"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXe1opAAKCRDlMfrJqhPK
R8j7AJ9wJJzEwhbcObFxqtFqHlnw+PZgTgCfT8OZLGMvII2ceXvJKSNl9DE2Uog=
=Gcad
-----END PGP SIGNATURE-----
