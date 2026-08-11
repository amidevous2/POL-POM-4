#!/bin/bash
# Date : (2013-02-01)
# Last revision : (2013-02-01)
# Distribution used to test : Kubuntu 12.04 LTS
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.1.9

# CHANGELOG
# [SuperPlumus] (2013-06-17 19-35)
#   Update gettext message


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="Absynth5"
WINEVERSION="1.3.0"
TITLE="Absynth 5"
EDITOR="Native Instruments"
GAME_URL="http://www.native-instruments.com"
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
POL_Wine_WaitBefore "$TITLE"
GC_DONT_GC=1 POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts
POL_Shortcut "Absynth\ 5.exe" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: For low-latency audio, look into WineASIO.')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRL+a0ACgkQ5TH6yaoTykfaiQCeMviDtOlYPzRrlKq9xdIpYAIu
oicAn28BRpStxE8MykfL795kssvLzwhA
=qzoY
-----END PGP SIGNATURE-----
