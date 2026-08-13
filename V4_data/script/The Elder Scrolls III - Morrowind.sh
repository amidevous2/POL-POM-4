#!/bin/bash
# Last revision : see changelog
# Wine version used : system
# License : GNU/GPL v3
  
# CHANGELOG
# [Tutul, modified by Tinou, modified by DJYoshaBYD] (2014-06-15 14:20)
#   First script. Wine 1.2
# [Dadu042] (2020-01-06)
#   Wine 1.5.22 -> system version.
#   Add POL_Shortcut_Document
#   Improve POL_Shortcut
# [Dadu042] (2020-01-07 01:00)
#   Wine system version -> 3.0.3 (because see Known issue with Wine 3.0.0 ).
# [Dadu042] (2020-06-24 01:00)
#   Disable POL_Sudo_UnhideCdrom because it seems broken.

 
# KNOWN ISSUES:
#  - Wine amd64 3.0.0: crash when launching a game session from the main menu. Fix: Wine 3.0.3, 2.22
#  - Wine amd64 3.20: mouse cursor is jerky on the main menu.
#  - Wine amd64 4.0.3: X
0
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="The Elder Scrolls 3 - Morrowind"
PREFIX="TES3_Morrowind"
EDITOR="Bethesda Softworks"
GAME_URL="http://bethsoft.com/"
AUTHOR="Tutul"
GAME_VMS="32"
  
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/morrowind/top.jpg" "http://files.playonlinux.com/resources/setups/morrowind/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 708
  
# Starting debugging API
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
    
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
  
POL_Wine_PrefixCreate "3.0.3"
# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Choose between CD and Digital Download version
POL_SetupWindow_InstallMethod "CD,LOCAL"
  
if [ "$INSTALL_METHOD" == "CD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
   
        POL_SetupWindow_cdrom
        
        # Disabled because I get the message 'Error in source, unable to mount the CD-ROM.' on Ubuntu 20.04 Dadu042 20200-06
        # POL_Call POL_Sudo_UnhideCdrom

        POL_SetupWindow_check_cdrom "Setup.exe"
   
        SETUP_EXE="$CDROM/Setup.exe"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
fi
    
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
    
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
    
# Run the install
POL_Wine_WaitBefore "$TITLE"
POL_Wine $SETUP_EXE
POL_Wine_WaitExit "$TITLE"
  
## PlayOnMac Section 
[ "$PLAYONMAC" == "" ] && Set_Managed "On"
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section 
  
POL_Shortcut "Morrowind Launcher.exe" "The Elder Scrolls III - Morrowind" "" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "man*.pdf"
  
POL_SetupWindow_message "$(eval_gettext 'If you have the extentions, you should install Tribunal first !')" "$TITLE"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXvM7jgAKCRDlMfrJqhPK
R5SzAKCvvmAa5CK3DAMPSOGhpvuxOlVMXQCfQof0GNFSp9MksUc+n2v1s5oLldA=
=dH3x
-----END PGP SIGNATURE-----
