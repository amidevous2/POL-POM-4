#!/bin/bash
# Date : (2014-09-24 15:00)
# Last revision : (2014-09-24 15:00)
# Wine version used : 1.7.27
# Distribution used to test : XUbuntu 14.04
# Author : Quentin Delrée

# CHANGELOG
# Quentin Delrée (2014-09-24 15:00)
#   First script. Does not pass the 'Now Loading' screen (after main menu).
# [Dadu042] (2022-03-11 12:00)
#   Repair broken URL.
#   Wine 1.7.27 -> 6.0.1

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Fais ton journal 2"
PREFIX="faistonjournal2"
APP_AUTHOR="Milan Presse"
APP_URL="http://www.faistonjournal.com/"
APP_WINE_VER="6.0.1"
APP_SHORTCUT_NAME="Fais ton journal 2"
APP_SHORTUCT_FILE="fais ton journal.exe"


# Variables du script
setup_file=""


POL_SetupWindow_Init
POL_Debug_Init

# Informations
POL_SetupWindow_presentation "$TITLE" "$APP_AUTHOR" "$APP_URL" "Quentin Delrée" "$PREFIX"
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ $INSTALL_METHOD = "LOCAL" ]; then
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	setup_file="$APP_ANSWER"
fi

# Installation
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$APP_WINE_VER"
Set_OS "winxp" "sp3"
POL_System_TmpCreate "$PREFIX"
if [ $INSTALL_METHOD = "DOWNLOAD" ]; then
	cd "$POL_System_TmpDir"
	POL_Download "https://portail-ressources-education-dsden74.web.ac-grenoble.fr/sites/default/files/inline-images/d77sONNWGiPV4GeXyFOZHDY0AIjmNfaEKnHx0GDBoU5K0lqoFb.zip" "76f93a22e08d7f4bded1c04a77f1bbc0"
    mv d77sONNWGiPV4GeXyFOZHDY0AIjmNfaEKnHx0GDBoU5K0lqoFb.zip Fais_ton_journal_2_PC.zip
	unzip Fais_ton_journal_2_PC.zip -d ./
	setup_file="$POL_System_TmpDir/Fais_ton_journal_2_PC.exe"
fi
POL_Wine start /unix "$setup_file"
POL_Wine_WaitExit "$ITLE"
POL_System_TmpDelete
POL_Shortcut "$APP_SHORTUCT_FILE" "$APP_SHORTCUT_NAME"
POL_SetupWindow_message "Your application has been installed successfully." "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYiz+JQAKCRDlMfrJqhPK
R0gOAKCqvU8UIPZgXmi+pNIrtw+y05AJiACfaaCU87w/wz3ZpR4QxmfozV2rEiA=
=JaU+
-----END PGP SIGNATURE-----
