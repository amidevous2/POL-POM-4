#!/bin/bash
# Last revision : (2011-08-20 13-00)
# Tested : Debian 6.0, Mac OSX 
# Author : Tinou
# Script licence : GPLv3
# 
# This script is designed for PlayOnLinux and PlayOnMac. 
#
# * Revision (2011-08-20 13-00) 
#  - Update for POL/POM 4 

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Trackmania United Forever"

POL_GetSetupImages "$SITE/setups/tmnf/top.jpg" "http://files.playonlinux.com/resources/setups/tmuf/left.jpg" "tmuf"
POL_Debug_Init
POL_SetupWindow_Init 
POL_SetupWindow_presentation "$TITLE" "Focus Home Interactive" "http://www.trackmaniaunited.com/" "Tinou" "TMUnited"

#Préparation de Wine
POL_Wine_SelectPrefix "TMUnited"
POL_Wine_PrefixCreate

cd "$REPERTOIRE/tmp"

if [ "$POL_SELECTED_FILE" = "" ]
then
POL_SetupWindow_browse "Where is the installation file of $TITLE?" "$TITLE"
CHEMIN="$APP_ANSWER"
else
CHEMIN="$POL_SELECTED_FILE"
fi
POL_SetupWindow_wait "Installing $TITLE" "$TITLE"

Set_Managed Off
POL_Wine "$CHEMIN"

POL_LoadVar_PROGRAMFILES

if [ "$PLAYONMAC" = "" ]
then
Set_SoundDriver "oss"
cd "$REPERTOIRE/wineprefix/TMUnited/drive_c/$PROGRAMFILES/TmUnitedForever/"
POL_SetupWindow_download "Downloading wrap_oal.dll" "$TITLE" "$SITE/dlls/wrap_oal.dll"
else
POL_LoadVar_PROGRAMFILES
cd "$REPERTOIRE/wineprefix/TMUnited/drive_c/$PROGRAMFILES/TmUnitedForever/"
POL_SetupWindow_download "Fixing sound issue..." "$TITLE" "$SITE/divers/tmnf.zip"
unzip tmnf.zip
POL_Call POL_Function_OverrideDLL native,builtin openal32 wrap_oa
fi

#CREATION LANCEUR
POL_Shortcut "TmForeverLauncher.exe" "$TITLE"


POL_SetupWindow_message "$TITLE has been successfully installed" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk5QD/0ACgkQ5TH6yaoTykeEqgCgqpkb0cycKZ34ayK2VUDEcsxu
yPkAnjv5tboTYs4S/Gn+QlaotZ5bgOxN
=37Tl
-----END PGP SIGNATURE-----
