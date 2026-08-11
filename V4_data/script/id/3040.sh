#!/usr/bin/env playonlinux-bash
# Date : (2016-10-21 02-54)
# Last revision : (2017-03-14 01-50)
# Wine version used : 1.6.2
# Distribution used to test : Arch x86_64 4.9.14-1-lts
# Author : Hans Bonini
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Hans Bonini] (2016-10-21 02-54)
#   First script.
# [khampf] (2017-03-14)
#   Fixes.
# [Dadu042] (2019-12-30)
#   Wine 2.0 -> 2.22.
#

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
# POL Variables
GOGID="simcity_3000"
PREFIX="Sc3kUnlimited_gog"
WINE_VERSION="2.22"
TITLE="GOG.com - SimCity 3000 Unlimited"
 
# SC3K Variables
SC3K_GAME_EXE="SC3U.EXE"
SC3K_GAME_SHORTCUT="SimCity 3000 Unlimited"
SC3K_LANGUAGESETUP_EXE="language_setup.exe"
SC3K_LANGUAGESETUP_SHORTCUT="SC3K - Language Setup"
SC3K_BAAPP_EXE="Baapp.exe"
SC3K_BAAPP_SHORTCUT="SC3K - Building Architect Plus"
 
# Initialize Setup and Debug it! ;)
POL_SetupWindow_Init
POL_Debug_Init
 
# Show Installer Presentation
POL_SetupWindow_presentation "$TITLE" "Maxis Software Inc. / Electronic Arts" "http://www.gog.com/game/$GOGID" "Hans Bonini" "$PREFIX"
 
# Call GOG Setup Selection
POL_Call POL_GoG_setup "$GOGID" "08def8dc74e350ad94c978eb46770f09"
  
# Configure Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINE_VERSION"
 
# Run GOG Installer
POL_Call POL_GoG_install
 
# Set OS to GOG
Set_OS "winxp"
 
# Set VMS to 64MB
POL_SetupWindow_VMS "64"
 
# Reboot Wine
POL_Wine_reboot
  
# Configure Shortcuts
POL_Shortcut "$SC3K_GAME_EXE" "$SC3K_GAME_SHORTCUT" "" "" "Game;Simulation;"
POL_Shortcut "$SC3K_LANGUAGESETUP_EXE" "$SC3K_LANGUAGESETUP_SHORTCUT" "" "" "Game;Simulation;"
POL_Shortcut "$SC3K_BAAPP_EXE" "$SC3K_BAAPP_SHORTCUT" "" "" "Game;Simulation;"
  
# Show Setup Success Message
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"
  
# Finish
POL_SetupWindow_Close
  
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgtMwgAKCRDlMfrJqhPK
RxrCAJ9ZO9RQVJF2KED9t9spTcnh5Xq2rgCgsHGM4rGDim7Ld+9xFO/50w5bSlA=
=+cjL
-----END PGP SIGNATURE-----
