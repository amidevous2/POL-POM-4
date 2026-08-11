#!/bin/bash
# Date : (2010-05-11 21-00)
# Last revision : 
# Wine version used : 1.8.2
# Distribution used to test : Mint 17.3
# Author : GNU_Raziel,Nicolas HOUDELOT
# Licence : Retail
#
# CHANGELOG
# [Dadu042] (2020-01-01)
#   First script.
# [Nicolas HOUDELOT] (2016-05-07)
# - update & fix deprecated functions
# - add images at installation
# - bump to wine 1.8.2
# [Dadu042] (2020-03-28)
# - Wine 1.8.2 (outdated) -> 3.0.3
# - Fix POL_Shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Tomb Raider Anniversary"
PREFIX="TombRaiderAnniversary"
WINE_VERSION="3.0.3"
GAME_VMS=64

LNG_CHOOSE_DDV="$(eval_gettext 'Please select your $TITLE Digital Download executable')"
LNG_INSTALL_ON="$(eval_gettext 'Installation in progress...')"
LNG_SUCCES="$(eval_gettext '$TITLE has been installed successfully.')"
LNG_CPSWARN="$(eval_gettext 'Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff.')"

POL_GetSetupImages "https://upload.wikimedia.org/wikipedia/en/thumb/f/f1/Tomb_Raider_-_Anniversary.png/64px-Tomb_Raider_-_Anniversary.png" "https://upload.wikimedia.org/wikipedia/en/thumb/f/f1/Tomb_Raider_-_Anniversary.png/150px-Tomb_Raider_-_Anniversary.png"  "$TITLE"
#starting the script
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Eidos Interactive" "http://www.tombraider.com/anniversary" "GNU_Raziel" "$PREFIX" 

POL_System_SetArch "auto"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"

#Configuration de wine
Set_OS "winxp"
#asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section

## Installer ##
#Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,LOCAL"
if [ "$INSTALL_METHOD" == "DVD" ]; then
        #asking for CDROM and checking if it's correct one
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
else
        #Asking then installing DDV of the game
        cd $HOME
        POL_SetupWindow_browse "$LNG_CHOOSE_DDV" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
        POL_Wine "$SETUP_EXE"
        INSTALL_ON="1"
        until [ "$INSTALL_ON" == "" ]; do
        sleep 5
        INSTALL_ON=`ps aux | grep "wineserver" | grep -v "grep"`
        done
        POL_SetupWindow_detect_exit
fi

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
        rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
        chmod -R 777 "$POL_USER_ROOT/tmp/"
        rm -rf "$POL_USER_ROOT/tmp/*"
fi

# making shortcut
POL_Shortcut "tra.exe" "$TITLE" "" ""  "Game;Adventure;"
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_message "$LNG_CPSWARN" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXn/G3QAKCRDlMfrJqhPK
RwZuAJ48SGMrbYTVTRIlUsSfzE4DKPa0AgCdFtCOdz2vTxAquelfocXex3Yngrc=
=KRci
-----END PGP SIGNATURE-----
