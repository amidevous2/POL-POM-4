#!/bin/bash
   
 
# [Fat Hard] (2019-04-04)
 
# CHANGELOG
# Version 1.1
# Initial Version
# Version: 1.2
# Fixed Pol function error
# Updated Wine version (4.0)
# Code adapted at RoninDusette's Photoshop CS6 Installing Code
# Version 1.3
# Just a Code Review 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
PREFIX="Proteus8"
WINEVERSION="4.0"
TITLE="Proteus 8 Professional"
EDITOR="Labcenter Electronics Ltd"
GAME_URL="https://www.labcenter.com"
AUTHOR="FatHard"
 
#Initialization
POL_GetSetupImages "http://2.bp.blogspot.com/-Fg3bEjDvkY0/VGsIhvdAbTI/AAAAAAAANpw/OPExT55Kbf8/s1600/Proteus%2BIcon.png" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2665

POL_Debug_Init
 
# Presentation 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
INSTALLER="$APP_ANSWER"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#Dependencies
POL_Call POL_Install_corefonts
POL_Call POL_Function_FontsSmoothRGB


# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE" 

 
# Create Shortcuts
POL_Shortcut "PDS.EXE" "Proteus 8 Professional" "" "" "Development;Development;"
 
POL_Extension_Write pdsprj "Proteus 8 Professional"
 
#Ending
POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed successfully, but NOTICE: At first run the program will generate the following error "Internal Exception: Access violation in module 'VGDVC.DLL' [00010C56]".After this error, go in Settings (is on right of "Remove"), go on Wine, Registry Editor, HKEY_CURRENT_USER\Software\Labcenter Electronics\Proteus 8 Professional\Default Graphics Mode=1 (set on 1)
And Done!\n\nIf an installation Windows prevent your programs from running, you must remove and reinstall $TITLE')" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPJcpQAKCRDlMfrJqhPK
R3dxAKCN8cfBlW8pPACpdh91bxJz263wPQCeMxvf8+l3emZlYbvCpvzpg3oTsJc=
=d/v9
-----END PGP SIGNATURE-----
