#!/bin/bash
#!/usr/bin/env playonlinux-bash
# Date : (2019-06-30)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : KUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.2.12
#
# Tested version : 2005 CD-ROM, "Prison Tycoon.exe" : v1.0.0.0.
#
# Game based on: DirectX 9, C++ code.
#
#
# CHANGELOG
# [Dadu042] (2019-06-30)
#   Initial writting. I used the retail CD-ROM (french).
#
# KNOW ISSUES
# - The STEAM option is set to install 'Prison Tycoon 3'.
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Prison Tycoon"
PREFIX="prison-tycoon"
# WORKING_WINE_VERSION="3.0.5"
AUTHOR="Dadu042"
EDITOR="ValuSoft"
GAME_URL="https://en.wikipedia.org/wiki/Prison_Tycoon"
    
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Really indispensable ? (Dadu042)
POL_SetupWindow_VMS "512"
     
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"
   
Set_OS "win7"
 
# Useless ?
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3compiler_43
 
POL_SetupWindow_InstallMethod "LOCAL,STEAM,CD"
 
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
        POL_Wine "steam.exe" steam://install/12510
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "menu.ini"
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi
 
 
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/12510"
else
        POL_Shortcut "Prison Tycoon.exe" "$TITLE" ""
        POL_Shortcut_Document "$TITLE" "help.htm"
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

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiQFwAKCRDlMfrJqhPK
R1JsAJ9nW+5/0im4s4HgXM7DlKYoi9FPyQCgrgJ9PgVW7+j4kqOZBXGGfpszvLw=
=FV9I
-----END PGP SIGNATURE-----
