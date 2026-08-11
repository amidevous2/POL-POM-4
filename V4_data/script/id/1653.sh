#!/bin/bash
# Date : (2013-04-12)
# Last revision : see changelog
# Distribution used to test : Kubuntu 12.04.2 LTS 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.1

# CHANGELOG
# [RoninDusette] (2013-04-12)
#   Initial script.
# [Dadu042] (2020-02-16)
#   Wine 1.4.1 -> system
#   OS XP -> win7
 
     
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
     
PREFIX="rFactor12"
TITLE="rFactor 12"
EDITOR="Image Space Incorporated"
GAME_URL="http://www.rfactor.net/"
AUTHOR="RoninDusette"
     
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
     
POL_Debug_Init
     
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
     
# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file. Do NOT run rFactor after install has finished. Let DirectX install when asked. Make sure you set a 32-bit resolution when rFactor Config comes up.')" "$TITLE"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
     
#Dependencies
POL_Call POL_Install_dxfullsetup

# Configuration
Set_OS "win7"

# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
     
# Create Shortcuts
POL_Shortcut "rFactor.exe" "$TITLE" "" "" "Game;"
    
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXkl66QAKCRDlMfrJqhPK
R6orAJ9AdPdcnZDERWr0Cbzmfi++kD9tgACgmCvTMNInlyoi36V5KfIJTlnRwrQ=
=gnxs
-----END PGP SIGNATURE-----
