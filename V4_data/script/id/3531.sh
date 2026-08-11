#!/usr/bin/env playonlinux-bash
# Date : (2019-05-28 22-17)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: 2011
# Software based on: ?
#
# CHANGELOG
# [Dadu042] (2019-05-28 22-17)
#   Initial writting.
#
# Known issues:
#   None.
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
      
TITLE="The Binding of Isaac"
PREFIX="bindings_isaac"
WORKING_WINE_VERSION="4.0.1"
AUTHOR="Dadu042"
EDITOR="Edmund McMillen"
GAME_URL="https://bindingofisaac.com/"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
  
Set_OS "win7"
  
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_d3dx10
# POL_Call POL_Install_d3dx11
  
# Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
# POL_Call POL_Install_VideoDriver
#
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS
  
###############
# Go          #
###############
 
POL_SetupWindow_InstallMethod "LOCAL"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        # POL_Wine start /unix "$SETUP_EXE"
        # POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
 
    # TARGET_DIR="$WINEPREFIX/drive_c/$PREFIX"
    # mkdir -p "$TARGET_DIR"
    # cd "$TARGET_DIR"
  
     
  # POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
  cd "$WINEPREFIX/drive_c"
  mkdir $PREFIX
  cd $PREFIX
    POL_System_unrar x "$APP_ANSWER"
    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
     
# elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
 
fi
 
POL_Shortcut "Binding_of_isaac.exe" "$TITLE" ""
 
# POL_Shortcut_Document "$TITLE" "readme.html"
  
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXO21IAAKCRDlMfrJqhPK
R27XAJoDb7HQ2ltiTktMxYSbUWAfUa19UgCgnzR8qk5t+gKIucgqzqFwMiaPHmg=
=10Yw
-----END PGP SIGNATURE-----
