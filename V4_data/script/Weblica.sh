#!/usr/bin/env playonlinux-bash

# CHANGELOG
# [Ground0] (2015-06-02 08:45)
#   Initial Version
# [Ground0] (2015-06-03 17:15)
#   Remove some uneeded things.
# [Ground0] (2016-01-18 18:30)  
#   Removed everything except Weblica himself, and Works with wine 1.8 also on Mac OS X
# Date : (2015-06-02 08:45)
# Last revision : (2016-01-18 18:30)
# Wine version used : 1.8
# Distribution used to test : OpenSUSE Tumbleweed / openSUSE Leap 42.1 / OS X 10.11.2
# Weblica Version used to test : 3.7.5
# Author : Ground0
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Weblica"
PREFIX="Weblica"
WINEVERSION="1.8"
EDITOR="empros GmbH"
APP_URL="http://www.weblica.ch"
AUTHOR="Ground0"
DOWNLOAD_URL="https://download.weblica.com/cms/weblica-3-current-setup.exe"
   
#Initialization
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2543

POL_Debug_Init
   
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$APP_URL" "$AUTHOR" "$PREFIX"
   
POL_Wine_SelectPrefix "$PREFIX"
#prefix must be created
POL_Wine_PrefixCreate "$WINEVERSION"
#main config
#Install some needed plugins
POL_Call POL_Install_ie8
Set_OS "winxp"

# Installation
POL_System_TmpCreate "$PREFIX"
cd $POL_System_TmpDir
POL_Download "$DOWNLOAD_URL"
POL_Wine "weblica-3-current-setup.exe"
POL_Wine_WaitExit "$TITLE"
   
# Create Shortcut
POL_Shortcut "weblica.exe" "$TITLE"
   
# Cleanup
POL_System_TmpDelete
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAladQUIACgkQ5TH6yaoTyke8BQCfem2TZ6yJDAurMoyFFc9nLnIo
1fEAnjsY8p0jJ4cWkBeEfwDiTvxpy9n3
=XdGx
-----END PGP SIGNATURE-----
