#!/bin/bash
# Date : (2013-04-15)
# Last revision : see changelog
# Distribution used to test : Kubuntu 12.04.2 LTS
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.1

# CHANGELOG
# [SuperPlumus] (2013-06-17 19-47)
#   Update gettext message
# [Dadu042] (2020-01-03)
#   Wine 1.4.1 -> 2.22.
#   Add shortcut category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="FLStudio10"
WINEVERSION="2.22"
TITLE="FL Studio 10"
EDITOR="Image Line Software"
GAME_URL="http://www.image-line.com"
AUTHOR="RoninDusette"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#Dependencies

# Configuration
Set_OS "winxp"
Set_SoundDriver "alsa"

# Installation
POL_SetupWindow_message "$(eval_gettext 'During installation, please UNCHECK the option for ASIO4ALL, and UNCHECK run FL Studio at end of install.')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts
POL_Shortcut "FL.exe" "$TITLE" "" "" "Audio;"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: For low-latency audio, look into WineASIO. Your MIDI controllers should work as expected.')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg+3swAKCRDlMfrJqhPK
R65VAKCt3uRwJv6G3LQSUNYrXD40YgEqXgCfYM2XwxCNet3wLv5jFv2YeiImr4I=
=KGrQ
-----END PGP SIGNATURE-----
