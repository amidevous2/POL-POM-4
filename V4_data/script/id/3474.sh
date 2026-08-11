#!/bin/bash
# Date : (2019-04-02 23-29)
# Last revision : (2019-04-02 23-29)
# Wine version used : 4.0
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested : v2.1.0.2 (2015. Features added: language and resolution selector).
#
# Known issues :
# - Ubuntu 18.04 : the left side of the menu bar of the OS (Gnome) still appear over the game.
# - When exiting the game : error message (Wine 4.0).

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="World of Goo"
PREFIX="world_of_goo"
WORKING_WINE_VERSION="4.0"
AUTHOR="Dadu042"
EDITOR="2D Boy"
GAME_URL="https://en.wikipedia.org/wiki/World_of_Goo"

Set_OS "win7"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_message "Note: the developper of this game (2D Boy) made a native version for Linux OS, you should prefer it." "$TITLE"

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Minimum version to have access to Wine 4.x
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

# Not necessary:
# POL_Call POL_Install_d3dx9

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
SETUP_EXE="$APP_ANSWER"

POL_SetupWindow_message "When installing you will see some error messages, ignore these." "$TITLE"

POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
cd "$POL_System_TmpDir"

POL_Shortcut "WorldOfGoo.exe" "$TITLE" ""
POL_Shortcut "WorldOfGooSelector.exe" "$TITLE - Settings ('Selector')" ""

POL_Shortcut_Document "$TITLE" "readme.html"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiFYgAKCRDlMfrJqhPK
R8DZAJ9fZJ/KlL75UarTaxD/tExvw0bDZACgjm4SxAevsaiZUammBP/zGbk+YXs=
=o3zP
-----END PGP SIGNATURE-----
