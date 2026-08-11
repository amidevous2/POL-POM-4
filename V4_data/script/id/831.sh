#!/bin/bash
# Date : (2011-27-03 21-00)
# Last revision : (2013-06-23 19-15)
# Wine version used : 1.3.16, 1.3.23
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-06-23 19-15)
#   Update script POLv3 -> POLv4

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="FurMark 1.9.1"
PREFIX="furmark"
WORKING_WINE_VERSION="1.3.23"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/furmark/top.jpg" "http://files.playonlinux.com/resources/setups/furmark/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Geeks3D" "http://www.geeks3d.com/" "GNU_Raziel" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

# Downloading SCNB game (it's a freeware)
# Original thread : http://www.geeks3d.com/20110628/furmark-1-9-1-furmark-1-8-5-download-gpu-stress-test-burn-in-graphics-card-opengl/
cd "$POL_System_TmpDir"
POL_Download "http://files.playonlinux.com/FurMark_1.9.1.exe" "b4d7862354754e6bba2add776479ad03"

POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$POL_System_TmpDir/FurMark_1.9.1.exe"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_VMS "256"

POL_Wine_SetVideoDriver

[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"

POL_System_TmpDelete

POL_Shortcut "FurMark.exe" "$TITLE" "$TITLE.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHHMWsACgkQ5TH6yaoTykcG0wCgnOKtDWGTSWCJs74yMIGpqRUF
SMoAn1QA4qZMncuqaJl0aYDjNtwMrW8P
=+gCg
-----END PGP SIGNATURE-----
