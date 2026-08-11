#!/bin/bash
# Date : (2009-08-23 13-00)
# Last revision : (2019-05-18 16-14)
# Wine version used : see below
# Distribution used to test : Ubuntu 19.04
# Author : thib25, Dadu042
# Licence : Retail
#
# Changelog:
# 2019-05-18 Dadu042: fix script that did not start on POL v4.3.4.
#            Rmove 'patch download' feature (because URL is down, and impossible to find a alternative).
#
# Known issues:
# 1. DRM
# Original DVD's DRM is not recognized (I tested up to Wine 4.8), even after
# patching to v1.1 (patch only work from Wine 4.1). I tried 2 "NoCDs" without
# more success. The original DVD game seems impossible to run on Wine. Dadu042.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Colin Mcrae Rally 2005"
PREFIX="colin2005"
WORKING_WINE_VERSION="4.1"
AUTHOR="Dadu042"
EDITOR="Codemasters"
GAME_URL="https://pcgamingwiki.com/wiki/Colin_McRae_Rally_2005"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
   
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"

POL_Call POL_Function_NoCDWarning

################
# GPU settings #
################

# Really indispensable ? (Dadu042)
POL_SetupWindow_VMS "64"

POL_Call POL_Install_VideoDriver

# Useless ?
# POL_Call POL_Install_d3dx9
 
###############
# Go          #
###############

POL_SetupWindow_InstallMethod "LOCAL,DVD"

POL_SetupWindow_message  "Warning: Please DO NOT install Gamespy ! (this is the way this script was tested).\nAnd do not launch the game at the end of the installation." "$TITLE"
   
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "cmr2005.ico"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "CMR5.EXE" "$TITLE" ""
POL_Shortcut_Document "$TITLE" "readme.txt"

###############
# Patch       #
###############
# URL down as of 2019-05-18
# URL="ftp://downloads.codemasters.com/patch/colin_mcrae%20rally_2005%20patch_installer.exe"


POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiOUQAKCRDlMfrJqhPK
RxZtAJ4v52pbpOEtVcbjCbHJNahYSal58gCdEeKcO7buoL4+8hiObiJnvKLqlaQ=
=IrRM
-----END PGP SIGNATURE-----
