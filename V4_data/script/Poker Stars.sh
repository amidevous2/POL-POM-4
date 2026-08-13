#!/bin/bash
# Date : (2013-02-22)
# Last revision : see changelog
# Author : lahtis
# PlayOnLinux: 4.2.12
#
# CHANGELOG
# [lahtis] (2013-02-22)
#   Initial writting.
# [lahtis] (2015-06-08)
#   Updates
# [Dadu042] (2019-06-28)
#   Remove the required Wine version (currently 1.7.47) simplest for future POL's end users.
#   Add LOCAL install option (because the file is hard to download today).
#   Standardize POL_System_Tmp

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Poker Stars"
EDITOR="PokerStars"
EDITOR_URL="http://www.pokerstars.eu/"
PREFIX="PokerStarsEU"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "lahtis" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
 
# Create tmp directory for downloaded files
POL_System_TmpCreate "$PREFIX"
 
# Moving tmp directory
cd "$POL_System_TmpDir"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD" 
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        # Download file
        POL_Download "http://www.pokerstars.net/PokerStarsInstallPM.exe"
 
        # Select setup file
        SETUP="$POL_System_TmpDir/PokerStarsInstallPM.exe"
 
        # Install file && check install errors
        POL_Wine "$SETUP" || POL_Debug_Fatal "$(eval_gettext 'Error while installing. Downloaded file not found.')"
        POL_Wine_WaitExit "$TITLE"
fi

 
# Create shortcut
POL_Shortcut "PokerStars.exe" "$TITLE" "$TITLE.png" "Game;"
 
# Wait is patch is installed
POL_Wine_WaitExit "$TITLE"

# Delete tmp directory
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRewpwAKCRDlMfrJqhPK
R6SMAKCCI8OeJC5VBBMLpKLiab2nrAi2TQCcC3vo31N4c1IU+3Gyd3Ky9Z6WpsU=
=rWK+
-----END PGP SIGNATURE-----
