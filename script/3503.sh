#!/usr/bin/env playonlinux-bash
# Date : (2019-05-01 21-46)
# Last revision : (2019-05-01 21-46)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : ?
#
# Playonlinux version used : 4.3.4
#
# Version tested: DVD Quake v1.0.x for Windows (Quake4.exe : september 2005)
#
# Note: Quake 4 had a Linux native release.
#
# -----------------------
#
# Issues known :
#
# Wine 4.6 and 4.7 : mouse cursor has severe lag strikes.
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Quake 4"
PREFIX="quake4"
WORKING_WINE_VERSION="4.1"
AUTHOR="Dadu042"
EDITOR="ID Software"
GAME_URL="https://en.wikipedia.org/wiki/Quake_4"
 
Set_OS "WinXP"
 
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

###############
# Go          #
###############

POL_SetupWindow_InstallMethod "LOCAL,DVD"

POL_SetupWindow_message  "Warning: when the Quake 4 installer will ask you, DO NOT install PunkBuster nor DirectX 9 !.\n" "$TITLE"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Quake 4(TM).msi"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "Quake4.exe" "$TITLE" ""
POL_Shortcut_Document "$TITLE" "manual.htm"

Set_WineWindowTitle "$TITLE"

POL_SetupWindow_VMS "64"

POL_Call POL_Install_VideoDriver

################
# Patch update #
################
 
POL_SetupWindow_menu "$(eval_gettext 'Do want to install a official update file? (downloaded by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
 
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the patch file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi

# Option: automate to set a unknown resolution ? (ref: https://pcgamingwiki.com/wiki/Quake_4 )
   
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiCTAAKCRDlMfrJqhPK
R86RAKCuLbOxj7u6pq47v/2ydzEEFaeo0wCfbUwYIHD3bCWiWN4hxGeqWORWGdI=
=GPhR
-----END PGP SIGNATURE-----
