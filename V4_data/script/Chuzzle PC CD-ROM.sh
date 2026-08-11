#!/bin/bash
# Date : (2015-04-12 16-43)
# Wine version used : 
# Distribution used to test : OpenSuse 13.2
# Author : Benjamin Hardy
#
# CHANGELOG
# [Benjamin Hardy] (2015-04-12 16-43)
#   Initial writting.
# [Dadu042] (2020-04-01)
#   Wine 1.6.2 (outdated) -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Chuzzle PC CD-ROM"
PREFIX="chuzzle"
WORKING_WINE_VERSION="3.0.3"
SHORTCUT_NAME="Chuzzle"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2494
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "PopCap Games and Focus Multimedia Ltd." "" "Benjamin Hardy" "$PREFIX" 

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "popcdrun.txt"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

#The installer does not launch without directX already installed
POL_Call POL_Install_dxfullsetup

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$CDROM/PopCDRun.exe"

POL_Shortcut "Chuzzle.exe" "$SHORTCUT_NAME" "" "" "Game;"

POL_Wine_reboot

POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed. Please note, on some test computers the mouse pointer was found to not align with the graphics. When this happened, running the game within a 640x480 virtual desktop resoloved the problem')" "$TITLE"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXoUCIAAKCRDlMfrJqhPK
R9bhAJ4peI5tuLCYgX4hon/EC+CU9ZoaBACeN8D4QLEyruGf1c9sXPyFgeJMmh0=
=gJBt
-----END PGP SIGNATURE-----
