#!/bin/bash
# Date : (2013-02-09 17-55)
# Last revision : See changelog
# Wine version used : 1.4.1
# Distribution used to test : XUbuntu 19.04 x64
# Author : horsemanoffaith
#
# CHANGELOG
# [horsemanoffaith] (2013-02-09)
#   First script.
# [Dadu042] (2019-09-12)  with the GOG installer (contain game v1.2).
#   Add comments, game category.
#   Wine 1.4.1 -> 2.22 (because GUI issues with POL installer up to v1.9.24, Ubuntu 18.10)
# 
#
# KNOWN ISSUES
# - Screen resolution crashed (wrong frequency) after tring to optimise the display on a 1280x1024 monitor (by selecting 1024x768).
#   GPU involved was: PCI Nvidia. Only rebooting and using the iGPU Intel allowed me to retake access to the computer (OS: XUbuntu 19.04 x64).


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Nox"
PREFIX="Nox"
WORKING_WINE_VERSION="2.22"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

SHORTCUT_FILENAME="nox.exe"
SOFTWARE_CATEGORIES="Game;RolePlaying;"
GAME_VMS="4" 
 
POL_SetupWindow_Init
# For POL_System_CopyDirectory function
POL_RequiredVersion "4.0.18"
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Westwood Studios / Electronic Arts" "http://www.ea.com" "horsemanoffaith" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS winxp

# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "DVD,LOCAL"

if [ "$INSTALL_METHOD" == "DVD" ]; then

	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
 
	cd "$CDROM"
	POL_Wine "setup.exe"
	POL_Wine_WaitExit "$TITLE"
 
	mkdir "$POL_USER_ROOT/wineprefix/Nox/drive_c/Westwood/Nox/music"
	mkdir "$POL_USER_ROOT/wineprefix/Nox/drive_c/Westwood/Nox/movies"
 
	POL_System_CopyDirectory "$CDROM/install/music" "$POL_USER_ROOT/wineprefix/Nox/drive_c/Westwood/Nox/music"
	POL_System_CopyDirectory "$CDROM/install/movies" "$POL_USER_ROOT/wineprefix/Nox/drive_c/Westwood/Nox/movies"

	# Apply patch v1.2 
	#
	cd "$POL_USER_ROOT/wineprefix/Nox/drive_c/Westwood/Nox"
	POL_Download "http://files.playonlinux.com/NoxEng12.exe" "3080102586633a684fd64ea19f52f024"
	POL_Wine "NoxEng12.exe"

elif [ "$INSTALL_METHOD" == "LOCAL" ]; then

        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
#        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
#        POL_Shortcut_Document "$TITLE" "Readme.txt"
fi

POL_Shortcut "NOX.EXE" "$TITLE" "$TITLE.png" "" "$SOFTWARE_CATEGORIES"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXYqR1AAKCRDlMfrJqhPK
R2F5AJ9eGYhQMj8G30nD2eMmoBoq93n3OwCfQCza1ZQvoOw9kzYfJAlDWWLl910=
=S3cR
-----END PGP SIGNATURE-----
