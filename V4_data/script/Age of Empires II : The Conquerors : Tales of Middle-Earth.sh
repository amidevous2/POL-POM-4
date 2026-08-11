#!/bin/bash
# Date : (2013-08-20 15-24)
# Last revision : (2013-09-30 08-16)
# Distribution used to test : Debian Jessie
# Author: Fekir
# Wine version used: 1.6

# CHANGELOG
# [SuperPlumus] (2013-09-30 08-16)
#   Update gettext messages
#   Update $TITLE var

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Age of Empires II : The Conquerors : Tales of Middle-Earth"  #va solo se faccio partite con @ davanti
TITLE_REQUIRED="Age of Empires II : The Conquerors"
PREFIX="AOE2_tome"
WORKING_WINE_VERSION="1.6"

POL_SetupWindow_Init
POL_Debug_Init

##############################################
# Check if AOE2: The Conquerors is installed #
# and if PlayOnLinux is v 4.1.6+             #
##############################################
POL_RequiredVersion 4.1.6 || POL_Debug_Fatal "This program requires $APPLICATION_TITLE 4.1.6"
if [ "$(POL_Wine_PrefixExists "AOE2_conq")" = "False" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/AC2/left.jpg" "$TITLE"
POL_SetupWindow_presentation "$TITLE" "ToME Team" "http://aok.heavengames.com/tales-of-middle-earth" "Fekir" "$PREFIX"

POL_SetupWindow_message "$(eval_gettext 'Please notice that Standards Maps do not work correctly, whereas Custom Maps works without problems.')" "$TITLE"

##########################################################
# Prepare everything for AOE2 MOD, Tales of Middle-Earth #
##########################################################
POL_System_TmpCreate "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_CopyDirectory "$POL_USER_ROOT/wineprefix/AOE2_conq" "$WINEPREFIX"

#########################
# Select file & install #
#########################
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
SETUP_OPTIONS="/VERYSILENT"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
else
    cd "$POL_System_TmpDir"
    SETUP_EXE="Tales of Middle-Earth Setup.exe"
    POL_Download "http://www.moddb.com/downloads/mirror/49149/73/932401b564335cd36651c636c95a49db" "1288456158e127c7ffde0cbf6a8e52cb"
    POL_System_unzip "932401b564335cd36651c636c95a49db"
    cd "932401b564335cd36651c636c95a49db_FILES"
fi
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$SETUP_EXE" "$SETUP_OPTIONS"
POL_Wine_WaitExit "$TITLE"
POL_Wine_reboot

###################
# Making shortcut #
###################
POL_Shortcut "age2_x1.exe" "$TITLE" "" "-nostartup" "Game;StrategyGame;"

################
# Clean & exit #
################
POL_SetupWindow_message "$(eval_gettext 'Please notice that Standards Maps do not work correctly, whereas Custom Maps works without problems.')" "$TITLE"
POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJJI08ACgkQ5TH6yaoTykdPEgCeJM4L5v34rr5W1H0hPWst66zM
WeoAnjNFAGypyXPd70HnGc3SP9pseEAb
=jauf
-----END PGP SIGNATURE-----
