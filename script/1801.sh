#!/bin/bash
# Date : (2013-08-20 15-22)
# Last revision : (2015-02-23)
# Distribution used to test : Debian Jessie
# Author: Fekir
# Wine version used: 1.6
 
# CHANGELOG
# [SuperPlumus] (2013-09-29 19-22)
#   Update gettext messages
#   Update $TITLE var
# [rogue-spectre] (2015-02-23)
#   Add browse menu to select local zip file
#   Update md5sum
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Age of Empires II : The Conquerors : Forgotten Empires"
TITLE_REQUIRED="Age of Empires II : The Conquerors"
PREFIX="AOE2_forg"
WORKING_WINE_VERSION="1.6"
 
POL_SetupWindow_Init
POL_Debug_Init
 
##############################################
# Check if AOE2: The Conquerors is installed #
# and if PlayOnLinux is v 4.1.6+             #
##############################################
POL_RequiredVersion 4.1.6 || POL_Debug_Fatal "This program requires $APPLICATION_TITLE 4.1.6"
if [ "$(POL_Wine_PrefixExists "AOE2_conq")" = "False"  ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi
 
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/AC2/left.jpg" "$TITLE"
POL_SetupWindow_presentation "$TITLE" "AoFE team" "http://www.forgottenempires.net" "Fekir" "$PREFIX"
 
##################################################
# Prepare prefix for AOE2: Forgotten Empires     #
##################################################
POL_System_TmpCreate "$PREFIX"
# Force Clean of "old" tmp files
POL_System_TmpDelete
POL_System_TmpCreate "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
FULL_INSTALLER="$POL_System_TmpDir/fe_update.zip"

#########################
# Select file           #
#########################
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the archive file to extract.')" "$TITLE" "" "Windows Archive (*.zip)|*.zip;*.ZIP"
    cp "$APP_ANSWER" "$FULL_INSTALLER"
else # DOWNLOAD
    cd "$POL_System_TmpDir"
    DOWNLOAD_URL="http://forgottenempires.net/fe_update.zip"
    DOWNLOAD_MD5="5e0225dbdc0d8d2279a88c24626c3956"
    DOWNLOAD_FILE="$POL_System_TmpDir/fe_update.zip"
    POL_Call POL_Download_retry "$DOWNLOAD_URL" "$DOWNLOAD_FILE" "$DOWNLOAD_MD5" "$TITLE archive"
fi

###################
# Install         #
###################
POL_System_CopyDirectory "$POL_USER_ROOT/wineprefix/AOE2_conq" "$WINEPREFIX"
SETUP_OPTIONS=""
# not sure POL_LoadVar_PROGRAMFILES usefull
POL_LoadVar_PROGRAMFILES
cd "$POL_System_TmpDir"
POL_System_unzip "$FULL_INSTALLER"
cp -r "$POL_System_TmpDir/Games" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/"
cp "$POL_System_TmpDir/Age2_x1/age2_x2.exe" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/age2_x1"
cp "$POL_System_TmpDir/Age2_x1/FixAoFE.exe" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/age2_x1"
cp "$POL_System_TmpDir/version.txt" "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/"
POL_Wine start /unix "$WINEPREFIX/drive_c/$PROGRAMFILES/Microsoft Games/Age of Empires II/age2_x1/FixAoFE.exe" "$SETUP_OPTIONS"
POL_Wine_reboot
 
###################
# Making shortcut #
###################
POL_Shortcut "age2_x2.exe" "$TITLE" "" "-nostartup" "Game;StrategyGame;"
 
################
# Clean & exit #
################
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOt6pgAKCRDlMfrJqhPK
R9yTAJoCEO8bm8rxvZ0IrBsI51TcNt8PwQCdHa97jWBsRH0akTQaVFFGRHSgOJo=
=KaDl
-----END PGP SIGNATURE-----
