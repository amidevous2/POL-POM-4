#!/bin/bash
# Date : (2013-07-19 10-31)
# Last revision : 
# Wine version used : 
# Distribution used to test : Debian 7.0 Wheezy
# Author : Filippov Daniil filippovdaniil AT gmail.com
#
# CHANGELOG
# [Filippov Daniil] (2013-07-19 10-31)
#   Initial script.
# [Dadu042] (2020-01-27 13:00)
#   Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
STEAM_ID="224760"
PREFIX="FEZ_steam"
WORKING_WINE_VERSION="2.22"
 
TITLE="FEZ (Steam)"
SHORTCUT_NAME="FEZ"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups/$PREFIX/left.png" "$TITLE"
 
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Polytron Corporation" "http://store.steampowered.com/app/224760" "Filippov Daniil" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_Install_mono210
 
# Choose between Steam and Digital Download versions of the game:
POL_SetupWindow_InstallMethod "STEAM,LOCAL"
 
 
if [ "$INSTALL_METHOD" == "STEAM" ]; then
    # Install Steam:
    POL_Call POL_Install_steam
    # Mandatory pre-install fix for steam:
    POL_Call POL_Install_steam_flags "$STEAM_ID"
    # Shortcut done before install for steam version:
    POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
    POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" ""
    # Steam game install:
    POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
    POL_Wine_WaitExit "$TITLE"
else
    # Asking then installing DDV of the game:
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
    POL_Wine start /unix "$SETUP_EXE"
    POL_Wine_WaitExit "$TITLE"
 
    # Making shortcut:
    POL_Shortcut "FEZ.exe" "$SHORTCUT_NAME" "$TITLE.png" "" "Game;"
fi
 
# Change the game's config to windowed (the initial launch in full screen is buggy):
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
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjIIlgAKCRDlMfrJqhPK
R1MpAJ9qvGCvdplDWXZ157UpiWlHpYCcygCfV4eafUCqTP/TF6I1RjAeMZpW1eg=
=yN6X
-----END PGP SIGNATURE-----
