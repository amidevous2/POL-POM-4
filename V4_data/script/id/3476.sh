#!/bin/bash
# Date : (2019-03-01 12-11)
# Last revision : (2019-03-01 12-11)
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux : 4.2.12
#
# Tested : DVD v1.05 (version readable after game installation, on the main screen. setup.exe: september 2004.
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Heretic Kingdoms - The Inquisition (same as Kult - Heretic Kingdoms)"
PREFIX="heretic_kingdoms_inquisition_kult"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Got Game"
GAME_URL="https://en.wikipedia.org/wiki/Kult:_Heretic_Kingdoms"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "winxp" "sp1"
 
POL_SetupWindow_InstallMethod "LOCAL,DVD"
  
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "kult.ico"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
 
POL_Call POL_Install_mfc42
 
POL_Shortcut "kult.exe" "$TITLE" ""
POL_Shortcut_Document "$TITLE" "readme.txt"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlyp8KYACgkQ5TH6yaoTykfidACfSHcURSlIU489fyeHI7UQk8px
CIYAn1d3yM6vdNpt4Z8myT9buW33leYF
=ZrWs
-----END PGP SIGNATURE-----
