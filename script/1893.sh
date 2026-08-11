#!/bin/bash
# Date : (2013-03-01)
# Last revision : (2014-09-08)
# Wine version used : 1.7.26
# Distribution used to test : Mac OS X 10.10
# Author : Marking

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Setup some needed variables
TITLE="Sono Hanabira ni Kuchizuke wo 09 - Amakute Otona no Torokeru Chuu"
PREFIX="SonoHana_09"
WINEVERSION="1.7.26"
EDITOR="Fuguriya"
GAME_URL="http://fuguriya.sakura.ne.jp"
AUTHOR="Marking"
SHORTCUT_NAME="??????????? 09 ???????????????"

INSTALL_JP='??????'
END_JP='??'
YES_JP='??'

# Download images for installation script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

# Initialize the script, debugging, and set required version
POL_SetupWindow_Init
POL_SetupWindow_SetID 1893
POL_RequiredVersion "4.1.6" || POL_Debug_Fatal "$APPLICATION_TITLE 4.1.6 is required to install $TITLE"
POL_Debug_Init
 
# Setup presentation window
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Begin setting up the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
SONOHANA="$WINEPREFIX/drive_c/$PROGRAMFILES/????/???????????????????????????/"

# Ask user for either DVD or Local installation
POL_SetupWindow_InstallMethod "LOCAL,DVD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
	# Ask user to find "Setup.exe"
    cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please locate installation program (Setup.exe)')" "$TITLE"
	# Tell user what to do while the installation program is running
    POL_SetupWindow_message "$(eval_gettext 'When the install program starts, click on ${INSTALL_JP}. When a new window opens, click on ${INSTALL_JP}. When installation finishes, click on ${END_JP} and then on ${YES_JP} (Y). Click Next to begin installation.')" "Installation instructions"	
	LANG="ja_JP.UTF-8" POL_Wine "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DVD" ]
then
	# Launches the installation program from CD/DVD
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom
	# Tell user what to do while the installation program is running
    POL_SetupWindow_message "$(eval_gettext 'When the install program starts, click on ${INSTALL_JP}. When a new window opens, click on ${INSTALL_JP}. When installation finishes, click on ${END_JP} and then on ${YES_JP} (Y). Click Next to begin installation.')" "Installation instructions"	
	LANG="ja_JP.UTF-8" POL_Wine "$CDROM/Setup.exe"
fi

# Tells users which language they want to use
POL_SetupWindow_menu "Which language would you like to read this in?" "Select Language" "??? (Japanese)|English" "|"

#For Japanese language
if [ "$APP_ANSWER" = "??? (Japanese)" ]
then
	# Apply fjfix to fix the visual novel
	FJFIX_PATCH="fjfix.zip"
	cd "$SONOHANA"
	POL_Download "http://files.markinglifestyle.com/sh_files/fjfix.zip" "789634f517003c1619eca669a83306a0"
	POL_System_unzip $FJFIX_PATCH
	POL_Wine_WaitBefore "the fjfix patch"
	POL_Wine "fjfix.exe" -f MGD
	
# Create a shortcut for easy access
POL_Shortcut "HANA9.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png"
# Insert a command to run as a Japanese application
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" "LANG=ja_JP.UTF-8"

#For English language	
elif [ "$APP_ANSWER" = "English" ]
then
	# Apply the English patch
	POL_SetupWindow_browse "$(eval_gettext 'Please locate English translation patch file')" "$TITLE"
	cp "$APP_ANSWER" "$SONOHANA/SH_EN.EXE"
	cd "$SONOHANA"
	POL_Wine_WaitBefore "the English patch"
	POL_Wine "SH_EN.EXE"

	# Apply fjfix to fix the visual novel
	FJFIX_PATCH="fjfix.zip"
	cd "$SONOHANA"
	POL_Download "http://files.markinglifestyle.com/sh_files/fjfix.zip" "789634f517003c1619eca669a83306a0"
	POL_System_unzip $FJFIX_PATCH
	POL_Wine_WaitBefore "the fjfix patch"
	POL_Wine "fjfix.exe" -f MGD
	
	# Create a shortcut for easy access
	POL_Shortcut "HANA9.EXE" "A Kiss for the Petals 09 - Sweet Grown-up Kisses" "$SHORTCUT_NAME.png"
	# Insert a command to run as a Japanese application/fix font issues
	POL_Shortcut_InsertBeforeWine "A Kiss for the Petals 09 - Sweet Grown-up Kisses" "LANG=ja_JP.UTF-8"
fi
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEUEABECAAYFAlQTRoIACgkQ5TH6yaoTykeAQQCXSyXWnuNpUkwQBsI+frfSgtbK
YwCdG7v5Mu1MWp/W9dvoZXeJnrbVdwI=
=iaZR
-----END PGP SIGNATURE-----
