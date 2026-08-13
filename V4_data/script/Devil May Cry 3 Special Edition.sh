#!/bin/bash
# Date : (2019-06-27)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : Kubuntu 18.04
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Dadu042] (2019-06-27 16-34)
#   Initial writting. I used the retail DVD (folders date: april 2007).
# [Dadu042] (2019-06-29 08-80)
#   Add patch code.
# [Dadu042] (2019-07-20 07-27)
#   Fix POL_Wine_SetVideoDriver
#   Add POL_RequiredVersion
#
#
# KNOWN ISSUES
# - Wine 3.0.5, 4.0.1: No cutscenes videos displayed (.MPG files).
# - The game background is black/dark (first level 'crazy party' in the office), it only appear when firing. Fix: install the game patch v1.1 or later.
# - Game (even + patch 1.1) does not save screen resolution setting. It even reset the file (dmc3se.ini).
# - Exit: ALT+F4 only possible.
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Devil May Cry 3 Special Edition"
PREFIX="dmc3se"
WORKING_WINE_VERSION="3.0.5"
GAME_VMS="256"
  
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/dmc4/top.jpg" "http://files.playonlinux.com/resources/setups/dmc4/left.jpg" "$TITLE"
POL_SetupWindow_Init
  
# Starting debugging API
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Capcom" "https://en.wikipedia.org/wiki/Devil_May_Cry_3:_Dante%27s_Awakening" "Dadu042" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
 
# Game protection warning
if [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_Call POL_Function_NoCDWarning
fi
 
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
fi
 
# POL_Call POL_Install_dxfullsetup
 
# Fail because link to Mpsetup.exe is break (2019-06-27)
# POL_Call POL_Install_wmp9
 
# Can not install without wmp9
# POL_Call POL_Install_wmpcodecs 
 
  
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        # POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "exe/DMC3SE.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "6550"
         
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/6550
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi
  

# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/6550"
else
        # POL_Shortcut "DevilMayCry3_DX9.exe" "$TITLE" "$TITLE.png" ""
         
        # Restore screen resolution (game's default is 640x480)
        POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
         
        POL_Shortcut "DMC3SE.exe" "$TITLE" "$TITLE.png" "" "Game;ActionGame;"
        POL_Shortcut_Document "$TITLE" "readme.txt"
fi
 
################
# Patch update #
################
    
POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ? (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
     
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi

#######################################
# Setup GPU                           #
####################################### 

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
  
# Set Graphic Card information keys for wine
POL_Call POL_Wine_SetVideoDriver

 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXTKmtQAKCRDlMfrJqhPK
R+65AJ4qjRdoW48fuxrO6GTnu23OzsXvoQCfQeSgdWWwLnG0vO/gI3ogkSYbl40=
=IujS
-----END PGP SIGNATURE-----
