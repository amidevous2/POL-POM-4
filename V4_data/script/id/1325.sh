#!/bin/bash
# Date : (2012-07-20 13-05)
# Last revision : (2014-03-18 16-00)
# Wine version used : 1.7.14
# Distribution used to test : Rosa Fresh (x86)
# Author : ll413
# Script licence : GPL v.2

# CHANGELOG
# [SuperPlumus] (2013-06-21 20-50)
# Update gettext messages
# Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="SFR LiberTalk"
PREFIX="SFR_Libertalk"
WORKING_WINE_VERSION="1.7.14"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "SFR" "http://www.sfr.fr" "ll413" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "winxp" "sp3"
Set_Managed "On"
POL_Wine_InstallFonts

POL_Call POL_Install_LunaTheme

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
cd "$POL_System_TmpDir"
POL_Download "http://prod.sd-sfr.fr/libertalk/download.php" "684604d4fe0e299fd153867eed1ef9de"
mv "$POL_System_TmpDir/download.php" "$POL_System_TmpDir/SFR_Libertalk.exe"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$POL_System_TmpDir/SFR_Libertalk.exe"
POL_Wine_WaitExit "$TITLE"
fi

#
rm "$WINEPREFIX/drive_c/Program Files/SFR/Libertalk/portaudio_x86.dll"
cd "$POL_System_TmpDir"
POL_Download "https://jpab.googlecode.com/files/portaudio_x86.dll" "08688843c5fc024bcad8bd75de8429d7"
cp "$POL_System_TmpDir/portaudio_x86.dll" "$WINEPREFIX/drive_c/Program Files/SFR/Libertalk/portaudio_x86.dll"


POL_System_TmpDelete

POL_Shortcut "SFR_Libertalk.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMoalYACgkQ5TH6yaoTykdDdQCfTzCdUxf82PmWNQ6cl5ZLbRHq
CYUAoJDX9lFmxwTLK8AkLKqxBumaAR8c
=r8ls
-----END PGP SIGNATURE-----
