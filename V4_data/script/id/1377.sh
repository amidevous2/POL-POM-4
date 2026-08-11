#!/bin/bash
# Date : (2012-08-23 09-12)
# Last revision : see changelog.
# Wine version used : 1.5.11
# Distribution used to test : Ubuntu 12.04 LTS
# Author : tharvik
#
# CHANGELOG
# [tharvik] (2012-08-23 09-12)
#   Initial script. 
# [Dadu042] (2020-01-22 21:30)
#   Wine 1.5.11 -> 3.0.3
 
## Configuration
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Exile"
PREFIX="Exile"
 
## Script
 
# Init
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Presto Studios" "http://presto.yune.me/" "tharvik" "$PREFIX"
 
# Creating Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "3.0.3"
Set_OS "win95"
 
# Add DirectX 9
POL_Call POL_Install_directx9
 
# Asking the mountpoint and checking the CD
POL_SetupWindow_message "$(eval_gettext "Please insert the game media into your disk drive.")" "$TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "M3.exe"
POL_SetupWindow_check_cdrom "Data/MACAnodes.m3a"
POL_SetupWindow_check_cdrom "M3Data/COMM/COMM_Transport"
POL_SetupWindow_check_cdrom "M3Data/LEMT/LEMTsfx_KegRoll"
POL_SetupWindow_check_cdrom "M3Data/LI_M/LI_M2_stinger2"
 
# Copying files (allow to umount disk)
POL_SetupWindow_wait "$(eval_gettext "Coping install files, please wait...")" "$TITLE"
POL_System_TmpCreate "$PREFIX"
cp -r "$CDROM/"* "$POL_System_TmpDir"/
sync
 
# Installing
POL_SetupWindow_wait "$(eval_gettext "Please wait while $TITLE is installed.")" "$TITLE"
cd "$POL_System_TmpDir"
POL_Wine start /unix "$POL_System_TmpDir/Setup.exe"
POL_Wine_WaitExit
 
# Add Shortcut
POL_Shortcut "M3.exe" "$TITLE" "" "" "Game;"
 
# Cleaning   
POL_System_TmpDelete
POL_SetupWindow_message "$(eval_gettext "$TITLE has been successfully installed.")" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXi9EDAAKCRDlMfrJqhPK
RyOoAJ4qN4nKOf1hxY8+OcLNvlGobuxMoQCgq0WveRyemq6MibSvoMP7b+wfnH8=
=DRJj
-----END PGP SIGNATURE-----
