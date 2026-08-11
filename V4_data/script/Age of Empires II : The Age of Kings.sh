#!/bin/bash
# Date : (2013-08-20 15-13)
# Last revision : see changelog
# Distribution used to test : Debian Jessie
# Author: Fekir
# Wine version used: 

# CHANGELOG
# [SuperPlumus] (2013-09-29 22-29)
#   Update gettext messages
#   Update $TITLE var
# [SuperPlumus] (2013-12-08 18-27)
#   Update gettext messages
# [Dadu042] (2021-07-28 13-00) 
"    Wine 1.7.46 -> 3.0.3 (not tested)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Age of Empires II : The Age of Kings"
PREFIX="AOE2_king"
WORKING_WINE_VERSION="3.0.3"

POL_SetupWindow_Init
POL_Debug_Init

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "" "$TITLE"

POL_SetupWindow_presentation "$TITLE" "Ensemble Studios" "http://www.ensemblestudios.com/" "Fekir" "$PREFIX"

#############################################
# Prepare everything for AOE2: Age of Kings #
#############################################
POL_System_TmpCreate "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_Wine_InstallFonts

#########################
# Select file & install #
#########################
POL_SetupWindow_InstallMethod "CD,LOCAL"
SETUP_OPTIONS=""
if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "aoesetup.exe"
    POL_Wine start /unix "$CDROM/aoesetup.exe" "$SETUP_OPTIONS"
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
POL_Shortcut "empires2.exe" "$TITLE" "" "-nostartup" "Game;StrategyGame;"

#########################################
# Install AOE: Age of Kings, Patch 2.0a #
#########################################
POL_SetupWindow_question "$(eval_gettext 'Do you want to install the 2.0a Patch?')" "$TITLE"
if [ "$APP_ANSWER" = "TRUE" ]; then
    SETUP_OPTIONS=""
    POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
    if [ "$INSTALL_METHOD" = "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
    else
        cd "$POL_System_TmpDir"
        SETUP_EXE="Age2upA.exe"
        POL_Download "https://archive.org/download/LEVEL92000R/LEVEL_9_2000R.iso/Updates%2FAge%20of%20Empires%202%2Fage2upa.exe" "20b9fd4ebd51d0375882f4f510ca7c36"
    fi
    POL_Wine_WaitBefore "Patch 2.0a"
    POL_Wine start /unix "$SETUP_EXE" "$SETUP_OPTIONS"
    POL_Wine_WaitExit "Patch 2.0a"
    POL_Wine_reboot
fi

################
# Clean & exit #
################
POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYQAUWgAKCRDlMfrJqhPK
R1nKAKCBrPFc01qcZZ9I/QXGkPSnmnB8RwCfYPVZDJfjOGY/P1lsAQv1SypuOwY=
=/plB
-----END PGP SIGNATURE-----
