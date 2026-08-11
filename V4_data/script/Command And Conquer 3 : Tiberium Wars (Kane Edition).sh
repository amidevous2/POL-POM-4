#!/bin/bash
# Date : (2008-09-07 19-00)
# Last revision : (2013-06-20 21:00)
# Wine version used : 1.2, 1.3.15, 1.3.25, 1.3.26, 1.3.27, 1.4.1
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Command And Conquer 3 : Tiberium Wars (Kane Edition)"
SHORTCUT_NAME="Command And Conquer 3 : Tiberium Wars (Kane Edition)"
PREFIX="CommandAndConquer3-KaneEdition"
WORKING_WINE_VERSION="1.4.1"
GAME_VMS="64"
STEAM_ID="24790"

if [ "$POL_LANG" == "fr" ]; then
	TITLE="Command And Conquer 3 : Les Guerres du Tibérium (Kane Edition)"
	SHORTCUT_NAME="Command And Conquer 3 : Les Guerres du Tibérium (Kane Edition)"
fi

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/cnc3/top.jpg" "http://files.playonlinux.com/resources/setups/cnc3/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 51

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Electronic Arts" "http://www.ea.com/cc/tiberium/" "GNU_Raziel" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam

	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"

	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "cnc3.png" "steam://rungameid/$STEAM_ID" "Game;StrategyGame;"
	POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" "" "Game;"
fi
POL_Call POL_Install_gdiplus
POL_Call POL_Install_d3dx9

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
cat << EOF > "$POL_USER_ROOT/tmp/net_hack.reg"
[HKEY_CURRENT_USER\\Software\\Wine\\Network]
"UseBindAddressHack"="enabled"
EOF
regedit "$POL_USER_ROOT/tmp/net_hack.reg"

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
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	POL_Wine start /unix "$CDROM/autorun.exe"
	POL_Wine_WaitExit "$TITLE"
	# Language Fix for DVD install
	if [ "$GAME_LNG" == "fr" ]; then
		POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while language pack is configured...')" "$TITLE"
		cd "$POL_USER_ROOT/tmp/"
		cabextract "$CDROM/Langfr~1.cab"
		cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Command & Conquer 3/"
		mv "$POL_USER_ROOT/tmp/cnc3_french_1.0.skudef" "CNC3_french_1.0.SkuDef"
		mkdir -p "Lang-french/1.0"
		echo "add-big French.big" > "Lang-french/1.0/config.txt"
		cp "$POL_USER_ROOT/tmp/french.big" "Lang-french/1.0/French.big"
		echo "add-big ../Lang-french/1.0/French.big" >> "RetailExe/1.0/config.txt"
cat << EOF > "$POL_USER_ROOT/tmp/french.reg"
[HKEY_CURRENT_USER\\Software\\Electronic Arts\\Electronic Arts\\Command and Conquer 3]
"Language"="french"
EOF
regedit "$POL_USER_ROOT/tmp/french.reg"
	fi
	if [ "$GAME_LNG" == "de" ]; then
		POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while language pack is configured...')" "$TITLE"
		cd "$POL_USER_ROOT/tmp/"
		cabextract "$CDROM/Langge~1.cab"
		cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Command & Conquer 3/"
		mv "$POL_USER_ROOT/tmp/cnc3_german_1.0.skudef" "CNC3_german_1.0.SkuDef"
		mkdir -p "Lang-german/1.0"
		echo "add-big German.big" > "Lang-german/1.0/config.txt"
		cp "$POL_USER_ROOT/tmp/german.big" "Lang-german/1.0/German.big"
		echo "add-big ../Lang-german/1.0/German.big" >> "RetailExe/1.0/config.txt"
cat << EOF > "$POL_USER_ROOT/tmp/german.reg"
[HKEY_CURRENT_USER\\Software\\Electronic Arts\\Electronic Arts\\Command and Conquer 3]
"Language"="german"
EOF
regedit "$POL_USER_ROOT/tmp/german.reg"
	fi
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installation in progress...')" "$TITLE"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "CNC3.exe" "$SHORTCUT_NAME" "cnc3.png" "" "Game;StrategyGame;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDieEACgkQ5TH6yaoTykd5JACeLYVyf2bUA2TR8YoUWsPmV5oc
TmcAnjKmTFhFzjgLkKrlUIx5ERlnwCrT
=Mqrj
-----END PGP SIGNATURE-----
