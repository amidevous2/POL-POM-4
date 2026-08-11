#!/bin/bash
# Date : (2014-09-23 15:00)
# Last revision : (2015-01-07 15:33)
# Wine version used : 1.7.27
# Distribution used to test : XUbuntu 14.04 - OSX 10.10
# Author : Quentin Delrée

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dinosaur' Echecs"
PREFIX="dinosaurechecs"
APP_AUTHOR="Universis Technology Ltd"
APP_URL="http://www.dinosaurchess.com/website/default.shtml"
APP_SETUP_FILE="setup.exe"
APP_WINE_VER="1.7.27"
APP_SHORTCUT_NAME="Dinosaur' Echecs"
APP_SHORTUCT_FILE="Dinosaur’ Echecs.exe"


# Variables du script
setup_file=""


POL_SetupWindow_Init
POL_Debug_Init

# Informations
POL_SetupWindow_presentation "$TITLE" "$APP_AUTHOR" "$APP_URL" "Quentin Delrée" "$PREFIX"
POL_SetupWindow_InstallMethod "LOCAL,CD"
if [ $INSTALL_METHOD = "LOCAL" ]; then
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	setup_file="$APP_ANSWER"
else
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "$APP_SETUP_FILE"
	setup_file="$CDROM/$APP_SETUP_FILE"
fi

# Installation
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$APP_WINE_VER"
Set_OS "winxp" "sp3"
#POL_Call POL_Install_Flashplayer_ActiveX     Doesn't work... Replace by this :
	POL_System_TmpCreate "$PREFIX"
	cd "$POL_System_TmpDir"
	POL_Download "http://fpdownload.macromedia.com/get/flashplayer/pdc/16.0.0.235/install_flash_player_ax.exe" "caec7ccc58390c704f895819b177f87e"
	POL_Wine start /unix "$POL_System_TmpDir/install_flash_player_ax.exe -install"
	POL_Wine_WaitExit "$ITLE"
	POL_System_TmpDelete
POL_Wine start /unix "$setup_file"
POL_Wine_WaitExit "$ITLE"
POL_Shortcut "$APP_SHORTUCT_FILE" "$APP_SHORTCUT_NAME"
POL_SetupWindow_message "Your application has been installed successfully." "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlSvhncACgkQ5TH6yaoTykddzACfZup7iJ0SSjlRssqZM/Wrl16b
up0AnR0Io2THgyGGRfoQTMjyGSnib8d9
=7T8W
-----END PGP SIGNATURE-----
