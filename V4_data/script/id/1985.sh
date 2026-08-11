#!/bin/bash
# Date : (2014-03-27)
# Last revision : (see changelog)
# Wine version used : see below
# Distribution used to test : Xubuntu 18.04 x64
# Author : Arcadien (arc@arcadien.net)
#
# Game based on: DirectX 9, MS Visual studio. 
#
# CHANGELOG
# [Arcadien (arc@arcadien.net)] (2014-03-27)
#   Initial writing.
# [Dadu042] (2019-05-23)
#   Repair download URL. Game start updating partially, then fail (a error window open: 'Connection problems were encountered while updating ...').
# [Dadu042] (2019-07-20)
#   Repair download URL.
# [Dadu042] (2019-07-24)
#   Fix 'script freeze': call to POL_Wine_SetVideoDriver
#   Add messages for newcomers.
#   Add silent install (it's a bit faster).
# [Dadu042] (2020-06-08) (tested with game v2.3.7)
#   Wine 4.0.1 -> 4.0.4
#   Fix POL_Shortcut
#   Add icon to POL_Shortcut
# [Dadu042] (2020-09-13) (tested with game v2.3.7)
#   Wine 4.0.4 -> 5.0.2
# [Dadu042] (2022-03-23) (not tested)
#   Wine 5.0.3 -> 6.0.1

# KNOWN ISSUES
#   2019-07-24, Wine 4.0.1: POL Error when launching, but the game does launch. Game v2.3.7.



[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Villagers and Heroes"
PREFIX="villagers-and-heroes"
    
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
    
POL_SetupWindow_Init
POL_SetupWindow_SetID 1985
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "Mad Otter Games" "www.villagersandheroes.com" "Arcadien (arc@arcadien.net)" "$PREFIX"
  
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
   
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "6.0.1"
    
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
  
#######################################
# Setup GPU                           #
####################################### 
  
# Set Graphic Card (useful if laptop with dual GPU)
POL_Wine_SetVideoDriver
  
  
  
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
# POL_SetupWindow_message "Please do not run the game as soon installed. Uncheck the checkboxes." "$TITLE"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
  
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
        POL_Download "https://www.villagers-and-heroes.com/VHSetup.exe"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine "VHSetup.exe" "/SILENT"
fi


# Use the icon file hosted at: http://files.playonlinux.com/resources/icones/Villagers%20and%20Heroes.png
POL_Shortcut "VHLauncher.exe" "$TITLE" "Villagers%20and%20Heroes.png" "" "Game;Roleplaying"

# POL_Shortcut "VHLauncher.exe" "$TITLE" "" "" "Game;Roleplaying"
# icon: AMLIcon.ico but I have no idea how to use it.
 
POL_SetupWindow_message "Game installed (the launcher)." "$TITLE"
 
POL_SetupWindow_Close
POL_System_TmpDelete
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYj+yiwAKCRDlMfrJqhPK
R7/OAJ9svPjDvVIbQWE/UvzTAcvxFPWxpACcCcRqDT1MYdPDV2xaAwXopIRu+Mc=
=L/vx
-----END PGP SIGNATURE-----
