#!/bin/bash
#!/usr/bin/env playonlinux-bash
# Date : (2019-07-03)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : CD-ROMs, april 2006.
#
# Game based on: DirectX 8, Bink.
#
#
# CHANGELOG
# [Dadu042] (2019-07-03)
#   Initial writting. I used the retail CD-ROMs (french, 4 CD-ROMS).
# [Dadu042] (2019-07-04)
#   Minor changes.
#
# KNOWN ISSUES
# - After inserting CD #2: "Error -1603. A fatal error occurred".
# - Entering the official S/N (provided with the retail CDs) does fail.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
     
TITLE="Rise of Nations: Rise of Legends"
PREFIX="rise_of_legends"
WORKING_WINE_VERSION="4.0.4"
AUTHOR="Dadu042"
EDITOR="Microsoft Game Studios"
GAME_URL="https://en.wikipedia.org/wiki/Rise_of_Nations:_Rise_of_Legends"
     
POL_SetupWindow_Init
POL_Debug_Init
      
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
      
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE 4.3.4 is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"

POL_Call POL_Install_mfc42
POL_Call POL_Install_msxml4

# Useless ?
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3compiler_43

# No 'STEAM' because not available from their shop as June 2019.
POL_SetupWindow_InstallMethod "LOCAL,CD"
 
# Safety recommendation
POL_SetupWindow_message "Note: at the end of the installation, please do not run the game (to select this, you must click Options button)." "$TITLE"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run (install.exe)')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
             
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/xxxxx
        POL_Wine_WaitBefore "$TITLE"
else
	POL_SetupWindow_message "Warning: the installation from CDs will fail when CD #2 inserted ('Error -1603. A fatal error occurred').\n\n Workaround: copy the CDs #2,3,4 into a folder of your HDD, the last to copy is the #1. Then you will have to make the installation from LOCAL." "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Rise Of Legends.msi"
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi
  
  
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/xxxxx"
else
        POL_Shortcut "legends.exe" "$TITLE" ""
        POL_Shortcut_Document "$TITLE" "*.rtf"
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
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX6sLkQAKCRDlMfrJqhPK
R3saAKCHPi1dMTpBYiN8kObcNAFASXdfHQCgqgPN6csj6p/6HiADJVsb8x/y2gg=
=bmhF
-----END PGP SIGNATURE-----
