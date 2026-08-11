#!/bin/bash
# Date : (2013-06-19)
# Last revision : see changelog
# Distribution used to test : Kubuntu 12.04.2 LTS x64
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.1
#
# CHANGELOG
# [RoninDusette] (2013-06-19)
#   Initial script.
# [Dadu042] (2020-03-12 22:00)
#   Wine "1.6-rc2-Reason5Menu" (outdated) -> 3.0.3 (not tested).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
PREFIX="Reason5"
WINEVERSION="3.0.3"
TITLE="Reason 5"
EDITOR="Propellerheads"
GAME_URL="http://www.propellerheads.se/"
AUTHOR="RoninDusette"
  
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
  
POL_Debug_Init
  
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
  
#Dependencies
POL_Call POL_Install_vcrun2008
  
# Configuration
Set_OS "winxp"
Set_SoundDriver "alsa"
  
# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
 
POL_SetupWindow_message "$(eval_gettext 'NOTICE: Registration window will be hidden behind Reason logo on first run; right-click task bar item and click MOVE. If soundbanks fail to copy and program crashes after entering registration code, then take out disc and reinsert and try to run again. If that doesnt work, you will have to manually copy soundbanks to Reasons virtual drive. Digital downloads should not have this issue.')" "$TITLE"
 
# Create Shortcuts
POL_Shortcut "Reason.exe" "$TITLE" "" "" "Audio;"
 
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXmqRfwAKCRDlMfrJqhPK
R+7wAJ0ScZ7HWeiwxFlNqDGsW381TDaOlwCeMIiXSEuQkK3PPcUgaJptKBkS26o=
=/nWF
-----END PGP SIGNATURE-----
