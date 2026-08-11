#!/bin/bash

# Date : (2010-18-03 21-00)
# Last revision : 
# Wine version used : 1.3.15, 1.3.23, 1.3.27
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2010-18-03 21-00)
#   Initial script.
# [Dadu042] (2020-02-23 23:41)
#   Standardize.
#   Wine 1.8.2 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dead Space II"
PREFIX="DEAD_SPACE_II"
EDITOR="Electronic Arts"
AUTHOR="WARHEAD"
GAME_VMS="512"
EXECUTABLE="easetup.exe"

POL_GetSetupImages "" "" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

WORKING_WINE_VERSION="3.0.3"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_SoundDriver "alsa"
Set_SoundEmulDriver "Y"
Set_OS "winxp"

POL_SetupWindow_InstallMethod "DVD"
if [ "$INSTALL_METHOD" == "DVD" ]; then
	POL_System_TmpCreate "$PREFIX"
	cd "$POL_System_TmpDir"
	chmod -R 777 "$POL_System_TmpDir"
	rm -R "$POL_System_TmpDir"
	mkdir -p "$POL_System_TmpDir"
        POL_SetupWindow_message "$(eval_gettext 'Please insert media 1 into your disk drive\nif not already done.')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "ds2dat0.dat"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
	cp -r "$CDROM"/* "$POL_System_TmpDir"
	chmod -R 777 "$POL_System_TmpDir"
	POL_Wine_WaitBefore "$TITLE"
        # DVD-ROM 2
        POL_SetupWindow_message "$(eval_gettext 'Please insert media 2 into your disk drive\nif not already done.')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "ds2dat4.dat"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
	cp -r "$CDROM"/* "$POL_System_TmpDir"
	chmod -R 777 "$POL_System_TmpDir"
	POL_Wine_WaitBefore "$TITLE"
	POL_Wine start /unix "$POL_System_TmpDir/$EXECUTABLE"
	POL_Wine_WaitExit "$TITLE"                 
	POL_System_TmpDelete
fi

POL_SetupWindow_VMS $GAME_VMS
POL_Wine_SetVideoDriver
POL_Wine_reboot
POL_Shortcut "deadspace2.exe" "Dead Space II" "" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlI7jwAKCRDlMfrJqhPK
R2loAKCiLAIUaoQGRPuZl1qkPCoTqlcFtwCePbBjqFducFyj08mxWVAcdS1XFEM=
=1mcQ
-----END PGP SIGNATURE-----
