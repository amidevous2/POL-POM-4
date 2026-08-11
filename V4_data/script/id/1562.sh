#!/bin/bash
# Date : (2013-03-01)
# Last revision : see changelog
# Distribution used to test : Kubuntu 12.04 LTS
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.1.9

# CHANGELOG
# [RoninDusette] (2013-03-01)
#   Initial script.
# [Dadu042] (2020-03-120 22:00)
#   Wine 1.6 (outdated) -> 3.0.3 (not tested).
    
    
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
PREFIX="Reaper4"
WINEVERSION="3.0.3"
TITLE="Reaper 4"
EDITOR="Cockos Incorporated"
GAME_URL="http://www.reaper.fm"
AUTHOR="RoninDusette"
    
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
    
POL_Debug_Init
    
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
    
# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file. Do NOT run Reaper after install has finished.')" "$TITLE"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
    
#Dependencies
    
# Configuration
Set_OS "winxp"
    
# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
    
# Create Shortcuts
POL_Shortcut "Reaper.exe" "$TITLE" "" "" "Audio;"
    
POL_SetupWindow_message "$(eval_gettext 'NOTICE: For low-latency audio, look into WineASIO. An aftermarket, low-latency audio interface is recommended. Your MIDI controllers should work as expected.')" "$TITLE"
   
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXmqREwAKCRDlMfrJqhPK
R/2CAKCBSpXP8vqzUXqrr+CjTrZqnrMvzQCgsv5Xp0hqodSpsu7OLbfVEzD6uV8=
=DPk4
-----END PGP SIGNATURE-----
