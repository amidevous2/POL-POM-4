#!/bin/bash
# Date : (2013-05-19 20-47)
# Last revision : (2013-06-29 14-42)
# Wine version used : 1.4.1, 1.5.30
# Distribution used to test : Xubuntu 13.04
# Author : Pascal Reinhard dev@ovocean.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="fez"
PREFIX="Fez_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Fez"
SHORTCUT_NAME="Fez"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1697
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Polytron Corporation" "http://www.gog.com/gamecard/$GOGID" "Xodetaetl" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" "1" "8bdf6d75eee8cf930b9c41e43d984314"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_mono210
POL_Call POL_GoG_install

# Change the game's config to windowed 
# (the initial launch in full screen is buggy)
mkdir -p "$WINEPREFIX/drive_c/users/$USER/Application Data/FEZ/"
if type -t POL_unbase64 > /dev/null; then
	POL_unbase64 <<-'_EOF_' > "$WINEPREFIX/drive_c/users/$USER/Application Data/FEZ/Settings"
c2V0dGluZ3MgdHlwZT0iRmV6RW5naW5lLlRvb2xzLlNldHRpbmdzLCBGZXpFbmdpbmUiIHsNCgl1
c2VDdXJyZW50TW9kZSBmYWxzZQ0KCXNjcmVlbk1vZGUgIldpbmRvd2VkIg0KCXdpZHRoIDEyODAN
CgloZWlnaHQgNzIwDQoJbGFuZ3VhZ2UgIkVuZ2xpc2giDQoJc291bmRWb2x1bWUgMUYNCgltdXNp
Y1ZvbHVtZSAxRg0KCWtleWJvYXJkTWFwcGluZyBKdW1wPSJTcGFjZSIgR3JhYlRocm93PSJMZWZ0
Q29udHJvbCIgQ2FuY2VsVGFsaz0iTGVmdFNoaWZ0IiBVcD0iVXAiIERvd249IkRvd24iIExlZnQ9
IkxlZnQiIFJpZ2h0PSJSaWdodCIgTG9va1VwPSJJIiBMb29rRG93bj0iSyIgTG9va1JpZ2h0PSJM
IiBMb29rTGVmdD0iSiIgT3Blbk1hcD0iRXNjYXBlIiBPcGVuSW52ZW50b3J5PSJUYWIiIE1hcFpv
b21Jbj0iVyIgTWFwWm9vbU91dD0iUyIgUGF1c2U9IkVudGVyIiBSb3RhdGVMZWZ0PSJBIiBSb3Rh
dGVSaWdodD0iRCIgRnBWaWV3VG9nZ2xlPSJSaWdodEFsdCIgQ2xhbXBMb29rPSJSaWdodFNoaWZ0
Ig0KCWdhbWVwYWRNYXBwaW5nIEp1bXA9MSBHcmFiVGhyb3c9MCBDYW5jZWxUYWxrPTIgT3Blbk1h
cD04IE9wZW5JbnZlbnRvcnk9MyBNYXBab29tSW49NSBNYXBab29tT3V0PTQgUGF1c2U9OSBSb3Rh
dGVMZWZ0PTYgUm90YXRlUmlnaHQ9NyBGcFZpZXdUb2dnbGU9MTAgQ2xhbXBMb29rPTExDQp9
_EOF_
fi

POL_Shortcut "FEZ.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ArcadeGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHO19sACgkQ5TH6yaoTykdTJgCcDWNRFQaPrzyuqRwn8D6bxwex
X5sAnRGO2aoCoJLZiJy2ocYlaT3Syl5V
=fq0N
-----END PGP SIGNATURE-----
