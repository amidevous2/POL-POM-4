#!/usr/bin/env playonlinux-bash
# Date : (2019-04-02 22-25)
# Last revision : (2019-04-02 22-25)
# Wine version used : 4.0
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4

# Used : DVD v1.1.0.0 french (version appear on the main menu, at bottom right).
# What does not work :
# - automatic update (this launch the web browser)
# - mods downloading ( " )
# - multiplayer
#
# Game see French's Azerty keyboard as a Qwerty, you will have to reasign some commands keys.
#
# Update tested : v2.1.0.2
#
# About mods: as of 2019-03, the mods are no longuer downloadable from the official website of the game,
# but some are hosted on third part websites.

[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Farming Simulator 2013"
PREFIX="fs2013"
WORKING_WINE_VERSION="4.0"
AUTHOR="Dadu042"
EDITOR="Giants"
GAME_URL="https://en.wikipedia.org/wiki/Farming_Simulator"
   
Set_OS "Win7"
 
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Minimum version to have access to Wine 4.x
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
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
        POL_SetupWindow_check_cdrom "data/d_39104.dat"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi
   
POL_Shortcut "FarmingSimulator2013.exe" "$TITLE" ""

# According your language you can change this filename 
POL_Shortcut_Document "$TITLE" "FarmingSimulator2013_EN.pdf"

POL_Call POL_Install_VideoDriver

# Required (Dadu042)
POL_SetupWindow_VMS "256"

# Seems useless for this game (at least for Wine 4.0)
# POL_Call POL_Install_d3dx9

POL_Call POL_Install_physx

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

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiFrgAKCRDlMfrJqhPK
R+A+AKCsJfWRcWeqiUh5udXmqqUzwni1DwCgpdVaHbehXAT3VwpT3joz/l/POsQ=
=8RUJ
-----END PGP SIGNATURE-----
