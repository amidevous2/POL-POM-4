#!/bin/bash
 
 
##Informations
# Date : (2012-08-25 12-14)
# Last revision : see changelog.
# Wine version used : 1.5.11
# Distribution used to test : Ubuntu 12.04 LTS
# Author : tharvik
#
# CHANGELOG
# [tharvik] (2012-08-25 12-14)
#   Initial script.
# [Dadu042] (2020-01-22 21:30)
#   Wine 1.5.11 -> 3.0.3
#   Fix POL_Install_d3dx11 -> POL_Install_d3dx9
 
## Configuration
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Myst 4: Revelation"
PREFIX="Myst_Revelation"
 
## Script
 
# Init
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Ubisoft Montreal" "http://montreal.ubisoft.com/en" "tharvik" "$PREFIX"
 
# Creating Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.0.3"
Set_OS "winxp"
 
# Asking the mountpoint and checking the CD
POL_SetupWindow_message "$(eval_gettext "Please insert the game media into your disk drive.")" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "win32/autorun/MystIV.exe"
POL_SetupWindow_check_cdrom "win32/bin/m4_base_rd.dll"
POL_SetupWindow_check_cdrom "win32/bin/Myst4_Game_2.ico"
POL_SetupWindow_check_cdrom "win32/bin/configurator/myst_detection.exe"
POL_SetupWindow_check_cdrom "win32/bin/updatelauncher/mystupdate.exe"
 
# Installing
POL_SetupWindow_wait "$(eval_gettext "Please wait while $TITLE is installed.")" "$TITLE"
POL_Wine start /unix "$CDROM/setup.exe"
POL_Wine_WaitExit
 
# Add DirectX 9
POL_Call POL_Install_d3dx9
 
# Add Shortcut
POL_Shortcut "Myst4.exe" "$TITLE" "" "" "Game;"
 
# Cleaning.
POL_SetupWindow_message "$(eval_gettext "$TITLE has been successfully installed.\n\nYou might have to start the game three times in order to work (only the first launch).")" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXi9FMwAKCRDlMfrJqhPK
R3LVAJ9FbD9aZST7pMGs/nl7rDnbpu3mmwCffQdI2syZquioYbjTqQvS9fJlgDQ=
=LeQ6
-----END PGP SIGNATURE-----
