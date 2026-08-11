#!/bin/bash
# Date : (2017-06-04)
# Last revision : see changelog
# Wine version used :
# Distribution used to test : Ubuntu 16.04
# Author : ImperatorS79
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [ImperatorS79] (2017-06-04)
#   First script.
# [ImperatorS79] (2017-07-23)
#   ?
# [Dadu042] (2019-12-12)
#   Wine "2.9-staging" (outdated) -> 3.0.3


## Begin Note 2017 ##
# see https://www.youtube.com/watch?v=4JoebSYERsc and https://appdb.winehq.org/objectManager.php?sClass=version&iId=29849&iTestingId=98002
# Not from me, but inspired this script, it's a kind of test...
# Script inspired from AC2 script
## End Note ##
     
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
     
TITLE="Assassin's Creed 4 : Black Flag"
PREFIX="AssassinsCreed4"
EDITOR="Ubisoft"
GAME_URL="https://www.ubisoft.com/fr-fr/game/assassins-creed-4-black-flag"
AUTOR="ImperatorS79"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="512"
     
# Starting the script
#POL_GetSetupImages "undefined" "undefine" "$TITLE"
POL_SetupWindow_Init
     
# Starting debugging API
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTOR" "$PREFIX"
     
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
     
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
     
#DVD maybe later
POL_SetupWindow_InstallMethod "STEAM"
     
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        STEAM_ID="242050"
fi
    
#Not sure if it's needed
POL_Call POL_Install_physx
POL_Call POL_Install_ubigamelauncher
   
# Asking about memory size of graphic card
POL_SetupWindow_VMS "$GAME_VMS"
 
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver
     
# Begin game installation
    
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
        POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
fi
      
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnucCwAKCRDlMfrJqhPK
R/MDAJ0SFFlWkDlQuXGwk/WdB28Hw5fKDwCgrVLfx/u5pTnQxZDMXE7P+9jQNLM=
=h1a5
-----END PGP SIGNATURE-----
