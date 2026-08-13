#!/bin/bash
# Date : (2019-03-01 12-11)
# Last revision : (2019-04-21 00-58)
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux : 4.2.12
#
# Tested : retail DVD (not the 1st edition !) v1.3 (nothing special printed of the DVD),
#          'Eleusis_Setup_13.exe': september 17th 2013.
#
# Note: This game is based on "unreal engine 3".
#
# Known issues (2019-05-06 Dadu042) :
# - Localization : game language selected (when installing) always switch to english.
# - BIK videos does not load (however these seems mainly used for intro credits)
# - A picture of green orb / ball sits in the middle of screen during installation: Fixed if DotNet preinstalled.
#   (Does still occur with Wine 3.0.0, 4.0.0)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Eleusis"
PREFIX="eleusis"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="UIG"
GAME_URL="http://uieg.de"
  
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"
 
# Not sure if indispensable :
POL_Call POL_Install_vcrun2010
 
POL_Call POL_Install_d3dx9_43
 
POL_Call POL_Install_dotnet40
# The game install DotNet 3.5 (SP1) then it download DotNet 4.0, so the old one seems not indispensable :
# POL_Call POL_Install_dotnet35sp1

POL_Call POL_Install_VideoDriver

# Only for Nvidia Physx (not tested)
# POL_Call POL_Install_physx
 
###############
# Please note #
###############
 
POL_SetupWindow_message  "Please note: DO NOT ACCEPT TO INSTALL DotNet35SP1 when asked (Cancel it).\n" "$TITLE"
 
###############
# Install     #
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
        POL_SetupWindow_check_cdrom "UIG GmbH Online.url"
        POL_Wine start /unix "$CDROM/Eleusis_Setup_13.exe"
        POL_Wine_WaitExit "Eleusis_Setup_13.exe"
        cd "$POL_System_TmpDir"
fi
 
POL_Shortcut "UDK.exe" "$TITLE" ""
 
##############################################
# User guide                                 #
##############################################
 
# None found.
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlzOyvgACgkQ5TH6yaoTykfv7wCgqBq9G05Xn1cfiiIkw3b5qcIv
sa4An1qqtEgscQaxgzt8mKec5dVIgXNk
=PUN7
-----END PGP SIGNATURE-----
