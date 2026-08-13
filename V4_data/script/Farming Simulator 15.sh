#!/usr/bin/env playonlinux-bash
# Date : (2019-05-13 16-25)
# Last revision : (2019-05-13 16-25)
# Wine version used : see below
# Distribution used to test : Ubuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
    
[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Farming Simulator 15"
PREFIX="fs15"
WORKING_WINE_VERSION="4.1"
AUTHOR="Dadu042"
EDITOR="Giants"
GAME_URL="https://en.wikipedia.org/wiki/Farming_Simulator"

POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
     
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
   
Set_OS "win7"
 
POL_Call POL_Install_d3dx11
   
###############
# Go          #
###############
     
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
        POL_SetupWindow_check_cdrom "autorun.inf"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi
     
POL_Shortcut "FarmingSimulator2015.exe" "$TITLE" "" "" "Game;"
   
# Filename to change according the language
POL_Shortcut_Document "$TITLE" "FarmingSimulator2015_EN.pdf"
 
# Really indispensable ? (Dadu042)
POL_SetupWindow_VMS "512"

POL_Call POL_Install_VideoDriver

POL_Call POL_Install_physx
 
################
# Patch update #
################
  
POL_SetupWindow_menu "$(eval_gettext 'Do want to install a official update file? (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
   
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the patch file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiPBwAKCRDlMfrJqhPK
RybXAKCgeAULja50MtSUQi3aSntwIkLzOACgoOS8CBupRVhal+m9GFzZThpKU44=
=3LSx
-----END PGP SIGNATURE-----
