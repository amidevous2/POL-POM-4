#!/bin/bash
# Date : (2019-04-19 21-29)
# Last revision : (2019-04-19 21-29)
# Wine version used : 4.0
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested : v2.2.1046 (RadioSure.exe: january 2016).
#
# CHANGELOG
# [Dadu042] (2019-09-17)
#   First script.
# [Dadu042] (2020-02-03)
#   Add POL_RequiredVersion "4.3.4"
#
# Know issues:
# - The software installs in "~/Local Settings/Application data/RadioSure" (strange).
# - RadioSure's system tray is a little window. How to hide it ?.
# - Filenames of recorded musics have "%20" instead of spaces.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="RadioSure"
PREFIX="radiosure"
WORKING_WINE_VERSION="4.0"
AUTHOR="Dadu042"
EDITOR="TheBestWare Studio"
GAME_URL="http://http://www.radiosure.com/"

Set_OS "windows 7"

POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
cd "$POL_System_TmpDir"

POL_Shortcut "radiosure.exe" "$TITLE" ""

# Seem useless for RadioSure:
# POL_Call POL_Install_quartz
# POL_Call POL_Install_amstream
# POL_Call POL_Install_ffdshow
#
# Note: RadioSure records directly the MP3 stream to the file.

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjde/gAKCRDlMfrJqhPK
R4zXAJ9OHE5lNfS9e4RDNSXtTkBZRgukZgCgsSyYV5Rjo4NWphh0gm8fWxSj7pI=
=Swj9
-----END PGP SIGNATURE-----
