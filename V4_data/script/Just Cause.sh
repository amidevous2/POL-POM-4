#!/bin/bash
#!/usr/bin/env playonlinux-bash
# Date : (2019-07-01)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : KUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.2.12
#
# Tested version : DVD-ROM ('hit collection'), french (multi 5), files date: august 2006.
#
# Game based on: DirectX 9.
#
#
# CHANGELOG
# [Dadu042] (2019-07-01)
#   Initial writting.
# [Dadu042] (2020-01-28)
#   Wine 3.0.5 -> 3.0.3
#   Fix POL_Shortcut
#
# KNOW ISSUES
#  Wine 3.0.5: Game does crash when exiting.
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Just Cause"
PREFIX="just-cause"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Eidos Interactive"
GAME_URL="https://en.wikipedia.org/wiki/Just_Cause_(video_game_series)"
    
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"
   
Set_OS "win7"
 
# Useless ?
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3compiler_43
 
POL_SetupWindow_InstallMethod "LOCAL,STEAM,DVD"
 
POL_SetupWindow_message "Note: at the end of the installation, please do not run the game, and do not install DirectX 9." "$TITLE"
 
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
        POL_Wine "steam.exe" steam://install/6880
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "JustCause.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
 
 
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/6880"
else
        # Restore screen resolution (game's default is 640x480)
        POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
         
        POL_Shortcut "JustCause.exe" "$TITLE" "" "" "Game;ActionGame;"
        POL_Shortcut_Document "$TITLE" "jc_manual_uk_pc.pdf"
fi
 
################
# Patch update #
################
 
POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ? (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
 
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

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjCJnQAKCRDlMfrJqhPK
R9vjAJ9jWSDXsT8fKvfxZJNIQdXaHOXa/gCgqPscFSAFJRNPWuV/60GQnLL3Prg=
=NLfz
-----END PGP SIGNATURE-----
