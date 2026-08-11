#!/bin/bash
# Date : (2013-01-14 21-49)
# Last revision : (2014-01-5 12-02)
# Distribution used to test : Kubuntu 12.04 LTS
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.1.9

# CHANGELOG
# [SuperPlumus] (2013-05-20 17-41)
#   gettext

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="AbletonLive"
WINEVERSION="1.5.20"

TITLE="Ableton Live 8"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_RequiredVersion "4.1.9" || POL_Debug_Fatal "$APPLICATION_TITLE 4.1.9 is required to install $TITLE"
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "Live 8" "Ableton" "http://www.ableton.com" "RoninDusette" "Ableton8"

# Create Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#Dependencies
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_corefonts

# Configuration
Set_OS "winxp"
POL_Wine_Direct3D "DirectDrawRenderer" "gdi"

# Installation
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
GC_DONT_GC=1 POL_AutoWine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts
POL_Shortcut "Live 8.*.exe" "Ableton Live 8"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: To register, when it opens asking for registration, drag-and-drop your reg file into $TITLE')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRL+YEACgkQ5TH6yaoTykchCACfVhbrSM3YkxRwLTkKmsVFBuRM
OdQAnR7Q/wyf8JWgtWeaMWR6V3pMXLFc
=myG3
-----END PGP SIGNATURE-----
