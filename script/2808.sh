#!/bin/bash
# Date : 2016-05-02
# Last revision : see changelog
# Wine version used: 3.0.3
# Distribution used to test : Ubuntu 14.04 amd64, OSX Mavericks 10.9.5
# Author: PlayPal

# CHANGELOG
# [mauriciofauth] (2015-05-20)
#   First script.
# [Dadu042] (2019-11-17 19:14)
#   Wine 1.8.1 -> 3.0.3 (according appdb.winehq.org)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Wizard101 Europe"
PREFIX="Wizard101Europe"
EDITOR="Gameforge 4D GmbH | KingsIsle Entertainment, Inc."
GAME_URL="http://www.gameforge.com"
AUTHOR="PlayPal"
POL_ID=2808
WINE_VERSION="3.0.3"

ICON_TOP="http://drsick.net/wizard101/top.png"
ICON_LEFT="http://drsick.net/wizard101/left.png"

POL_GetSetupImages "$ICON_TOP" "$ICON_LEFT" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID $POL_ID
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# choose game language
POL_SetupWindow_menu_list "Please choose your language:\n(you need an account for the specified language)" "$TITLE" "English~German~French~Spanish~Italian~Polish~Greek" "~" "English"
if [ "English" = "$APP_ANSWER" ]; then
  download_file="Wizard101_Installer_UK.exe"
  tld="co.uk"
elif [ "German" = "$APP_ANSWER" ]; then
  download_file="Wizard101_Installer_DE.exe"
  tld="de"
elif [ "French" = "$APP_ANSWER" ]; then
  download_file="Wizard101_Installer_FR.exe"
  tld="fr"
elif [ "Spanish" = "$APP_ANSWER" ]; then
  download_file="Wizard101_Installer_ES.exe"
  tld="es"
elif [ "Italian" = "$APP_ANSWER" ]; then
  download_file="Wizard101_Installer_IT.exe"
  tld="it"
elif [ "Polish" = "$APP_ANSWER" ]; then
  download_file="Wizard101_Installer_PL.exe"
  tld="pl"
elif [ "Greek" = "$APP_ANSWER" ]; then
  download_file="Wizard101_Installer_GR.exe"
  tld="gr"
fi

# open browser to register an account
POL_Browser "http://wizard101.$tld"

POL_Wine_SelectPrefix "$PREFIX"
# will not work with amd64:
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

# download and execute the installer:
cd "$POL_System_TmpDir"
POL_Download "http://dlcl.gfsrv.net/wizard101/clients/$download_file"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$download_file"
POL_System_TmpDelete

# avoid crash messages (after Wizard101 starts launcher):
POL_Shortcut_QuietDebug "$TITLE"
POL_Shortcut "Wizard101.exe" "$TITLE"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXdGN/QAKCRDlMfrJqhPK
RwvvAJ47bzBwvQZXQ84twUBF5uBqQVnmNQCfVdDc66BXnkqUO31rMuYpZlHtOuo=
=60Yp
-----END PGP SIGNATURE-----
