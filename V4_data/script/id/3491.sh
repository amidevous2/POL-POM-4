#!/bin/bash
# Date : (2019-03-01 12-11)
# Last revision : (2019-03-02 16-49)
# Wine version used : 4.2
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux : 4.3.4
#
# Tested : retail DVD, setup.exe: december 2nd 2002.
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Beyond Good & Evil"
PREFIX="beyond_good_evil"
WORKING_WINE_VERSION="4.2"
AUTHOR="Dadu042"
EDITOR="Mindscape"
GAME_URL="https://en.wikipedia.org/wiki/Beyond_Good_%26_Evil_(video_game)"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "winxp" "sp1"
 
###############
# Please note #
###############
  
POL_SetupWindow_message  "Please note: do not accept online registering, nor icons creation.\n" "$TITLE"
 
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
        POL_SetupWindow_check_cdrom "Mindscape.bmp"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
 
POL_Call POL_Install_mfc42
POL_Call POL_Install_d3dx9_43
 
POL_Shortcut "BGE.exe" "$TITLE" ""
POL_Shortcut "SettingsApplication.exe" "$TITLE - Settings Application" ""
 
##############################################
# User guide: (this install any language...) #
##############################################
 
POL_Shortcut_Document "$TITLE" "$PREFIX/English/BeyondGoodAndEvil.pdf"
 
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiC4wAKCRDlMfrJqhPK
RxLrAJ9/wxe17gzLGKxBBhQ3bGn2hJyZMACggOfbuRY4Yej3IDYS+7OD3EFqMcY=
=yRp8
-----END PGP SIGNATURE-----
