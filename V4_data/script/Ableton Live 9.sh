#!/bin/bash
# Date : (2013-01-14 ??-??)
# Last revision : (2013-11-06 13-01)
# Distribution used to test : Kubuntu 12.04 LTS 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.1.9

# CHANGELOG
# [SuperPlumus] (2013-05-20 18-56)
#   gettext
# [SuperPlumus] (2013-09-20 21-13)
#   Fix bug #2861 (multiple executable name is possible)
#   Clean code
# [SuperPlumus] (2013-11-06 13-01)
#   Fix bug #3156 and #3543 (Still other executable...)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Ableton Live 9"
PREFIX="AbletonLive9"
WORKING_WINE_VERSION="3.19"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_RequiredVersion "4.1.9" || POL_Debug_Fatal "$APPLICATION_TITLE 4.1.9 is required to install $TITLE"
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "Ableton" "http://www.ableton.com" "RoninDusette" "$PREFIX"

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Dependencies
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_corefonts

# Configuration
Set_OS "win7"
POL_Wine_Direct3D "DirectDrawRenderer" "gdi"

# Installation
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
GC_DONT_GC=1 POL_AutoWine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts
# Fix bug #2861 (http://www.playonlinux.com/fr/issue-2861.html)
if [ "$(find "$WINEPREFIX/drive_c" -name windows -prune -o -iname "Live Suite 9.exe" -a -type f -print)" != "" ]; then
POL_Shortcut "Live Suite 9.exe" "$TITLE"
elif [ "$(find "$WINEPREFIX/drive_c" -name windows -prune -o -iname "Ableton Live 9 Trial.exe" -a -type f -print)" != "" ]; then
POL_Shortcut "Ableton Live 9 Trial.exe" "$TITLE"
else
POL_Shortcut "Ableton Live 9 Suite.exe" "$TITLE"
fi

POL_SetupWindow_message "$(eval_gettext 'NOTICE: To register, when it opens asking for registration, drag-and-drop your reg file into $TITLE')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlxCSDwACgkQ5TH6yaoTykc0GQCcDvzyJoMGdvW1OyYdt+XUR+zT
JiIAnR//Yo2mZydWYByD7aOHWE8Vsw/H
=G86L
-----END PGP SIGNATURE-----
