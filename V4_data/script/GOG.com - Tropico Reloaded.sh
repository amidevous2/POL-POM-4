#!/bin/bash
# Date : (2013-08-22 23-00)
# Last revision : 
# Wine version used :
# Distribution used to test : Fedora 19
# Author : TonyFlow
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [TonyFlow] (2013-08-22 23-00)
#   Initial script.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="tropico_reloaded"
PREFIX="TropicoReloaded_gog"
WORKING_WINE_VERSION="3.0.3"
 
TITLE="GOG.com - Tropico Reloaded"
SHORTCUT_NAME_1="Tropico 1: Paradise Island"
SHORTCUT_NAME_2="Tropico 2: Pirate Cove"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1806
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Kalypso / PopTop" "http://www.gog.com/gamecard/$GOGID" "TonyFlow" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "df2913ef618fd5449cd8e580ee6b7fb0"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install
 
# GoG work!
Set_OS winxp
 
POL_SetupWindow_VMS "16"
 
 
# The game (Tropico 1) require a cdrom drive
ln -sf / "$WINEPREFIX/dosdevices/p:"
cat <<_EOFINI_ > "$POL_USER_ROOT/tmp/cdrom.reg"
REGEDIT4
 
[HKEY_LOCAL_MACHINE\Software\Wine\Drives]
"P:"="cdrom"
_EOFINI_
# Define the cdrom drive into the registry
POL_Wine regedit.exe "$POL_USER_ROOT/tmp/cdrom.reg"
rm "$POL_USER_ROOT/tmp/cdrom.reg"
 
 
# Doesn't hurt ;)
POL_Wine_reboot
 
# Configure the shortcut
GOGPATH="$GOGROOT/Tropico Reloaded"
POL_Shortcut "Tropico.EXE" "$SHORTCUT_NAME_1" "$SHORTCUT_NAME_1.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME_1" "$GOGPATH/Tropico 1/Manual.pdf"
POL_Shortcut "Tropico2.exe" "$SHORTCUT_NAME_2" "$SHORTCUT_NAME_2.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME_2" "$GOGPATH/Tropico 2/Manual.pdf"
 
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxICAAKCRDlMfrJqhPK
R2AnAJ9eRRu0JTixkAbgO7abXWWnvOYu9gCglgp9XaaniMZzJcUILwLu3+RRtxI=
=fFNw
-----END PGP SIGNATURE-----
