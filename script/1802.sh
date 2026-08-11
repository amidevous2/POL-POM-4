#!/bin/bash
# Date : (2013-08-20 15-22)
# Last revision : (2013-09-29 20-13)
# Distribution used to test : Debian Jessie
# Author: Fekir
# Wine version used: 1.6

# CHANGELOG
# [SuperPlumus] (2013-09-29 20-13)
#   Update gettext messages
#   Update $TITLE var

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Age of Empires II : The Conquerors : Age of Vampires - Blood Reign in Transylvania"
TITLE_REQUIRED="Age of Empires II : The Conquerors"
PREFIX="AOE2_vamp"
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
POL_SetupWindow_presentation "$TITLE" "Khan Ivayl" "http://aok.heavengames.com/features/blacksmith-features/age-of-vampires-blood-reign-in-transsylvania/" "Fekir" "$PREFIX"

###################################################################################
# Prepare everything for AOE2 MOD, Age of Vampires - Blood Reign in Transsylvania #
###################################################################################
POL_System_TmpCreate "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_CopyDirectory "$POL_USER_ROOT/wineprefix/AOE2_conq" "$WINEPREFIX"

#########################
# Select file & install #
#########################
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
SETUP_OPTIONS="/S"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
else
    cd "$POL_System_TmpDir"
    POL_Download "http://www.moddb.com/downloads/mirror/38147/72/edbbf5c7bf6010664ed22ff66f030eef" "313c491d6fef25977e1dc7cfbb5c0648"
    POL_System_unzip "edbbf5c7bf6010664ed22ff66f030eef"
    cd "Age_of_Vampires_Bloodreign_in_Transsylvania"
    SETUP_EXE="Install_Age_of_Vampires.exe"
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
POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJJItMACgkQ5TH6yaoTykfXrQCfXOITrlbmy6g9Fw+YbmrcUK9a
blQAn2cDs4iWcYndbP7C2Guk1PqSkf1h
=d/4E
-----END PGP SIGNATURE-----
