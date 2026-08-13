#!/bin/bash
# Date : (2009-05-23 12-14)
# Last revision : (2016-06-23 23-58)
# Wine version used : 1.3, 1.8.3, 3.0
# Distribution used to test : Debian Squeeze (Testing), Arch Linux, Ubuntu 18.04 x64
# Author : NSWL & GNU_Raziel
# Licence : Retail
#
# CHANGELOG
# [NSWL & GNU_Raziel] (2009-05-23 12-14)
#   Initial script.
# [Dadu042] (2020-01-27 23:30)
#   Improve shortcut.
#   Wine 3.0 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Need For Speed Most Wanted"
PREFIX="NFSMW"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="32"
 
#starting the script
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "EA Games" "N/A" "NSLW & GNU_Raziel" "$PREFIX"
 
#preparing Wine prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
#Choose between CD, DVD and Digital Download version
POL_SetupWindow_InstallMethod "CD,DVD,LOCAL"
 
if [ "$INSTALL_METHOD" == "CD" ]; then
        #asking for CDROM and checking if it's correct one
        #CD-ROM 1
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "AutoRun.exe"
        cd "$WINEPREFIX/dosdevices"
        rm "d::"
        ln -s "$CDROM" "d:"
        cd "$CDROM"
        POL_Wine "AutoRun.exe"
        POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for reboot\nclick on "Yes" then click on "Next".')"
        POL_Wine "AutoRun.exe"
        POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next disk\nclick on "Next".')"
        #CD-ROM 2
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')"
        POL_SetupWindow_cdrom
        cd "$WINEPREFIX/dosdevices"
        rm "d:"
        ln -s "$CDROM" "d:"
        POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next disk\nclick on "Next".')"
        #CD-ROM 3
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')"
        POL_SetupWindow_cdrom
        rm "d:"
        ln -s "$CDROM" "d:"
        POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next disk\nclick on "Next".')"
        #CD-ROM 4
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')"
        POL_SetupWindow_cdrom
        rm "d:"
        ln -s "$CDROM" "d:"
        POL_SetupWindow_message "$(eval_gettext 'When the game setup will ask for next disk\nclick on "Next".')"
        #CD-ROM 1
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')"
        POL_SetupWindow_cdrom
        rm "d:"
        ln -s "$CDROM" "d:"
        POL_SetupWindow_message "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
elif [ "$INSTALL_METHOD" == "DVD" ]; then
        #asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "AutoRun.exe"
        cd "$CDROM"
        POL_Wine "AutoRun.exe"
        POL_Wine_WaitExit "$TITLE"
else
        #Asking then installing DDV of the game
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
        POL_Wine "$APP_ANSWER"
        POL_Wine_WaitExit "$TITLE"
fi
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS "$GAME_VMS"
 
## PlayOnMac Section
[ "$PLAYONMAC" == "" ] && Set_SoundDriver "alsa"
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section
 
# Making shortcut
POL_Shortcut "speed.exe" "$TITLE" "" "" "Game;"
 
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjCCkwAKCRDlMfrJqhPK
R8IsAJ9yZsEmG8pzzZTf76Grq8a6IRRkhACfURvlGURrv9Y9gyVtopxXON9THWI=
=inuc
-----END PGP SIGNATURE-----
