#!/bin/bash
# Date : (2018-01-24 23-45)
# Last revision : (2018-11-02 12-31)
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 18.10 x64
# Script licence : GPL3
# Program licence : Retail
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Space Colony"
PREFIX="SpaceColony"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="LinuxScripter"
EDITOR="Firefly Studios"
GAME_URL="http://www.spacecolonyhd.com/"
GOGID="space_colony_hd"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

POL_SetupWindows_message "$(eval_gettext 'The CD option is for an version of $TITLE that came on two CD-ROMs. DVD is for single disc.')" 
POL_SetupWindow_InstallMethod "DOWNLOAD,CD,STEAM,DVD"
if [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
        POL_Call POL_GoG_setup "$GOGID"
        POL_Call POL_GoG_install
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/297920
        POL_Wine_WaitBefore "$TITLE"
elif [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Disk1/setup.inx"
        POL_Wine start /unix "$CDROM/Disk1/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
        POL_Download "https://d1ztm8591kdhlc.cloudfront.net/hdpatches/Space_Colony_HD_Update.exe" "C821E5C7035B9B517823466F4CEDADD3"
        POL_Wine start /unix "Space_Colony_HD_Update.exe"
        POL_Wine_WaitExit "Space_Colony_HD_Update.exe"
else
        #CD-ROM 1
        POL_SetupWindow_message "$(eval_gettext 'Please insert CD 1.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Disk1/setup.inx"
        cd "$WINEPREFIX/dosdevices"
        rm "d::"
        ln -s "$CDROM" "d:"
        cd "$CDROM"
        POL_Wine "$CDROM/Disk1/setup.exe"
        POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next disk\nclick on "Next".')"
        #CD-ROM 2
        POL_SetupWindow_message "$(eval_gettext 'Please insert CD 2.')"
        POL_SetupWindow_cdrom
        cd "$WINEPREFIX/dosdevices"
        rm "d:"
        ln -s "$CDROM" "d:"
        cd "$POL_System_TmpDir"
        POL_Download "https://d1ztm8591kdhlc.cloudfront.net/hdpatches/Space_Colony_HD_Update.exe" "C821E5C7035B9B517823466F4CEDADD3"
        POL_Wine start /unix "Space_Colony_HD_Update.exe"
        POL_Wine_WaitExit "Space_Colony_HD_Update.exe" 

fi
 
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/297920"
else
        POL_Shortcut "Space Colony.exe" "$TITLE" "" "Game;StrategyGame;"
fi
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUNcYwAKCRDlMfrJqhPK
RyimAKCfV4UA8DpR0XyTJVWPlxAIVjHXWQCfY8wt2rfywrzn0xWBF5XQi/dLN/I=
=86h3
-----END PGP SIGNATURE-----
