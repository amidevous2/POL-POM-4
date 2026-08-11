#!/bin/bash
# Date: 18/04/2017
# Last revision: see changelog
# Wine version used: 2.22
# Distribution tested: Ubuntu 16.04.4 x64
# Only for: http://www.playonlinux.com
# 
# CHANGELOG:
# andrelima175 (2010-04-21)
#   First script. Distribution used to test : Ubuntu 9.10.
# Dadu042 (2019-08-01)
#   Wine 2.20-staging -> 2.22  (because usually better)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="The_King_of_Fighters_XIV"
PREFIX="KOFXIV"
WINEVERSION="2.22"
EDITOR="SNK"
GAME_URL="https://www.atlus.com/kofxiv"
STEAM_ID="571260"
 
        POL_SetupWindow_Init
        POL_Debug_Init
 
        POL_SetupWindow_presentation "$TITLE" "SNK" "GAME_URL" "STEAM"
        POL_Wine_SelectPrefix "$PREFIX"
 
        POL_System_SetArch "x64"
        POL_Wine_PrefixCreate "$WINEVERSION"
 
#Installing dependencies
 
        POL_Call POL_Install_vcrun2013
        POL_Call POL_Install_dxfullsetup
        POL_SetupWindow_VMS
        POL_Wine_SetVideoDriver
 
        POL_SetupWindow_InstallMethod "STEAM,DVD"
 
if  [ "$INSTALL_METHOD" == "STEAM" ]; then
 
        POL_Call POL_Install_steam
        POL_SetupWindow_message "$(eval_gettext 'After steam install, login & close steam')"
        POL_Call POL_Install_steam_flags "$STEAM_ID"
 
#Installing the game by Steam
 
fi
 
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
 
#Installation  - DVD
 
if  [ "$INSTALL_METHOD" == "DVD" ]; then
 
#Installing the game
#If doesn't work, choose the correct file manually.
 
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
 
fi
 
        POL_Shortcut
        POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUNaiQAKCRDlMfrJqhPK
R/V8AJ0XsoAK599rdcOJ7JAZ1mqZlwuOOQCfVJT48mgpmju0CznRd6Zbvaqxkt4=
=9KJv
-----END PGP SIGNATURE-----
