#!/bin/bash
# Last revision : see changelog
# Wine version used : system
# Author : see changelog
# License : GNU/GPL v3

# CHANGELOG
# [Tutul, modified by Fangorn] (2015-12-26)
#   First script.
# [Dadu042] (2020-01-06)
#   Wine 1.8 -> system version.
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_elder_scrolls_iii_morrowind_goty_edition"  
TITLE="GOG.com - The Elder Scrolls III: Morrowind GOTY Edition"
SHORTCUT_NAME="The Elder Scrolls III - Morrowind"
PREFIX="TES3_Morrowind_gog"
EDITOR="Bethesda Softworks"
GAME_URL="http://www.gog.com/gamecard/$GOGID"
AUTHOR="Fangorn"
GAME_VMS="32"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/morrowind/top.jpg" "http://files.playonlinux.com/resources/setups/morrowind/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2689
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 

POL_Call POL_GoG_setup "$GOGID" "3a027504a0e4599f8c6b5b5bcc87a5c6" # MD5 hash of installer v.2.0.0.7

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
   
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate
 
POL_Call POL_GoG_install

# GoG work!
Set_OS winxp
   
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
   
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
   
# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Morrowind Launcher.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Morrowind/manual.pdf" 
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhO62wAKCRDlMfrJqhPK
Ryj2AJ9iznNjkdrVhAJfiSaxpi+ogltYNgCdHTKz3oPi4EV7MPolVGsi5Mwx7Qc=
=DxT1
-----END PGP SIGNATURE-----
