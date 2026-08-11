#!/bin/bash
# Date : (2020-01-18)
# Last revision : see changelog
# Distribution used to test : Ubuntu 18.04 (64-bit)
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.12
 
# CHANGELOG
# [Villarleg] (2020-01-18)
#   Wine and windows version updated, Arch 64bit (Support Traktor Pro 3).
# [Dadu042] (2020-01-19)
#   Add POL_Shortcut category.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
PREFIX="TraktorPro3"
WINEVERSION="3.20"
TITLE="Traktor Pro 3"
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
POL_System_SetArch "amd64"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
  
# Configuration
Set_OS "win10"
Set_SoundDriver "alsa"
  
# Installation
POL_SetupWindow_message "$(eval_gettext 'During installation, please UNCHECK all drivers for the Native Instruments controllers or installation will fail.')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
  
# Create Shortcuts
POL_Shortcut "Traktor.exe" "$TITLE" "" "" "Audio;"
  
POL_SetupWindow_message "$(eval_gettext 'ATTENTION: You need to DISABLE MULTI-CORE PROCESSOR SUPPORT in the Traktors settings for correct functioning or decks will get stuck.\n\n   After you run the program for the first time, a setup wizard will help you setup controller and sound card settings, after you finished the wizard, you need to click on the Gear Icon to open Traktor Preferences screen and uncheck Enable Multi-Core Processor Support in Audio Setup section.\n\nNOTICE: For low-latency audio, look into WineASIO.\n\nYour MIDI controllers should work as expected.')" "$TITLE"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiQV5QAKCRDlMfrJqhPK
R/QmAKCvrKnC7bOME2ums9osW8gLInjNjACfUu7pHYnnONnjT10rXtMaHui8j20=
=K5jA
-----END PGP SIGNATURE-----
