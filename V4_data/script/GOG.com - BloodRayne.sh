#!/bin/bash
# Date : (2012-03-12 23-44)
# Last revision : see hcnagelog
# Wine version used : 1.5.10, 1.5.15
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-03-12 23-44)
#   Initial script, for the GOG release.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.5.15 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="bloodrayne"
PREFIX="BloodRayne1_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - BloodRayne"
SHORTCUT_NAME="BloodRayne"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1364

# 4.0.15 needed for complex POL_Shortcut_InsertBeforeWine
POL_RequiredVersion "4.0.15" || POL_Debug_Fatal "$APPLICATION_TITLE 4.0.15 is required to install $TITLE"

POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Terminal Reality / Majesco" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "a0004009663cad8eefafc5964b3f1c4b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cd "$POL_USER_ROOT/tmp"
POL_Download "http://files.playonlinux.com/nircmd.zip" "3d6d3f094633c5c97f8b15f8fe1023bf"
POL_System_ExtractSingleFile "nircmd.zip" "nircmd.exe" "$WINEPREFIX/drive_c/windows/nircmd.exe"

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

POL_Wine_X11Drv "GrabFullScreen" "Y"

POL_Wine_OverrideDLL "" winegstreamer
POL_Call POL_Install_devenum
POL_Call POL_Install_quartz

# Doesn't hurt ;)
#POL_Wine_reboot
POL_Wine wineboot -u

POL_Shortcut "rayne.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
# double quotes around "P"OL_Wine prevent POL getArgs to pickup this line, sorry for the hack
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'passvideo () {'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" '  POL_Debug_Message "waiting for video to start"'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" '  while ! pidof "video\\cutscene.exe"; do sleep 1; done'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" '  POL_Debug_Message "waiting for video to end"'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" '  "P"OL_Wine nircmd.exe waitprocess cutscene.exe'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" '}'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" '(passvideo; passvideo; "P"OL_Wine nircmd.exe win hideshow title BloodRayne; POL_Debug_Message "done with repaint")&'
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/BloodRayne/manual.pdf"
# C:\GOG Games\BloodRayne\readme.txt

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwjlgAKCRDlMfrJqhPK
R2fYAJ9sDrJUZhT0FACZNGxy4AyKw1R0mQCfS6K6meTvokKrbqtFQaI37NyD4pM=
=djI0
-----END PGP SIGNATURE-----
