#!/bin/bash
# Date : (2014-05-21 21-00)
# Wine version used : system
# Distribution used to test : Ubuntu 14.04 x64
# Author : luyz25
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [luyz25] (2014-05-21 21-00)
#   First script.
# [Dadu042] (2019-12-19 20:50)
#   Wine 1.7.18 -> system

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Deadpool The Game"
PREFIX="DeadpoolTheGame"
GAME_VMS="512"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2036

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "ActiVision" "http://www.activision.com/games/deadpool/deadpool" "luyz25" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,LOCAL"

if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "icon.ico"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Making shortcut
POL_Shortcut "DP.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg5oDQAKCRDlMfrJqhPK
R0wQAJ0bUyvPjBUMJPlDcyiY7wjuj0xbuwCfX2zcTspcPpeKqDjRy0myeesHddo=
=gG3M
-----END PGP SIGNATURE-----
