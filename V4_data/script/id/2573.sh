#!/bin/bash
# Date : (2015-07-13 16-30)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Arch Linux x86_64
# Author : treetrunk
  
# CHANGELOG
# [treetrunk] (2015-07-13 16-30)
#   First script (Wine 4.0.3).
# [Dadu042] (2020-01-02)
#   Wine 1.7.21 -> 3.0.3
#   Note: the game is no more downloadable for free, it's sold on Steam.
#   Fix backbuffer.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
WINEVERSION= "3.0.3"
 
TITLE="Cube World"
PREFIX="CubeWorld"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Wolfram Von Funck" "http://picroma.com/cubeworld" "treetrunk" "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate  "$WINEVERSION"
POL_SetOs "winxp" 
 
POL_Call POL_Install_corefonts
POL_Call POL_Install_vcrun2012
POL_Call POL_Install_xact_jun2010
POL_Wine_Direct3D "OffscreenRenderingMode" "backbuffer"
  
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
  
POL_Shortcut "CubeLauncher.exe" "$TITLE" "" "" "Game;"
  
POL_SetupWindow_Close
  
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg56kAAKCRDlMfrJqhPK
R0TPAJwNtP0iE4Sa5B5CTI744cofx3XJ5gCgprgkGrbRk1EWXDZu5Ak+2nP+HLI=
=El4d
-----END PGP SIGNATURE-----
