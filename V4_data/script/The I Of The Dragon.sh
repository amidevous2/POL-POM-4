#!/bin/bash
# Date : (2015-02-15)
# Distribution used to test : Ubuntu 14.04 LTS 64-bit
# Author : Lakorta
# Licence : GPLv3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="TheIOfTheDragon"
WINEVERSION="1.7.4-vertex-blending-1.7.4"
TITLE="The I Of The Dragon"
EDITOR="Zuxxez"
GAME_URL="http://www.i-dragon.com/index_eng.htm"
 
# Initialization
POL_SetupWindow_Init
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

# Shortcut
POL_Shortcut "TheIOfTheDragon.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlT3iFUACgkQ5TH6yaoTykfjWACfZenokK2bRUxnYY1nKgn5sw/p
IAYAn11dYMBMFBPLEzJ9FxcpijSJFyFQ
=NcDZ
-----END PGP SIGNATURE-----
