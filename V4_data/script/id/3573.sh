#!/usr/bin/env playonlinux-bash
# Date : (2019-07-26)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : YAZD_HD.exe has File Version 2017.3.0.11139181 
#
# Game based on (ie: middlewares): Mono, DirectX 11.
#
#
# CHANGELOG
# [Dadu042] (2019-07-26)
#   First script.
#   To do : remove the many Wine warnings (d3d11) in the log.
# [Dadu042] (2019-07-29)
#   Switch x86 to amd64
#
# KNOWN ISSUES
#  - Doing ALT+TAB does freeze the game.
#  - Menu options -> Setup commands : unreadable (no text). Fix: POL_Install_corefonts.
#  - Game does use of lot of CPU.
#  - Wine 3.0.3: game is slow to start (5 min ?) then display only the 2D texts, not the game it self (sounds and musics are OK).
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
        
TITLE="Yet Another Zombie Defense HD"
PREFIX="Yet_Another_Zombie_Defense_HD"
WORKING_WINE_VERSION="4.0.1"
AUTHOR="Dadu042"
EDITOR="Awesome Games Studio"
GAME_URL="http://www.awesomegamesstudio.com"
   
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
 
POL_Call POL_Install_corefonts
 
# This web game was not released on CD/DVD.
# POL_SetupWindow_InstallMethod "LOCAL,STEAM,CD" 
POL_SetupWindow_InstallMethod "LOCAL,STEAM"
    
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
  
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the archive file?.')" "$TITLE" "$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
    
if [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
  
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
else
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
  
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/"
fi
  
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/674750
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom ""
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi
     
     
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/674750"
else
        # Try to avoid to have a huge log file (Wine 4.0.1)
        # Does not work:
        POL_Shortcut_InsertBeforeWine "$SHORTCUT" "WINEDEBUG=-all"
        # Seems to not work:
        # POL_Shortcut_InsertBeforeWine "$SHORTCUT" "WINEDEBUG=-d3d,-d3d11,-d3d_shader"
         
        POL_Shortcut "YAZD_HD.exe" "$TITLE" "" "" "Game;ActionGame;"
#        POL_Shortcut_Document "$TITLE" "readme.txt"
fi
 
# GPU selection. Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
POL_Call POL_Install_VideoDriver

POL_SetupWindow_message "Note: this game produce log files (about 3D). You should write into the box 'Debug Flags': -all,fixme-all" "$TITLE"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXT9H/wAKCRDlMfrJqhPK
R6FKAKCSa149VzvH9L9PnXu6GvFwzVyb4gCeOfdVGsgJcXDbdaq/Fa50h3D+vTE=
=YWpf
-----END PGP SIGNATURE-----
