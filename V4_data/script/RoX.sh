#!/bin/bash
#
# Date : (2016-08-02 23-31)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Manjaro Linux 16.06.1
# Author : OdzioM
# Licence : Freeware
#
#
# CHANGELOG
# [OdzioM] (2016-08-02)
#   First script
# [Dadu042] (2020-01-02)
#   Wine 1.9.15-staging -> 3.0.3
#   The link to "dx8vb.dll" is still break, I can not find a website (linkable) hosting it.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Safrosoft RoX"
INFO1="Safrosoft"
INFO2="http://www.autofish.net/shrines/rox/"
AUTHOR="OdzioM"
PREFIX="RoX"
WORKING_WINE_VERSION="3.0.3"
WINE_ARCH="x86"
 
# Down as of 2020-01-02
# POL_GetSetupImages "http://odziomek.pl/playonlinux/$PREFIX/top.png" "http://odziomek.pl/playonlinux/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$INFO1" "$INFO2" "$AUTHOR" "$PREFIX"
 
# checking for unzip command in Linux
check_one "unzip" "unzip"
POL_SetupWindow_missing
 
POL_Wine_SelectPrefix "$PREFIX"
 
POL_System_SetArch "$WINE_ARCH"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Down as of 2020-01-02
# Download and register DX8VB.DLL (required to start RoX)
POL_Download "http://odziomek.pl/playonlinux/$PREFIX/dll/dx8vb.dll"
mv -f dx8vb.dll "$WINEPREFIX/drive_c/windows/system32"
POL_Wine regsvr32.exe dx8vb.dll
POL_Wine_WaitExit "dx8vb.dll"
 
# Download and unzip RoX installer
POL_Download "http://www.autofish.net/shrines/rox/rox_1_4_setup.zip"
unzip "$POL_System_TmpDir/rox_1_4_setup.zip"
 
# Installation
SETUP_EXE="$POL_System_TmpDir/RoX_1_4_Setup.exe"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
 
POL_System_TmpDelete "$PREFIX"
 
POL_Shortcut "RoX.exe" "$TITLE" "" "" "Game;"
POL_Shortcut "Rox Editor.exe" "$TITLE Editor" "" ""
 
POL_SetupWindow_message "Installation complete!\n\nTo run $TITLE please select $TITLE icon from your desktop." "$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg3MRAAKCRDlMfrJqhPK
R+ChAJ498iatQq1/BuZUGuLs87y/u4Ny1ACgr3iaXjXJvAlbvQN1W6pg7d5H6fQ=
=Fsnj
-----END PGP SIGNATURE-----
