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
# Tested version : 2016 ? (a updated version ?. The first release was in 2014).
#
# Game based on: DirectX 9.
#
#
# CHANGELOG
# [Dadu042] (2019-07-06)
#   Initial writting.
# [Dadu042] (2019-10-31)
#   New attempts but texts are still not displayed.
# [Dadu042] (2020-02-23)
#   Fix POL_Shortcut

#
# KNOWN ISSUES
# - Wine amd64 3.0.5, 4.0.1, 4.11, 4.15: none texts displayed (same in 32 and 64bits. I tried to install many POL functions: corefonts, tahoma, tahoma2, gdiplus, mono210, ...
# - Wine x86 4.18: same as above.
# - Wine amd64 3.0.5, 4.0.1: wrong display (desktop is break visually) as soon as launched. Fix: virtual desktop window (800x600).
  
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
       
TITLE="Hospital Manager"
PREFIX="hospital-manager"
WORKING_WINE_VERSION="4.0.3"
AUTHOR="Dadu042"
EDITOR="Microids Indie"
GAME_URL="http://cccp.fr/project/hospital-manager/"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"
  
Set_OS "win7"


# Useless
# POL_Call POL_Install_mfc42
# POL_Call POL_Install_msxml4
# POL_Call POL_Internal_InstallFonts

# Useless ?
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3compiler_43
  
# This game was not released on CD/DVD.
POL_SetupWindow_InstallMethod "LOCAL,STEAM"
   
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        # POL_Wine start /unix "$SETUP_EXE"
        # POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
       
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
               
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/348290
        POL_Wine_WaitBefore "$TITLE"
fi
    
    
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/348290"
else
        POL_Shortcut "Hospital Manager.exe" "$TITLE" "" "" "Game;StrategyGame;"
        POL_Shortcut_Document "$TITLE" "readme.txt"
fi
  
################
# Patch update #
################
    
# POL_SetupWindow_menu "$(eval_gettext 'Install a official patch-update ? (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
    
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
  
#######################################
# Create a 'virtual desktop' (window) #
#######################################
    
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
      
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
    
Set_Desktop "On" "$WIDTH" "$HEIGHT"
    
Set_WineWindowTitle "$TITLE"
  
    
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlKaSQAKCRDlMfrJqhPK
R1oYAJ42r3UwSjlhkQ9yaKWAUVXt/oqX0QCfcL9jT9gwlve0/1QaBg08CPr2u0Y=
=zYiR
-----END PGP SIGNATURE-----
