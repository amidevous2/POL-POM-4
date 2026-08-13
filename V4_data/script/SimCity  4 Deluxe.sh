#!/bin/bash
# Date : (2015-01-15 13-00)
# Last revision : see changelog
# Distribution used to test : Ubuntu 19.04 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.3.4

# Media used: 2 CD-Rom retail, august 2004 (folders date. But on CD #2 it's july 2008), pre patched ?.
# File Version: 1.1.613.0

# CHANGELOG
# [Dadu042] (2019-07-04)
#   - Some little improvements.
#   - Wine 1.7.34 -> 2.22.
#   - Add KNOWN ISSUES.

# KNOWN ISSUES:
# Wine 4.1, 4.8: when trying to launch the game it does not recognize the retail CD-ROM #1.
# Wine 4.8 + NoCD : "Could not initialize direct draw" (same with: force GDI, UseGLSL, dx3d9).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
       
PREFIX="SimCity4Deluxe"
WINEVERSION="2.22"
TITLE="SimCity 4 Deluxe"
EDITOR="EA Games - Maxis"
GAME_URL="http://www.electronicarts.com"
AUTHOR="RoninDusette"

       
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion 4.2.12 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

# Getting information for installation
POL_SetupWindow_InstallMethod "LOCAL,STEAM,CD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file for $TITLE')" "$TITLE"
    SETUP_BY="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "STEAM" ]; then
    SETUP_BY="STEAM"
fi
 
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"
POL_System_TmpCreate "$TITLE"

if [ "$INSTALL_METHOD" = "STEAM" ]; then
POL_SetupWindow_message "$(eval_gettext 'NOTICE: After Steam installs, uncheck "Run Steam" so that it does not start.')" "$TITLE"
fi
 
# Dependencies
if [ "$SETUP_BY" = "STEAM" ]; then
    POL_Call POL_Install_steam
fi
 
# Configuration
Set_Desktop "On" "1024" "768"
POL_Wine_Direct3D "UseGLSL" "disabled"
 
# Installation
if [ "$INSTALL_METHOD" = "CD" ]; then
        POL_Call POL_Function_NoCDWarning
        Set_OS "win2k"

        #CD-ROM 1
        POL_SetupWindow_message "$(eval_gettext 'Please insert CD 1.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "SC4_ConnectToWebIcon.ico"
        cd "$WINEPREFIX/dosdevices"
        rm "d::"
        ln -s "$CDROM" "d:"
        cd "$CDROM"
        POL_Wine "$CDROM/setup.exe"
        POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next disk, please come back to this window in order to click on "Next" before to insert it.')"
        #CD-ROM 2
        POL_SetupWindow_message "$(eval_gettext 'Please insert CD 2.\n\nIn the next window click 'Refresh' until you see it then select it.')"
        POL_SetupWindow_cdrom
        cd "$WINEPREFIX/dosdevices"
        rm "d:"
        ln -s "$CDROM" "d:"
        cd "$POL_System_TmpDir"

        POL_SetupWindow_message "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
        
        POL_Shortcut "SimCity 4.exe"
        POL_Shortcut_Document "$TITLE" "ReadMe.txt"
fi

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_Call POL_Function_NoCDWarning
    Set_OS "win2k"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
    POL_Shortcut "SimCity 4.exe"
elif [ "$INSTALL_METHOD" = "STEAM" ]; then
    Set_OS "winxp"
    POL_SetupWindow_message "$(eval_gettext 'NOTICE: If you notice an error, but Steam and $TITLE are running, it can be ignored.')" "$TITLE"
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine "Steam.exe" -applaunch 24780
    POL_SetupWindow_message "$LNG_WAIT_STEAM_END" "$TITLE"
    POL_Shortcut "Steam.exe" "$TITLE"
fi

# Set Graphic Card informations keys for wine
POL_Call POL_Install_VideoDriver

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXR5UJgAKCRDlMfrJqhPK
R12+AJ9q+dAaDrWVuV/aUvpfbBD4wnRHywCeNqKiiuyG0F8TYu3Jf9O2Te9PSHo=
=t4XM
-----END PGP SIGNATURE-----
