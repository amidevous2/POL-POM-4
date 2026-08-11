#!/bin/bash
# Date : (2013-08-20 15-22)
# Last revision : (2013-11-21 21-44)
# Distribution used to test : Debian Jessie
# Author: Fekir
# Wine version used: 1.6

# CHANGELOG
# [SuperPlumus] (2013-09-29 22-12)
#   Update $TITLE var
#   Clean code
#   Update gettext messages

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Age of Empires II : The Conquerors"
TITLE_REQUIRED="Age of Empires II : The Age of Kings"
PREFIX="AOE2_conq"
WORKING_WINE_VERSION="1.6"

POL_SetupWindow_Init
POL_Debug_Init

################################################
# Check if AOE2: The Age of Kings is installed #
# and if PlayOnLinux is v 4.1.6+               #
################################################
POL_RequiredVersion 4.1.6 || POL_Debug_Fatal "This program requires $APPLICATION_TITLE 4.1.6"
if [ "$(POL_Wine_PrefixExists "AOE2_king")" = "False" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "" "$TITLE"
POL_SetupWindow_presentation "$TITLE" "Ensemble Studios" "http://www.ensemblestudios.com/" "Fekir" "$PREFIX"

###############################################
# Prepare everything for AOE2: The Conquerors #
###############################################
POL_System_TmpCreate "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_CopyDirectory "$POL_USER_ROOT/wineprefix/AOE2_king" "$WINEPREFIX"

#########################
# Select file & install #
#########################
POL_SetupWindow_InstallMethod "CD,LOCAL"
SETUP_OPTIONS=""
if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "aocsetup.exe"
    POL_Wine start /unix "$CDROM/aocsetup.exe" "$SETUP_OPTIONS"
else
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$SETUP_EXE" "$SETUP_OPTIONS"
fi
POL_Wine_WaitExit "$TITLE"
POL_Wine_reboot

###################
# Making shortcut #
###################
POL_Shortcut "age2_x1.exe" "$TITLE" "" "-nostartup" "Game;StrategyGame;"

#########################################
# Install AOE: Age of Kings, Patch 1.0c #
#########################################
POL_SetupWindow_question "$(eval_gettext 'Do you want to install the 1.0c Patch?')" "$TITLE"
if [ "$APP_ANSWER" = "TRUE" ]; then
    POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
    SETUP_OPTIONS=""
    if [ "$INSTALL_METHOD" = "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
    else
        cd "$POL_System_TmpDir"
        POL_Download "http://web.archive.org/web/20120208151108/http://download.microsoft.com/download/ageIIConquerers/Update/1.0c/W982KMe/EN-US/Age2XPatch.exe" "8170ef5a8fa02725dcecc230b2f172ec"
        SETUP_EXE="Age2XPatch.exe"
    fi
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$SETUP_EXE" "$SETUP_OPTIONS"
    POL_Wine_WaitExit "$TITLE"
    POL_Wine_reboot
fi

################
# Clean & exit #
################
POL_System_TmpDelete
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKfqJ4ACgkQ5TH6yaoTykfkUwCeOtMjjXqjIp4T24PjC/1/VEgy
YiIAoKCqs2vIYyr8rvo8WH/L6yYWEqjG
=A3QX
-----END PGP SIGNATURE-----
