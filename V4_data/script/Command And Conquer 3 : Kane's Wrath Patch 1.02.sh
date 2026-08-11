#!/bin/bash
# Date : (2008-09-07 19-00)
# Last revision : (2013-06-20 21:00)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Command And Conquer 3 - Tiberium Wars - Kane's Wrath"
PREFIX="CommandAndConquer3-KaneEdition"
PVERSION="1.02"

if [ "$POL_LANG" == "fr" ]; then
	TITLE="Command And Conquer 3 : La Fureur de Kane"
fi

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/cnc3_addon/top.jpg" "http://files.playonlinux.com/resources/setups/cnc3_addon/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 668

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION Installer for $TITLE')"

# Check if the game is installed
POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Game is not installed.')" "$TITLE"
		POL_SetupWindow_Close
		exit
	fi
}

POL_SetupWindow_checkexist "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
	POL_SetupWindow_Close
	exit
fi

# Choose Game language
POL_SetupWindow_menu "$(eval_gettext 'Choose the game language you want')" "$TITLE" "$(evalgettext 'French')~$(evalgettext 'German')~$(evalgettext 'English')" "~"
if [ "$APP_ANSWER" == "$(evalgettext 'French')" ]; then
	GAME_LNG="fr"
elif [ "$APP_ANSWER" == "$(evalgettext 'German')" ]; then
	GAME_LNG="de"
else
	GAME_LNG="en"
fi

# Asking about patch local or not
cd "$HOME"
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
	POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
	POL_Wine start /unix "$APP_ANSWER"
	POL_Wine_WaitExit
else
	cd "$POL_USER_ROOT/tmp"
	if [ "$GAME_LNG" == "fr" ]; then
		PATCH_URL="http://na.llnet.cnc3tv.ea.com/u/f/eagames/cnc3/cnc3tv/Tiberium/KWPatch_102/KanesWrath_french_patch1.02.exe"
		PATCH_EXE="KanesWrath_french_patch1.02.exe"
	elif [ "$GAME_LNG" == "de" ]; then
		PATCH_URL="http://na.llnet.cnc3tv.ea.com/u/f/eagames/cnc3/cnc3tv/Tiberium/KWPatch_102/KanesWrath_german_patch1.02.exe"
		PATCH_EXE="KanesWrath_german_patch1.02.exe"
	else
		PATCH_URL="http://na.llnet.cnc3tv.ea.com/u/f/eagames/cnc3/cnc3tv/Tiberium/KWPatch_102/KanesWrath_english_patch1.02.exe"
		PATCH_EXE="KanesWrath_english_patch1.02.exe"
	fi
	POL_SetupWindow_download "$(eval_gettext 'Wait while the patch is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "$PATCH_URL"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installation in progress...')" "$TITLE"
	POL_Wine start /unix "$PATCH_EXE"
	POL_Wine_WaitExit
	rm "$PATCH_EXE"
fi

if [ "$GAME_LNG" == "fr" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Command & Conquer 3 Kane's Wrath/"
	echo "add-big ../Lang-french/1.1/patch1.big" >> "RetailExe/1.1/config.txt"
	echo "add-big ../Lang-french/1.2/patch2.big" >> "RetailExe/1.2/config.txt"
elif [ "$GAME_LNG" == "de" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Command & Conquer 3 Kane's Wrath/"
	echo "add-big ../Lang-german/1.1/patch1.big" >> "RetailExe/1.1/config.txt"
	echo "add-big ../Lang-german/1.2/patch2.big" >> "RetailExe/1.2/config.txt"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDeYQACgkQ5TH6yaoTykdnZQCfdnMt2sNMbXS8wUtHfVeYOMWi
n/AAniNE1AuaHwAGuqWMiUXBdXliKi1a
=Mwah
-----END PGP SIGNATURE-----
