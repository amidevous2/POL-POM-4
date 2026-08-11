#!/bin/bash
 
# Date : (2014-09-28 15-07)
# Wine version used : 1.7.26
# Distribution used to test : Mint 17
# Author : Fake Shemp
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Super Trench Attack!"
PREFIX="SuperTrenchAttack"
 
# Latest working Wine version
WORKING_WINE_VERSION="1.7.26"
  
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
# Presentation
POL_SetupWindow_presentation "$TITLE" "Retro Army Limited" "http://www.retroarmy.com/" "Fake Shemp" "$PREFIX"
 
# Select installation file
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select your installation file.')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
 
# Configure Wine
POL_System_SetArch "amd64"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
Set_OS "win7"
 
# Install program
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
 
# Create shortcut
POL_Shortcut "Super Trench Attack.exe" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRAI1wACgkQ5TH6yaoTykckfwCeKj7APca1jC8bkT1EX0ZPR8YO
UK4An3FrGB6B8wmH6OtmVeFdmH41BH2b
=2utJ
-----END PGP SIGNATURE-----
