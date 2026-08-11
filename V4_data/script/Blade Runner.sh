#!/bin/bash
# Date : (2014-10-19 16-55)
# Revised : (2015-04-13 15:34)
# Wine version used : 1.7.28
# Distributions used to test : openSUSE 13.1 and openSUSE 13.2
# Author : Benjamin Hardy

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Blade Runner"
PREFIX="bladerunner"
# The installer has issues identifying a sound card with 1.6.2, but works correctly with 1.7.28
WINE_VERSION="1.7.28"
SHORTCUT_NAME="Blade Runner"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2312
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Westwood Studios" "" "Benjamin Hardy" "$PREFIX"  

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "cd1/outtake1.mix"

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$CDROM/setup/install.exe"

POL_Shortcut "blade.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_VMS "2"

POL_Wine_reboot

POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed. Before launching the game each time, please ensure that disk one is in the drive and that the drive has been mounted.')" "$TITLE"

POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlUsDMMACgkQ5TH6yaoTykeLTwCghp+uZz2JDlPtaUVAATCWcLXm
IIoAn37crBz0HsrR654jR52EwE1ThSPl
=upZO
-----END PGP SIGNATURE-----
