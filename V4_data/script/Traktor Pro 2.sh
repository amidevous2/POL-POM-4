#!/bin/bash
# Date : (2013-03-01)
# Last revision : see changelog
# Distribution used to test : Manjaro KDE 16.10.3 (64-bit)
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.10

# CHANGELOG
# [SuperPlumus] (2013-06-17 19-56)
#   Update gettext message
# [s_epehr] (2016-12-14)
#   Wine version updated, Now compatible with latest Traktor 2 Version 2.11.0
#   also final setup window message reminds users to disable multi-core processor support.
# [Dadu042] (2020-01-18)
#   Wine "1.9.23-staging" (outdated) -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="TraktorPro2"
WINEVERSION="2.22"
TITLE="Traktor Pro 2"
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
POL_Call POL_Install_vcrun2013

# Configuration
Set_OS "win7"
Set_SoundDriver "alsa"

# Installation
POL_SetupWindow_message "$(eval_gettext 'During installation, please UNCHECK all drivers for the NI controllers and audio interfaces. The install will fail if left checked, and are not needed.')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

# Create Shortcuts
POL_Shortcut "Traktor.exe" "$TITLE" "" "" "Audio;"

POL_SetupWindow_message "$(eval_gettext 'ATTENTION: You need to disable Multi-Core Processor Support in the Traktors settings for correct functioning.\n\n   After you run the program for the first time, a setup wizard will help you setup controller and sound card settings, after you finished the wizard, you need to click on the Gear Icon to open Traktor Preferences screen and uncheck Enable Multi-Core Processor Support in Audio Setup section.\n\nNOTICE: For low-latency audio, look into WineASIO.\n\nYour MIDI controllers should work as expected.')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiQXFgAKCRDlMfrJqhPK
R6MxAJ9PJ/0mI2Zx9JF1C1Qd7qeAnK8aCQCeJa9j0WxdMDJ0v/IYqFC7xGCGE7I=
=2M34
-----END PGP SIGNATURE-----
