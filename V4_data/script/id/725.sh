#!/bin/bash
# Date : (2010-30-10 21-00)
# Last revision : (2019-05-22 23-53)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
# CHANGELOG
# [Dadu042] (2019-05-22 23-53)
#   Upgrade Wine version. Add category. Add support for computers with 2 GPU cards.
# [SuperPlumus] (2013-06-09 14-58)
#   Clean code + gettext. Wine 1.3.6.
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Sonic Fan Remix"
PREFIX="sonicfanremix"
WORKING_WINE_VERSION="3.0"
GAME_VMS="256"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/SFR/top.jpg" "http://files.playonlinux.com/resources/setups/SFR/left.jpg" "SonicFanRemix"
POL_SetupWindow_Init
POL_System_TmpCreate "$TITLE"
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Sonic Fan Team" "http://sonicfanremix.com/" "GNU_Raziel" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Downloading SFR game (it's a freeware)
cd "$POL_USER_ROOT/ressources"
if [ ! -e "SFRDemo_v3.0.0.51258.exe" ]; then
    POL_Download "http://files.playonlinux.com/SFRDemo_v3.0.0.51258.exe" "ad9cd013cd25a2b31a44f1d117fa696b"
fi
 
# Installing game
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "SFRDemo_v3.0.0.51258.exe"
POL_Wine_WaitExit "$TITLE"
 
## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##
 
# Making shortcut
POL_Shortcut "Sonic Fan Remix.exe" "$TITLE" "$TITLE.png" "" "Game;ArcadeGame;"

# Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
POL_Call POL_Install_VideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOXHoAAKCRDlMfrJqhPK
R7kvAJ49+lMleXSVQLajHt2Bu1VSFHwwrgCeLCK86AUVpLx5mIkbJei/v4tuIBU=
=0Vul
-----END PGP SIGNATURE-----
