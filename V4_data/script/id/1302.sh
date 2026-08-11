#!/usr/bin/env playonlinux-bash
# Date : (2012-08-07)
# Last revision : (2019-05-21 06-57)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Author: Tory Gaurnier 
#
# Playonlinux version used : 4.3.4
#
# This game is a hex-based MMORTS.
# The 3D engine of this game is Unity ( https://appdb.winehq.org/objectManager.php?sClass=application&iId=11075 )
#
# Changelog:
# 2019 Dadu042: updates.
# 2012 Tory Gaurnier: first POL script.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Slender: The Eight Pages"
PREFIX="Slenderthe8pages"
  
# Starting the script
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Parsec Productions" "http://www.parsecproductions.com" "Tory Gaurnier" "$PREFIX"

POL_SetupWindow_message "$(eval_gettext 'If you have not already downloaded the game, you will need to. You should be able to find it via a web search engine, you will need the file 'Slender_v0_9_7.zip' for this script to complete.')" "$TITLE"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Create and setup wine prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "4.0.1"

Set_OS "win7"
 
# Install game
POL_SetupWindow_browse "$(eval_gettext 'Select downloaded ZIP file here')" "$TITLE"
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting Slender...')" "$TITLE"
unzip -o "$APP_ANSWER" -d "$WINEPREFIX/drive_c/Program Files" || POL_Debug_Fatal "$(eval_gettext 'Sorry, but that was not a valid .zip file')"

POL_Shortcut "Slender - The Eight Pages.exe" "$TITLE" "" "Game;AdventureGame;"
POL_Shortcut_Document "$TITLE" "readme.txt"

POL_Call POL_Install_VideoDriver

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiM6AAKCRDlMfrJqhPK
RyzUAKCMd3STDtLup8268epMm0+tAKC/UACfYBVOwym5dG9ht+TSFg43VwPkXbc=
=VWm7
-----END PGP SIGNATURE-----
