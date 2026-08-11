#!/usr/bin/env playonlinux-bash

# Date : (2019-02-23 15-25)
# Last revision : (2019-03-07 09-57)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.10 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# The DVD used (game version v1.02) is the French edition.
# Date of 'install.exe' is 2000.
#
# Not tested: online game.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Crimson Skies"
PREFIX="crimson_skies"
WORKING_WINE_VERSION="4.7"
AUTHOR="Dadu042"
EDITOR="Microsoft"
GAME_URL="https://en.wikipedia.org/wiki/Crimson_Skies_(video_game)"

Set_OS "winxp"

POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

#install external libraries
POL_Call POL_Install_dinput
POL_Call POL_Install_directmusic
POL_Call POL_Install_directplay
POL_Call POL_Install_dsound

###############
# Please note #
###############

POL_SetupWindow_message  "Please note: This script game allow ot install the game but not to make it run (as of 2019-04 with Wine 4.7)." "$TITLE"

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
        POL_SetupWindow_check_cdrom "game/crimson.exe"
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi
  
POL_Shortcut "crimson.exe" "$TITLE" ""

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0


# Issue (crash)
# 
# 0032:err:seh:raise_exception Unhandled exception code c0000005 flags 0 addr 0x7b4699b3

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiKrgAKCRDlMfrJqhPK
R/RaAJ0dyMhDhcai/fu1ZUvjRYPsycfG7gCfQH8uZuBYVfpEBeBGxLbErrIqVrM=
=CH1r
-----END PGP SIGNATURE-----
