#!/usr/bin/env playonlinux-bash
# Date : (2019-05-11 21-15)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Media used: CD-ROM, july 2009 (folders date).
#
# CHANGELOG
# [Dadu042] (2019-05-11 21-15)
#   Initial script.
# [Dadu042] (2020-01-27 21:00)
#   Wine 4.1 -> 4.0.3

[ "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Escape the museum"
PREFIX="escapemuseum"
WORKING_WINE_VERSION="4.0.3"
AUTHOR="Dadu042"
EDITOR="Big fish games"
GAME_URL="https://pcgamingwiki.com/wiki/Escape_The_Museum"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
   
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "win7"

################
# GPU settings #
################

# Requires GPU with 128 MB of RAM.
POL_SetupWindow_VMS "128"
 
###############
# Go          #
###############

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
        POL_SetupWindow_check_cdrom "autorun.exe"
        POL_Wine start /unix "$CDROM/autorun.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "Museum.exe" "$TITLE" "" "" "Game;"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiKDgAKCRDlMfrJqhPK
R2znAJ9g7RxfUehqE6NQXOsDmUjwvSHlMwCgml7bbD++mlikHro8sdR1UeyZSLk=
=/NBv
-----END PGP SIGNATURE-----
