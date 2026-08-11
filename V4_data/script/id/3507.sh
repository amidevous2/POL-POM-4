#!/usr/bin/env playonlinux-bash
# Date : (2019-02-22 23-56)
# Last revision : (2019-05-09 23-03)
# Wine version used : 4.2
# Distribution used to test : Ubuntu 18.10 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# The DVD used (game version v1.0) is English + Deutch, EMEA edition (Europe).
# Date of Setup.exe is february 27th 2005.
# Note that on the DVD label the date printed is '2005'.
#
# Not tested: online game.

[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Silent Hunter III Download_retry"
PREFIX="silent_hunter_III_dr"
WORKING_WINE_VERSION="4.2"
AUTHOR="Dadu042"
EDITOR="Ubisoft"
GAME_URL="https://en.wikipedia.org/wiki/Silent_Hunter_III"

POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"

###############
# Please note #
###############

POL_SetupWindow_message  "Please note: This game will install but will not run because of the copy protection (as of 2019-02, Wine 4.2. Even with the latest patch 1.4b applied).\n\nWithout that copy protection, it can run and work.\n" "$TITLE"

POL_SetupWindow_message  "Please note: This script game was not tested for online play (as of 2018).\n\nFiles TO NOT INSTALL when asked:\n- Adobe acrobat Reader.\n- Windows Media 9 Codecs\n- GameShadow (click Cancel)." "$TITLE"
 
POL_SetupWindow_InstallMethod "LOCAL,CD,STEAM"
 
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
        POL_Wine "steam.exe" steam://install/15210
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "SH3Autorun.cfg"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
  
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/15210"
else
        POL_Shortcut "sh3.exe" "$TITLE" ""
fi
 
POL_Shortcut_Document "$TITLE" "SH3_MANUAL_EN.pdf"
 
##########################
# Install latest patch ? #
##########################

POL_SetupWindow_menu "$(eval_gettext 'Download and install the patch v1.4b ?')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"

if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then

POL_SetupWindow_menu "$(eval_gettext 'What region code is your game edition ?')" "$TITLE" "$(eval_gettext 'EMEA')~$(eval_gettext 'US')" "~"

if [ "$APP_ANSWER" == "$(eval_gettext 'EMEA')" ]; then
        POL_Download "http://patches.ubi.com/silent_hunter_3/silent_hunter_3_dvd_1.4b_emea.exe" "aa0d304b82af9f0f9b186fe5cd6339f7"
        POL_Wine start /unix "silent_hunter_3_dvd_1.4b_emea.exe"
        POL_Wine_WaitExit "silent_hunter_3_dvd_1.4b_emea.exe"
else
        POL_Download "http://patches.ubi.com/silent_hunter_3/silent_hunter_3_dvd_1.4b_us.exe" "af51e99c515173118bd7731ff2a18cb8"
        POL_Wine start /unix "silent_hunter_3_dvd_1.4b_us.exe"
        POL_Wine_WaitExit "silent_hunter_3_dvd_1.4b_us.exe"
fi
 
fi
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNgeZAAKCRDlMfrJqhPK
RzikAKCTrz5jRplYZQdbc8DRhZ0nK11G8ACglB4mpyXma3KjSsPHMmyxG+xD7nQ=
=M6Id
-----END PGP SIGNATURE-----
