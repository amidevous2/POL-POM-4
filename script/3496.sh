#!/bin/bash
# Date : (2019-04-27 00-01)
# Last revision : (2019-04-27 00-01)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested : European, 'Gold', 1 CD-ROM. CD version: 'Update3' (Ref: Readme.txt). 'data2.cab': october 2005.
# Game released with DirectX 9.
#
#
# CHANGELOG
# [Dadu042] (2019-04-27 00-01)
#   Initial script.
# [Dadu042] (2020-06-06 15-00)
#   Wine 4.0 -> 4.0.4
#   Improve POL_Shortcut
#
#
# Known issues :
# - No musics (because of .WMA format). Note: you may convert them to MP3 then modify the filenames in 'MusicGenre.txt'.
# - Resolutions availables are only 800x600 and 1024x768 (no 1366x768).
# - DRM does not always recognize the CD-ROM #1 (see below).

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="RollerCoaster Tycoon 3 Wild"
TITLE_BASIC="RollerCoaster Tycoon 3"
PREFIX="RollerCoaster_Tycoon_3"
WORKING_WINE_VERSION="4.0.4"
AUTHOR="Dadu042"
EDITOR="Frontier Developments"
GAME_URL="https://en.wikipedia.org/wiki/RollerCoaster_Tycoon_3"


POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 24933
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_SetupWindow_message "Warning: '$TITLE' need to install onto '$TITLE_BASIC' in order to work !.\nThis mean that you must have install '$TITLE_BASIC' first with PlayOnLinux, otherwise please cancel." "$TITLE"

POL_SetupWindow_message "Choose Overwrite !." "$TITLE"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
Set_OS "winxp"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

# No musics (.WMA) played even with this function :
# POL_Call POL_Install_DirectShowFiltersFix


POL_SetupWindow_InstallMethod "LOCAL,CD"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "RCT3.ico" "RCT3W.DAT"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "rct3.exe" "$TITLE" "" "" "Game;Simulation;"

#############################################
# Link to the user manual (multi languages) #
#############################################
POL_SetupWindow_menu "$(eval_gettext 'Which language version of the game do you have installed ?')" "$TITLE" "DAN~DEU~ENU~ESP~FRA~ITA~NDL~NOR~SUO~SVE" "~"
POL_Shortcut_Document "$TITLE" "RCT3W_MANUAL_$APP_ANSWER.pdf"

#################
# About the DRM #
#################
# Following line not required because the CDs DRM is compatible with Wine 4.0.
# POL_Call POL_Function_NoCDWarning
POL_SetupWindow_message "About this game's DRM (anticopy): When launching a game session, the DRM sometimes does not recognize the original CD-ROM #1. Workaround: eject it then reinsert it." "$TITLE"


POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXtuxVAAKCRDlMfrJqhPK
R2z4AJ9fG0glAN8DTnOXb6vcJW+bsTOZuACdFqXJZgymCVAcBpB1RTfWrT9b9F0=
=Pfxv
-----END PGP SIGNATURE-----
