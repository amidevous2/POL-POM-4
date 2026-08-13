#!/bin/bash
#!/usr/bin/env playonlinux-bash
# Date : (2019-07-01)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : CD-ROM, files date: 2016, v1.005 (found in menu Credits, top right).
#
# Game based on: DirectX 9 v46, Visual C++ 2013, Autodesk Stingray (game engine).

#
# CHANGELOG
# [Dadu042] (2019-07-01)
#   Initial writting.
#   How to force this game to use d3dx9 ? (it switch to d3dx11)
# [Dadu042] (2019-09-28)
#   Game now run, but has no sound.
#
#
# KNOW ISSUES
#  - wine 4.15 amd64: music OK, sounds NOK.
#
# ISSUES FIXED
#  - wine 3.0.3, 4.0.1, 4.12.1: Installation does freeze because "Additional icon: Create a desktop icon" is blinking. Workaround: wait 10 min.
#  - wine 3.0.3, 4.0.1, 4.12.1: game fail to launch. Fix: POL_Install_riched30
#  - wine 4.0.2 amd64: clicking Options in the main menu lead to a crash (AL lib: (EE) ReleaseThreadCtx: Context 0x7defbcc0 current for thread being destroyed, possible leak!). Fix: Wine 4.15
#  - wine 4.15, 4.8 amd64: no sound. Sound OK with Wine 3.0.3 and 3.21 (but Options and Play does crash. Tried: POL_Install_gecko, mono210). Fix: install libfaudio0.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Kill All Zombies"
PREFIX="Kill-All-Zombies"
AUTHOR="Dadu042"
WORKING_WINE_VERSION="4.15"
EDITOR="http://www.beatshapers.com"
GAME_URL="http://www.beatshapers.com/zombies/"
    
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"
   
Set_OS "win7"



# Useless ?
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3compiler_43

# Useless for thez issue 'blinking install menu'.
# POL_Call POL_Install_gdiplus

POL_Call POL_Install_riched30

# POL_Call POL_Install_gecko
# POL_Call POL_Install_mono210

 
POL_SetupWindow_InstallMethod "LOCAL,STEAM,DVD"

# POL_SetupWindow_message "Note: at the end of the installation, please do not run the game, and do not install DirectX 9." "$TITLE"

POL_SetupWindow_message "Note: among the next windows, one might blink and freeze (below the text 'Additional icon: Create a desktop icon'), just wait 5 minutes." "$TITLE"
 
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
        POL_Wine "steam.exe" steam://install/303720
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "#killallzombies.ico"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
 
 
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/303720"
else
        # Restore screen resolution (game's default is 640x480)
        POL_Shortcut_InsertBeforeWine "$SHORTCUT" "trap 'xrandr -s 0' EXIT"
         
        POL_Shortcut "zombies.exe" "$TITLE" "" "" "Game;ActionGame;"
#        POL_Shortcut_Document "$TITLE" "jc_manual_uk_pc.pdf"
fi

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have a big useless POL/POM log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"
 
################
# Patch update #
################
 
# POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ? (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
 
# if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
#         POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
#         PATCH_EXE="$APP_ANSWER"
#         POL_Wine start /unix "$PATCH_EXE"
#         POL_Wine_WaitExit "$PATCH_EXE"
# fi
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXY9jyQAKCRDlMfrJqhPK
RwyEAJwITTcmOdUflNAEGwYejt7iKDugbACcCn2xsvg8LMJXPmnMUbNlUyFxGpE=
=wkpA
-----END PGP SIGNATURE-----
