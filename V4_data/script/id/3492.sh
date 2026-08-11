#!/bin/bash
# Date : (2019-02-22 22-55)
# Last revision : (2019-02-22 22-55)
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Tested : CD v1.0.0.5 (according README.TXT) or v1.0.0.7 (according the main menu), French, setup.exe may 2000.
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Ground Control"
PREFIX="ground_control"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Massive Entertainment"
GAME_URL="https://en.wikipedia.org/wiki/Ground_Control_(video_game)"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
POL_SetupWindow_message "Note: DirectX 7 DOES NOT need to be installed." "$TITLE"
 
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
        POL_SetupWindow_check_cdrom "OPENGL32.DLL"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
  
POL_Shortcut "gc.exe" "$TITLE" ""
 
# Link to the french user guide (useless because Ground control 1 does not copy it to the HDD)
# POL_Shortcut_Document "$TITLE" "GCManuel.pdf"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAly7WpAACgkQ5TH6yaoTykcJvQCeOJTkC8BmYmVDOVYuT+3XZrTw
HD4An2fLXfjOUhcy7Y0lGuRTBlV6MsNL
=tPFi
-----END PGP SIGNATURE-----
