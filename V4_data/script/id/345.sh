#!/bin/bash
# Date : (2010-08-31 13-00)
# Last revision : (2012-04-11 21:00)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TWEE="0"
TITLE="The Witcher : Enhanced Edition"
PREFIX="thewitcher"
AUTHOR="GNU_Raziel"
PVERSION="1.5"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/witcher/top.jpg" "http://files.playonlinux.com/resources/setups/witcher/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION installer for $TITLE')"

# Checking Enhanced Edition file
if [ -e "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/ENHANCED_EDITION" ]; then
	POL_SetupWindow_message "$(eval_gettext 'This game already have Enhanced Edition\nand only need patch 1.5')" "$TITLE"
	TWEE="1"
fi

# Checking if game is installed
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

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
	POL_SetupWindow_Close
	exit 0
fi

# Using specific Wine
if [ "$TWEE" == "1" ]; then
	# Asking about patch local or not
	cd "$HOME"
	POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
	if [ "$INSTALL_METHOD" == "LOCAL" ]; then
		POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
		POL_Wine start /unix "$APP_ANSWER"
		POL_Wine_WaitExit "$TITLE"
	else
		cd "$POL_USER_ROOT/tmp"
		POL_SetupWindow_download "$(eval_gettext 'Wait while the patch is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "http://cdn.gazeta.pl/bi.gazeta.pl/pub/gry/TheWitcherPatch.1.5.exe"
		POL_Wine start /unix "TheWitcherPatch.1.5.exe"
		POL_Wine_WaitExit "$TITLE"
		rm "TheWitcherPatch.1.5.exe"
	fi
else
	# Asking about patch local or not
	cd "$HOME"
	POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
	if [ "$INSTALL_METHOD" == "LOCAL" ]; then
		POL_SetupWindow_browse "$(eval_gettext 'Select first patch (EE Upgrade) to execute')" "$TITLE" ""
		POL_Wine start /unix "$APP_ANSWER"
		POL_Wine_WaitExit "$TITLE"
		POL_SetupWindow_browse "$(eval_gettext 'Select second patch (1.5) to execute')" "$TITLE" ""
		POL_Wine start /unix "$APP_ANSWER"
		POL_Wine_WaitExit "$TITLE"
	else
		cd "$POL_USER_ROOT/tmp"
		if [ "$POL_LANG" == "fr" ]; then
			PATCH_URL="http://cdn.sciagnij.pl/bi.sciagnij.pl/0/1/TWEE_French_language_pack.exe"
		elif [ "$POL_LANG" == "de" ]; then
			PATCH_URL="http://cdn.sciagnij.pl/bi.sciagnij.pl/0/5/TWEE_German_language_pack.exe"
		elif [ "$POL_LANG" == "es" ]; then
			PATCH_URL="http://cdn.sciagnij.pl/bi.sciagnij.pl/0/9/TWEE_Spanish_language_pack.exe"
		elif [ "$POL_LANG" == "it" ]; then
			PATCH_URL="http://cdn.sciagnij.pl/bi.sciagnij.pl/0/9/TWEE_Italian_language_pack.exe"
		elif [ "$POL_LANG" == "ru" ]; then
			PATCH_URL="http://cdn.sciagnij.pl/bi.sciagnij.pl/0/4/TWEE_Russian_language_pack.exe"
		elif [ "$POL_LANG" == "pl" ]; then
			PATCH_URL="http://cdn.sciagnij.pl/bi.sciagnij.pl/0/6/TWEE_Polish_language_pack.exe"
		elif [ "$POL_LANG" == "hu" ]; then
			PATCH_URL="http://cdn.sciagnij.pl/bi.sciagnij.pl/0/8/TWEE_Hungarian_language_pack.exe"
		elif [ "$POL_LANG" == "cs" ]; then
			PATCH_URL="http://cdn.sciagnij.pl/bi.sciagnij.pl/0/6/TWEE_Czech_language_pack.exe"
		else
			PATCH_URL="http://cdn.sciagnij.pl/bi.sciagnij.pl/0/7/TWEE_English_language_pack.exe"
		fi
		POL_SetupWindow_download "$(eval_gettext 'Wait while the patch is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "http://cdn.gazeta.pl/bi.gazeta.pl/pub/gry/TheWitcherPatch.1.5.exe"
		POL_SetupWindow_download "$(eval_gettext 'Wait while the patch 1 is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "http://cdn.sciagnij.pl/bi.sciagnij.pl/0/4/TWEE_Upgrade.exe"
		POL_SetupWindow_download "$(eval_gettext 'Wait while the patch 2 is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "http://cdn.sciagnij.pl/bi.sciagnij.pl/0/9/TWEE_adventure_Side_Effects.exe"
		POL_SetupWindow_download "$(eval_gettext 'Wait while the patch 3 is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "http://cdn.sciagnij.pl/bi.sciagnij.pl/0/0/TWEE_adventure_The_Price_of_Neutrality.exe"
		POL_SetupWindow_download "$(eval_gettext 'Wait while the patch 4 is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "$PATCH_URL"
		POL_SetupWindow_message "$(eval_gettext 'Donwload finished.\nPatches installation will begin')" "$TITLE"
		POL_Wine start /unix "TWEE_Upgrade.exe"
		POL_Wine_WaitExit "$TITLE"
		POL_Wine start /unix "TheWitcherPatch.1.5.exe"
		POL_Wine_WaitExit "$TITLE"
		rm "TWEE_*.exe"
		rm "TheWitcherPatch.1.5.exe"
	fi
fi 

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+Fuo8ACgkQ5TH6yaoTykcN0wCgsRarzZtoZbBPvDu/VG7CYwGA
HBoAmgOwigN4/52/AX8L1JB09SQ+LePJ
=4DU3
-----END PGP SIGNATURE-----
