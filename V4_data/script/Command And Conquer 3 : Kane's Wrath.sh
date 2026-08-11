#!/bin/bash
# Date : (2008-09-07 23-00)
# Last revision : (2013-06-20 21:00)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Command And Conquer 3 : Kane's Wrath"
SHORTCUT_NAME="Command And Conquer 3 : Kane's Wrath"
PREFIX="CommandAndConquer3-KaneEdition"
STEAM_ID="24810"

if [ "$POL_LANG" == "fr" ]; then
	TITLE="Command And Conquer 3 : La Fureur de Kane"
	SHORTCUT_NAME="Command And Conquer 3 : La Fureur de Kane"
fi

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/cnc3_addon/top.jpg" "http://files.playonlinux.com/resources/setups/cnc3_addon/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 667

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Electronic Arts" "http://www.ea.com/cc/tiberium/" "GNU_Raziel" "$PREFIX"

# Check if the main game is installed
POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Game is not installed.')" "$TITLE"
		POL_SetupWindow_Close
		exit 0
	fi
}

POL_SetupWindow_checkexist "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

if [ "$INSTALL_METHOD" == "STEAM" ]; then
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"

	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "cnc3ep1.png" "steam://rungameid/$STEAM_ID" "Game;StrategyGame;"
	POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" "" "Game;"
fi

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Choose Game language
	POL_SetupWindow_menu "$(eval_gettext 'Choose the game language you want')" "$TITLE" "$(evalgettext 'French')~$(evalgettext 'German')~$(evalgettext 'English')" "~"
	if [ "$APP_ANSWER" == "$(evalgettext 'French')" ]; then
		GAME_LNG="fr"
	elif [ "$APP_ANSWER" == "$(evalgettext 'German')" ]; then
		GAME_LNG="de"
	else
		GAME_LNG="en"
	fi
	# Checking cdrom
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "cnc3nod.ico"
	POL_Wine start /unix "$CDROM/autorun.exe"
	POL_Wine_WaitExit "$TITLE"
	# Language Fix for DVD install
	if [ "$GAME_LNG" == "fr" ]; then
		POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while language pack is configured...')" "$TITLE"
		cd "$POL_USER_ROOT/tmp/"
		cabextract "$CDROM/Langfr~1.cab"
		cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Command & Conquer 3 Kane's Wrath/"
		mv "$POL_USER_ROOT/tmp/cnc3ep1_french_1.0.skudef" "CNC3EP1_french_1.0.SkuDef"
		mkdir -p "Lang-french/1.0"
		echo "add-big French.big" > "Lang-french/1.0/config.txt"
		cp "$POL_USER_ROOT/tmp/french.big" "Lang-french/1.0/French.big"
		echo "add-big ../Lang-french/1.0/French.big" >> "RetailExe/1.0/config.txt"
cat << EOF > "$POL_USER_ROOT/tmp/french.reg"
[HKEY_CURRENT_USER\\Software\\Electronic Arts\\Electronic Arts\\Command and Conquer 3 Kanes Wrath]
"Language"="french"
EOF
regedit "$POL_USER_ROOT/tmp/french.reg"
	fi
	if [ "$GAME_LNG" == "de" ]; then
		POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while language pack is configured...')" "$TITLE"
		cd "$POL_USER_ROOT/tmp/"
		cabextract "$CDROM/Langge~1.cab"
		cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Command & Conquer 3 Kane's Wrath/"
		mv "$POL_USER_ROOT/tmp/cnc3ep1_german_1.0.skudef" "CNC3EP1_german_1.0.SkuDef"
		mkdir -p "Lang-german/1.0"
		echo "add-big German.big" > "Lang-german/1.0/config.txt"
		cp "$POL_USER_ROOT/tmp/german.big" "Lang-french/1.0/German.big"
		echo "add-big ../Lang-german/1.0/German.big" >> "RetailExe/1.0/config.txt"
cat << EOF > "$POL_USER_ROOT/tmp/german.reg"
[HKEY_CURRENT_USER\\Software\\Electronic Arts\\Electronic Arts\\Command and Conquer 3 Kanes Wrath]
"Language"="german"
EOF
regedit "$POL_USER_ROOT/tmp/german.reg"
	fi
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/24810
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "CNC3EP1.exe" "$TITLE" "cnc3ep1.png" "" "Game;StrategyGame;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDifgACgkQ5TH6yaoTykeDkACghEbrw+9SETH2dnlN4l/WSH7g
KqAAniuFg9Hc/0/L94l5E1pjsqBv8LbB
=4Dwh
-----END PGP SIGNATURE-----
