#!/bin/bash
# Date : (2013-03-15 ??:??)
# Last revision : (2018-02-08 17:39)
# Distribution used to test : Ubuntu 17.04 64bit, Ubuntu 18.04 x64
# Author : Robbz, LinuxScripter
# Licence : GPLv3
 
# CHANGELOG
# [SuperPlumus] (2013-07-24 11-26)
#   Update gettext messages
# [LinuxScripter] (2018-02-08 17:39)
#   Changed wine version ("1.5.28-GuildWars2" -> 3.0.0)
# [LinuxScripter] (2020-10-23 20:00)
#   Wine 3.0.0 -> 3.0.3 (more common). No tested.
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="DC Universe Online"
PREFIX="DCUniverseOnline"
WORKING_WINE_VERSION="3.0.3"
PUBLISHER="Sony Entertainment"
GAME_URL="http://www.dcuniverseonline.com/"
AUTHOR="Robbz and LinuxScripter"
 
# Setup
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$PREFIX"
 
# Components
POL_Call POL_Install_dotnet40
POL_Call POL_Install_vcrun2012
POL_Call POL_Install_d3dx9_36
POL_Wine_OverrideDLL "native,builtin" "riched20"
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Download and instalation
cd "$POL_System_TmpDir"
POL_Download "https://launch.daybreakgames.com/installer/DCUO_setup.exe"
POL_Wine start /unix "$POL_System_TmpDir/DCUO_setup.exe"
POL_Wine_WaitExit "DCUO_setup.exe"
 
# Create Shortcuts
POL_Shortcut "LaunchPad.exe" "$TITLE" "$TITLE.png" "" "Game;"
 
POL_System_TmpDelete
POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX5MuHgAKCRDlMfrJqhPK
R9urAJ9sO6zur1mzXFm32lkWsxuq+eKPNgCffhqjlEvPARaC8c5tsRxCkap+rdc=
=u/+s
-----END PGP SIGNATURE-----
