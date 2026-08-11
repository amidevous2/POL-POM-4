#!/bin/bash
# Date : (2010-01-09 22-00)
# Last revision : (2019-07-01 02-21)
# Wine version used : 4.0.1
# Distribution used to test : Linux Mint 19.1 Cinnamon - 64-bit
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-06-08 18-54)
#   gettext

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Halo Combat Evolved"
PREFIX="Halo"
WINEVERSION="4.0.1"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/top.jpg" "http://files.playonlinux.com/resources/setups/halo/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 236
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microsoft Games" "http://www.microsoft.com/games/halo/" "GNU_Raziel" "$PREFIX"
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

POL_System_TmpCreate "$PREFIX"
cd $POL_System_TmpDir
POL_Download "http://halo.bungie.net/images/games/halopc/patch/110/halopc-patch-1.0.10.exe" "adeed5e8d33172ec387cb11a89f1b294"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_SetupWindow_InstallMethod "LOCAL,DVD"

# Installing mandatory dependancies
POL_Call POL_Install_d3dx9
POL_Call POL_Install_mfc42
POL_Call POL_Install_msxml4

Set_OS "winxp"

Set_Desktop "On" "1024" "768"

# Asking about memory size of graphic card
POL_SetupWindow_VMS ${GAME_VMS}

if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert the DVD-ROM')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Setup/halo1.ico"
        POL_Wine start /unix "$CDROM/Setup.Exe"
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi

# Sound problem fix - pulseaudio related
if [ "$POL_OS" = "Linux" ]; then
        Set_SoundDriver "alsa"
        Set_SoundEmulDriver "Y"
fi

## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section

#Install patch
POL_Wine_WaitBefore "$(eval_gettext 'Updating $TITLE')"
POL_Wine "$POL_System_TmpDir/halopc-patch-1.0.10.exe"
POL_Wine_WaitExit "$TITLE"

# Making shortcut
POL_Shortcut "halo.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRnE9gAKCRDlMfrJqhPK
RwCVAJ48RCE5Itm19re9Ps9vquw8i+yMJACfcSRxt+Ffk3AS/VCXjSI25rzU8u0=
=KSQe
-----END PGP SIGNATURE-----
