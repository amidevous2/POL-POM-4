#!/usr/bin/env playonlinux-bash
# Date : (2015-05-30 10-00)
# Last revision : see Changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 18.04 x64 (IGP: AMD Vega 11, driver: radeon)
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Media used: retail french DVD v1.0 (folders date: 2008-10-17)
#
# Middlewares used by this software : DirectX 9.0c
#
# CHANGELOG:
# [Danny-POL] (2015-05-30 10-00)
#   Initial script.
# [Dadu042] (2019-06-02 14-05)
#   Standardize.
#   Wine 1.7.7 -> 1.9.24
# [Dadu042] (2020-01-29)
#   Wine 1.9.24 -> 3.0.3
#   Fix POL_Shortcut
# [Dadu042] (2020-06-19)
#   Improvements (can install patch)
#
# KNOWN ISSUES :
#  - Wine x86 4.21, 5.0.1, 5.10 (without any DirectX 9 installed): crash as soon as launched (after the window 'Optimize settings' that appear after 'Do you want to start in safe mode ?'). Tried: d3dx9_43 + compiler, DXVK_161, d3dx9. Fix: patch game from v1.0 to v1.2
#  - Wine x86 5.0.1 (without: any DirectX 9 installed, Alsa): crash as soon as launched (after the game splash window, then the window asking 'safe mode' appears, then the game does crash). Fix: patch v1.2
#  - Wine x86 5.0.1 + patch v1.3: same crash as above. Tried: xact, dsound, directmusic, quartz
#  - Wine x86 5.0.1 + patch v1.3: same crash as above. Tried: NoCD. Fix: Wine 4.0.4 (but then the game run with only the background sound).

#  - Wine x86 4.0.4, 5.0.1 (without any DirectX 9 installed): no sound nor music. Tried: xact, quartz, patch 1.2, Alsa. Fix: game patch v1.4.
#  - Wine x86 4.0.4 + patch v1.3: game run fine, but the sound and music are missing, there is only the background sound (sea, insects, fire). Tried: registry patch, directx9, registry patch, xact. Tried (with a clean backup): Wine 4.11 (worse: crash), 4.14 (blinking), 5.10 (black window when launched), 3.20 (graphisms Ok, sounds missing).

#  - Wine x86 5.0.1 + Alsa + patch v1.2->1.4 (without any DirectX 9 installed): all the people become invisible ! (and the weapons), after ~30 seconds the game does crash. Same with patch v1.3, tried d3dx9_43 + compiler
#  - Wine x86 4.21 + patch v1.3: same issue as above (invisible people)

#
# KNOWN ISSUES (FIXED) :
#  - Wine x86 2.22, 3.0.3 (without any DirectX 9 installed): first mission (Semper Fi), some 3D polygons are blinking for some seconds then the game does crash (this issue does not occurs on a IGP Intel HD 4000. My IGP is AMD Vega 11). Fix: Wine 4.0.4, and Wine 5.0.1 + patch v1.2


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Call of Duty: World at War"
PREFIX="CoDWaW"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Danny-POL"
EDITOR="Activison"
GAME_URL="https://en.wikipedia.org/wiki/Call_of_Duty:_World_at_War"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_Call POL_Function_NoCDWarning
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"

#############################################
#  Sound problem fix - pulseaudio related   #
#############################################
# [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
# [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
################
# GPU settings #
################

POL_SetupWindow_VMS "256"
 
POL_Install_VideoDriver
 
POL_Wine_Direct3D "Multisampling" "enabled"

###############
# Go          #
###############
 
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
# POL_SetupWindow_message "Note: at the end of the installation, DO NOT install DirectX when asked."
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
 
# making shortcut
POL_Shortcut "CoDWaW.exe" "$TITLE - Singleplayer" "" "" "Game;Shooter;"
POL_Shortcut_Document "$TITLE - Singleplayer" "help.htm"

POL_Shortcut "CoDWaWmp.exe" "$TITLE - Multiplayer" "" "" "Game;Shooter;"

################
# Patch update #
################

POL_SetupWindow_menu "$(eval_gettext 'Do you have a official patch-update to install ?')" "$TITLE" "$(eval_gettext 'No')~$(eval_gettext 'Yes')" "~"      
          
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi

################################################
# Custom patch if user gets no sound nor music #
################################################

# See 'Notes' at: https://appdb.winehq.org/objectManager.php?sClass=version&iId=14475

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXu8QWgAKCRDlMfrJqhPK
R2J0AKCDymXvwZJIXC5QUXM2ml/NMIc0BQCcC6igvn7fqmlZjPsKxpjzRbCxEXM=
=aoaw
-----END PGP SIGNATURE-----
