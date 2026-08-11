#!/bin/bash
# Date : (2009-03-28 12-00)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Manjaro Linux x64
# Author : Berillions & GNU_Raziel, Pavello
# Script licence :
# Program Licence : Retail
# Depend :
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [?] (2009-03-28 12-00)
#   Initial script.
# [Petch] (2015-03-28 10:15)
#   Wine 1.3.26 -> 1.7.39
# [?] (2017-05-27 10-28)
#   Wine 1.7.39 -> 2.1 ?
# [Dadu042] (2020-01-27 23:00)
#   Wine 2.1 -> 3.0.3
#   Improve POL_Shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Borderlands"
PREFIX="Borderlands"
EDITOR="Gearbox Software"
GAME_URL="Gearbox Software" "https://borderlandsthegame.com/"
AUTHOR="Berillions, GNU_Raziel, Pavello"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
  
# Installing mandatory dependencies
Set_OS "win7"
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_physx
 
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        STEAM_ID="8980"
fi
 
# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Setup.exe"
        # Mandatory activation for this game
        POL_SetupWindow_browse "$(eval_gettest 'Select file activation : Borderland-ManualReleaseDateCheck.exe')" "$TITLE" ""
        POL_Wine start /unix "$APP_ANSWER"
        PPOL_Wine_WaitExit "Manual Activation"
        # Resume Installation from DVD
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for Steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi
  
## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##
  
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
        rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
        chmod -R 777 "$POL_USER_ROOT/tmp/"
        rm -rf "$POL_USER_ROOT/tmp/*"
fi
  
# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
else
        POL_Shortcut "Borderlands.exe" "$TITLE" "" "" "Game;Shooter;"
fi
  
# Game protection warning
if [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_SetupWindow_message "$(eval_gettext 'You must disable anti-piracy protections of this game\nif you want to play it with wine.')" "$TITLE"
fi
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXi9d3wAKCRDlMfrJqhPK
RzMoAJ4u7zLvdAp63VJ6GSQ8kjNY+fojqACeIdIUs7Qm+4gSaI7tmt2K+yNH+h0=
=ETqn
-----END PGP SIGNATURE-----
