#!/bin/bash
# Date : (2017-01-24 15:42)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu Mate 16.04 LTS, 32-bit
# Author : lahtis <lahtis@gmail.com>
# Script licence : GPLv2
# Program version : Retail original 2 CD box
# Bug reports -> 
# Latest install script -> https://github.com/lahtis/playonlinux/blob/master/working/X-WING-Collector-series
# Game running only 640x480 grapics and needed a joystick.
#
# CHANGELOG
# [lahtis] (2017-01-24 15:42)
#   Initial script.
# [Dadu042] (2020-01-14 22:00)
#   Wine 2.0-rc5 -> 3.0.3

[ -z "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

PREFIX="XWING-FlightSchool"
TITLE="X-WING Collector series - Flight School"
WORKING_WINE_VERSION="3.0.3"
EDITOR="LucasArts"           
GAME_URL=""
AUTHOR="lahtis"
GAME_VMS="32"

# Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init
 
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Fix pulseaudio issue
which pulseaudio && Set_OS "win95"

# Asking for CDROM and checking if it's correct one
POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive')" "$TITLE"
POL_SetupWindow_check_cdrom "setup.exe"
POL_SetupWindow_cdrom

POL_Wine start /unix "$CDROM/setup.exe" || POL_Debug_Fatal "$(eval_gettext 'Error while installing game.')"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "xwingtie.exe" "X-WING / XvT: Flight School Laucher" "$TITLE.png"
POL_Shortcut "z_xvt__.exe" "Play XvT: Flight School" "$TITLE.png"
 
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')"
 
POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDQ4AAKCRDlMfrJqhPK
R3UMAJ0USJdyDWTqyYYXmpByHJYOow+UqACcCxOHPIz6FOFjMRCXu7GsNNDYPuE=
=a8Ea
-----END PGP SIGNATURE-----
