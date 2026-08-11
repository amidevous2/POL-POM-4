#!/bin/bash
# Date : (2013-08-20 15-23)
# Last revision : (2013-09-29 21-56)
# Distribution used to test : Debian Jessie
# Author: Fekir
# Wine version used: 1.6

# CHANGELOG
# [SuperPlumus] (2013-09-29 21-56)
#   Update gettext messages
#   Update $TITLE variable
#   Remove POL_SetupWindow_wait + POL_Wine_WaitExit (that was unnecessary)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Age of Empires II : The Conquerors : Rome at War"
TITLE_REQUIRED="Age of Empires II : The Conquerors"
PREFIX="AOE2_raw"
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
POL_SetupWindow_presentation "$TITLE" "WildFire Games" "http://wildfiregames.com/raw/" "Fekir" "$PREFIX"

################################################
# Prepare everything for AOE2 MOD, Rome at War #
################################################
POL_System_TmpCreate "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_CopyDirectory "$POL_USER_ROOT/wineprefix/AOE2_conq" "$WINEPREFIX"

# forse non serve
POL_SetupWindow_menu_num "$(eval_gettext 'In order to installa $TITLE we need to install first Mod Pack Studio Lite 2.0')" "$TITLE" "DOWNLOAD~LOCAL" "~"
SETUP_OPTIONS="/S"
if [ "$APP_ANSWER" -eq 1 ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
else
    cd "$POL_System_TmpDir"
    POL_Download "http://wildfiregames.com/raw/litsetup_v20.zip" "660ca5503b3536f4f73376d37e4f43f2"
    POL_System_unzip "litsetup_v20.zip"
    SETUP_EXE="litsetup.exe"
fi
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$SETUP_EXE" "$SETUP_OPTIONS"
POL_Wine_WaitExit "$TITLE"
POL_Wine_reboot


#########################
# Select file & install #
#########################
cd "$POL_System_TmpDir"
POL_Download "http://wildfiregames.com/raw/WFSRaWScenv_2.zip" "792168f8ad473969390d5406f5f04f80"
POL_System_unzip "WFSRaWScenv_2.zip"
POL_LoadVar_PROGRAMFILES
mv *.mp3 "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/Sound/stream"
mv *.txt "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/History"
mv *.ai "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/AI"
mv *.per "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/AI"
mv *.cpx "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/Scenario"
mv *.dll "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II"
mv *.akx "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II"
POL_Wine_reboot

###################
# Making shortcut #
###################
POL_Shortcut "start.exe" "$TITLE" "" "/unix '$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/WFSRaWScnv2.akx'" "Game;StrategyGame;"

################
# Clean & exit #
################
POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJJIiAACgkQ5TH6yaoTykddqgCdHj8JR1U5JA/l856VQGoteZV7
LjkAoJyAJqLWq2YhtKhXXDtaXc7DV2FX
=JOe4
-----END PGP SIGNATURE-----
