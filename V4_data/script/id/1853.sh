#!/bin/bash
# Date : (2013-10-01 ??-??)
# Last revision : (2013-10-09 19-14)
# Wine version used : 1.6
# Distribution used to test : Ubuntu-Gnome 13.04
# Author : Massawi33

# CHANGELOG
# [Massawi33] (2013-10-01)
#   First script.
# [Dadu042] (2019-10-28)
#   Wine 1.6 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Payday 2"
PREFIX="Payday2"
STEAM_ID="218620"
WORKING_WINE_VERSION="2.22"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Crimenet" "http://www.crimenet.info/" "Massawi33" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "LOCAL,STEAM"

if [ "$INSTALL_METHOD" = "STEAM" ]; then

POL_Call POL_Install_steam
POL_Call POL_Install_steam_flags "$STEAM_ID"
POL_Shortcut "steam.exe" "$TITLE" "steam://rungameid/$STEAM_ID"
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue.')" "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "Steam.exe" "steam://install/$STEAM_ID"
POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" = "LOCAL" ]; then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_SetupWindow_message "$(eval_gettext 'Please do not run $TITLE after installation has finished.')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
fi

POL_Wine_SetVideoDriver
POL_SetupWindow_VMS "256"

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
POL_Shortcut "payday2_win32_release.exe" "$TITLE"
fi

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbnKigAKCRDlMfrJqhPK
R9CnAJwJaYbuugdsfu0Y6pJXXp4v4TwJ5QCeOZtVHIb5G5gGyFPC717h1hwumCc=
=e1Cm
-----END PGP SIGNATURE-----
