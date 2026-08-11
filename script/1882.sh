#!/bin/bash
# Date : (2013-11-05 ??-??)
# Last revision : (2013-12-18 20-33)
# Wine version used : 1.6
# Distribution used to test : Linux Mint 15 x64
# Author : Ruzven

# CHANGELOG
# [RuzvenBis] (2013-11-05)
#   First script.
# [SuperPlumus] (2013-12-18 20-33)
#   Update wine version 1.6 -> 1.7.8 (http://www.playonlinux.com/fr/topic-11209-System_Shock_2_Steam.html)
# [Dadu042] (2019-12-08)
#   Wine 1.7.8 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="System Shock 2 (Steam)"
PREFIX="System_Shock_2"
WORKING_WINE_VERSION="2.22"
EDITOR="Night Dive Studios"
GAME_URL="http://sshock2.com/"
AUTHOR="Ruzven"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing mandatory dependencies
POL_Call POL_Install_steam

# Begin game installation
POL_SetupWindow_menu "$(eval_gettext 'You want install with ?')" "$TITLE" "$(eval_gettext 'Download on Steam Store-Steam Backup Restore')" "-"

if [ "$APP_ANSWER" = "$(eval_gettext 'Download on Steam Store')" ]; then
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine "steam.exe" steam://install/238210
    POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine "steam.exe"
    POL_SetupWindow_message "$(eval_gettext 'When $TITLE Restore by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
    POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS "$GAME_VMS"

# Making shortcut
POL_Shortcut "Shock2.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXe1M/gAKCRDlMfrJqhPK
R8vyAJ0XsktZPk5U5MZy8VzZLNJ8xh8KCgCeN2zDqMbVyOrt/YnXcDtf+1ximJw=
=nLtn
-----END PGP SIGNATURE-----
