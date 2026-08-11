#!/bin/bash
# Date : (2016-05-07)
# Last revision : see changelog
# Wine version used : see changelog
# Distribution used to test : Mint 17.3
# Author : Nicolas HOUDELOT
# Licence : Retail
#
# Changelog
# (2016-05-07) - Nicolas HOUDELOT
# - Initial Release
# [Dadu042] (2020-03-28)
#   Wine 1.8.2 (outdated) -> 3.0.3 (not tested)


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Definition des variables
TITLE="Tomb Raider Underworld"
PREFIX="TombRaiderUnderworld"
EDITOR="Eidos Interactive"
WEBSITE="http://www.tombraider.com/"
AUTHOR="Nicolas HOUDELOT"
WINEVERSION="3.0.3"
GAME_VMS=128

LNG_SUCCES="$(eval_gettext '$TITLE has been installed successfully.')"
LNG_CPSWARN="$(eval_gettext 'Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff.')"

POL_GetSetupImages "https://upload.wikimedia.org/wikipedia/en/thumb/5/56/Tomb_Raider_-_Underworld.png/64px-Tomb_Raider_-_Underworld.png" "https://upload.wikimedia.org/wikipedia/en/thumb/5/56/Tomb_Raider_-_Underworld.png/150px-Tomb_Raider_-_Underworld.png"  "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$WEBSITE" "$AUTHOR" "$PREFIX"

POL_System_SetArch "auto"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

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
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
POL_Wine start /unix "$CDROM/setup.exe"
POL_Wine_WaitExit "$TITLE"

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
        rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
        chmod -R 777 "$POL_USER_ROOT/tmp/"
        rm -rf "$POL_USER_ROOT/tmp/*"
fi

#simuler_reboot
POL_Wine_reboot
#making shortcut
POL_Shortcut "tru.exe" "$TITLE" "" "" "Game;Adventure;"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_message "$LNG_CPSWARN" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXn/a0wAKCRDlMfrJqhPK
R7VfAKCtBvBUOmFnAhK8MhMjYQ768L7GYACePlCk3VMXC30uem64UsufivYDzj8=
=n2KI
-----END PGP SIGNATURE-----
