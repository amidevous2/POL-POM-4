#!/bin/bash
 
 
##Informations
# Date : (2012-08-25 14-57)
# Last revision : see changelog
# Wine version used : system
# Distribution used to test : Ubuntu 12.04 LTS
# Author : tharvik
#
# CHANGELOG
# [tharvik] (2012-08-25)
#   First script. Wine 1.7.55.
# [Dadu042] (2019-12-30)
#   Wine "1.5.11" -> system

## Configuration
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Tomb Raider: The Last Revelation"
PREFIX="Tomb_Raider_The_Last_Revelation"
 
## Script
 
# Welcome
POL_SetupWindow_Init
POL_Debug_Init
# No website, dead (--> http://en.wikipedia.org/wiki/Core_Design)
POL_SetupWindow_presentation "$TITLE" "Core Design" "" "tharvik" "$PREFIX"
 
# Creating Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
Set_OS "win95"
 
# Asking the mountpoint
POL_SetupWindow_message "$(eval_gettext "Please insert the game media into your disk drive.")" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "tomb4.exe"
POL_SetupWindow_check_cdrom "audio/001_VonCroy2.wav"
POL_SetupWindow_check_cdrom "audio/012_VonCroy11b.wav"
POL_SetupWindow_check_cdrom "data/alexhub.tr4"
POL_SetupWindow_check_cdrom "data/joby5a.tr4"
 
# Installing
POL_SetupWindow_wait "$(eval_gettext "Please wait while $TITLE is installed.")" "$TITLE"
POL_Wine start /unix "$CDROM/autorun.exe"
POL_Wine_WaitExit
 
# Add Shortcut
POL_Shortcut "tomb4.exe" "$TITLE" "" "" "Game;"
 
# Cleaning
POL_SetupWindow_message "$(eval_gettext "$TITLE has been successfully installed.")" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgtIHAAKCRDlMfrJqhPK
R+f4AKCTebtDAcl7GR/25T17olq4dhzpXACeMfrqUzFUEdatgtzp9VbIuBr2pEU=
=tFBz
-----END PGP SIGNATURE-----
