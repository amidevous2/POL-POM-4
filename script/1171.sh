#!/bin/bash
# Date : 
# Wine version used : 1.9.2
# Distribution used to test : Ubuntu 15.10
# Author: LinuxScripter
# Licence : GPLv3
#
# CHANGELOG
# [Quentin PÂRIS] (2010 ?)
#   Initial script.
# [LinuxScripter] (2016-02-04 13-27)
#   This script is very old so I decided to write a new one.
# [Dadu042] (2020-01-22 13:30)
#   Wine 1.8 -> 3.0.3
#   Remove POL_Install_d3dx9

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Microsoft Fury 3"
AUTHOR="LinuxScripter"
PREFIX="Microsoft_Fury_3"
EDITOR="Microsoft"
WORKINGWINEVERSION="3.0.3"
 
POL_SetupWindow_Init
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_Install_devenum
POL_Call POL_Install_directplay
POL_Call POL_Install_dinput
POL_Call POL_Install_directmusic
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.lst"
POL_Wine start /unix "$CDROM/setup.exe"
POL_Wine_WaitExit "$TITLE"
 
POL_Wine_OverrideDLL "" "iccvid"
 
POL_Shortcut "FURY3.EXE" "$TITLE" "" "" "Game;"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNZQwAKCRDlMfrJqhPK
R6wPAKCXxOQq5PEQDkMThs2B+FIH6DICIgCdG+ABU81cidi4BlhYvsLCmP7geAY=
=jvw/
-----END PGP SIGNATURE-----
