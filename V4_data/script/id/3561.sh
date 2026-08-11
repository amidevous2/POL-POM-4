#!/bin/bash
#!/usr/bin/env playonlinux-bash
# Date : (2019-07-06)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : French (Multi 5 lang), 3 CD-ROMs. CD1: data2.cab = january 2003.
#
# Game based on: DirectX 8 ?.
#
#
# CHANGELOG
# [Dadu042] (2019-07-06)
#   Initial writting.
#
#
# KNOWN ISSUES

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Unreal II The Awakening"
PREFIX="unreal2"
WORKING_WINE_VERSION="4.0.1"
AUTHOR="Dadu042"
EDITOR="Infogrames"
GAME_URL="https://en.wikipedia.org/wiki/Unreal_II:_The_Awakening"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Call POL_Function_NoCDWarning

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"

# Useless
# POL_Call POL_Install_mfc42
# POL_Call POL_Install_msxml4

# Useless ?
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3compiler_43

# This game was not released on CD/DVD.
POL_SetupWindow_InstallMethod "LOCAL,STEAM,CD"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"             
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/13200
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "data1.hdr"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi
  
  
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/13200"
else
        POL_Shortcut "Unreal2.exe" "$TITLE" "" "Game;ActionGame;"
        POL_Shortcut_Document "$TITLE" "MANUAL*.pdf"
fi

################
# Patch update #
################
  
POL_SetupWindow_menu "$(eval_gettext 'Install a official patch-update ? (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
  
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi

  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

#######################################
# Create a 'virtual desktop' (window) #
#######################################

POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
    
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
  
Set_Desktop "On" "$WIDTH" "$HEIGHT"
  
Set_WineWindowTitle "$TITLE"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXSD/rwAKCRDlMfrJqhPK
R7ThAJ4re3z8/ftxNj0gHDqIG6IADyry7gCgj1xeglNHefLmg/nijBE99C5X6qI=
=4Ucj
-----END PGP SIGNATURE-----
