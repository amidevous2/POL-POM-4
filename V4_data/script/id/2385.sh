#!/bin/bash
# Date : (2014-09-24 18-00)
# Last revision : (2014-09-24 18-00)
# Wine version used : 1.7.27
# Distribution used to test : XUbuntu 14.04
# Author : Quentin Delrée

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="iMindMap 6"
PREFIX="imindmap6"
APP_AUTHOR="ThinkBuzan"
APP_URL="http://thinkbuzan.com/"
APP_WINE_VER="1.7.27"
APP_SHORTCUT_NAME="iMindMap 6"
APP_SHORTUCT_FILE="iMindMap 6.exe"


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
	POL_Download "http://www.thinkbuzan.com/jump/imindmap6_windows_full" "53aa60b66af6e8f439be34ff5e3136ef"
	setup_file="$POL_System_TmpDir/imindmap6_windows_full"
fi
POL_Function_FontsSmoothRGB
POL_Wine start /unix "$setup_file"
POL_Wine_WaitExit "$ITLE"
POL_System_TmpDelete
POL_Shortcut "$APP_SHORTUCT_FILE" "$APP_SHORTCUT_NAME"
POL_SetupWindow_message "Your application has been installed successfully." "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlStuG8ACgkQ5TH6yaoTykdD+QCfT9Y6mQa/y2TDouKiiAkRStBu
NKQAoKKtflomFFk9xRTwAfSgEbDJdRpS
=kAX7
-----END PGP SIGNATURE-----
