#!/bin/bash 
# Date : 04.07.2012 16:02
# Last revision : 04.07.2012 16:02
# Wine version used : 1.4
# Distribution used to test : Ubuntu 12.04 32bit
# Author : zadarmo3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
TITLE="Toontown Online"
PREFIX="toontown"
POL_SetupWindow_Init
POL_Debug_Init
POL_System_TmpCreate "$PREFIX"
POL_SetupWindow_presentation "$TITLE" "Disney" "toontown.go.com" "zadarmo3" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.4"
POL_SetupWindow_wait "$(eval_gettext 'Installing vcrun2008 and wininet and disabling d3d9 and d3d8 dlls to force the game to use OpenGL')" "$TITLE"
POL_Call POL_Install_wininet
POL_Wine_OverrideDLL "" "d3d9"
POL_Wine_OverrideDLL "" "d3d8"
POL_Call POL_Install_vcrun2008
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
	POL_Wine start /unix "$APP_ANSWER"
	POL_Wine_WaitExit
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
	cd "$POL_System_TmpDir"
	POL_Download "http://download.toontown.com/english/currentVersionWIN/Toontown-setup.exe" "69c60198d0d8b28f5ca648c253cf08e8"
	POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
	POL_Wine start /unix "$POL_System_TmpDir/Toontown-setup.exe"
	POL_Wine_WaitExit
fi
POL_System_TmpDelete
POL_Shortcut "ToontownLauncher.exe" "$TITLE"
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/0Tj0ACgkQ5TH6yaoTykdbYACdFV3cIQp1nlTG46kNuk9lq6hz
ePoAnRC0tEygWVE93yaWwaOefGuMqSrh
=Q4DI
-----END PGP SIGNATURE-----
