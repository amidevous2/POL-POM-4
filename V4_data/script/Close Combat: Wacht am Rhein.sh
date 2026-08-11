#!/bin/bash
# Date : (2015-05-12 10-45)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Debian Jessie (Testing)
# Author : Mark Schreiber mark7@alumni.cmu.edu
# Script licence : GPL v.3
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Mark Schreiber] (2015-05-12 10-45)
#   Initial script.
# [Dadu042] (2020-02-23 23:41)
#   Wine 1.6.2 -> system's wine.
#   Standardize.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Close Combat: Wacht am Rhein"
PREFIX="CloseCombatWachtAmRhein"
 
POL_SetupWindow_Init
POL_Debug_Init
 
# The major limitation is that if the in-game resolution setting is
# changed to anything other than 1024x768, the game will crash when
# entering the battlefield.  On the non-4:3 aspect ratio monitors that
# are common today, this leads to a distorted image; however, this is
# still preferable to using a windowed environment and lacking
# scroll-with-mouse-at-edge-of-screen.
 
POL_SetupWindow_message "$(eval_gettext "Once this program is installed, do not change the default resolution in its settings.")" "$TITLE installation"
 
POL_SetupWindow_browse "$(eval_gettext "Please select the setup file to run.")" "$TITLE" ""
 
POL_Wine_SelectPrefix "$PREFIX"
 
POL_Wine_PrefixCreate 
 
POL_Wine "$APP_ANSWER"
 
POL_Wine_WaitExit "$TITLE"
 
POL_Shortcut "CCE.exe" "$TITLE" "" "" "Game;"
POL_Shortcut_Document "$TITLE" "CCWAR-Manual-[LIGHT].pdf"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlI2nQAKCRDlMfrJqhPK
R1JvAJoCj7eq2mcNGFwcVVhQwDSkVB/OEACfaXyCmp3xdz+Nu6Py5F4aPtAGvcg=
=X8Y4
-----END PGP SIGNATURE-----
