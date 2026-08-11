#!/bin/bash
# Date : (2013-06-17 ??-??)
# Last revision : (2013-06-27 12-24)
# Wine version used : 1.4.1
# Distribution used to test : Voyager x32
# Author : Ruzven
 
# CHANGELOG
# [Dadu042] (2019-05-23)
#   Fix 'script installation freeze' on Xubuntu 18.04 (POL 4.5.4). Now it continue but break before finishing.
# [SuperPlumus] (2013-06-27 12-24)
#   Clean code
# [SuperPlumus] (2013-12-18 20-43)
#   Update Wine version 1.4.1 -> 1.7.8 (http://www.playonlinux.com/fr/topic-10663-Script_Alien_Swarm.html)
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Alien Swarm"
PREFIX="Alien_Swarm"
WORKING_WINE_VERSION="3.0"
 
EDITOR="Valve"
GAME_URL="http://store.steampowered.com/app/630"
AUTHOR="Ruzven"
GAME_VMS="128"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_SetID 1742
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
 
# Installing mandatory dependencies
POL_Call POL_Install_steam
 
# Begin game installation
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "steam.exe" steam://install/630
POL_Wine_WaitExit "$TITLE"
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS "$GAME_VMS"
 
# Making shortcut
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/630"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOhrXwAKCRDlMfrJqhPK
RzA+AJ9pXkTzxKFcayU9G5PMsuPEZY7iMQCfceFxX4aKm1TAJvQ3MDrg0zveyiY=
=itsM
-----END PGP SIGNATURE-----
