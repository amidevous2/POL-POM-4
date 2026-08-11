#!/usr/bin/env playonlinux-bash
# Date : 2012-08-16 21-12
# Last revision : see changelog
# Wine version used : 1.4
# Distribution used to test : Gentoo x86_64
# Author : xyz
#
# CHANGELOG
# [Dadu042] (2019-05-26)
#   Fix text missing in the installer first screen (and in the buttons). POL 4.3.4, Xubuntu 19.04
#   With Wine 3.0+ the installer crash (because of missing JPEGdecoder ?).
# [contessaxd] (2018-03-07  21-55)
#   Updated download location
# [deanmsands3] (2018-03-12 19-49)
#   Installer is now EXE, removed msiexec from POL_Wine command.
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Path of Exile"
PREFIX="pathofexile"
  
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1366
POL_SetupWindow_presentation "$TITLE" "Grinding Gear Games" "http://www.pathofexile.com" "xyz" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "2.22"

POL_System_TmpCreate "$PREFIX"
  
cd "$POL_System_TmpDir"
POL_Download "https://www.pathofexile.com/downloads/PathOfExileInstaller.exe"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$POL_System_TmpDir/PathOfExileInstaller.exe"
  
POL_System_TmpDelete
  
POL_Wine_OverrideDLL "native,builtin" "openal32"
  
POL_Shortcut "PathOfExile.exe" "$TITLE" "$TITLE.png" "Game;Roleplaying"
   
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOqrbQAKCRDlMfrJqhPK
R+ZPAKCFqTKnkSSb/ojiv7uSHne4S9QlowCeLkRy+AYqLyQbrlOlzMtsazFCTyo=
=3cSB
-----END PGP SIGNATURE-----
