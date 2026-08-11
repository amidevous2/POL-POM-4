#!/bin/bash
# Date : (2010-16-09 20-00)
# Last revision : (2011-18-03 21-00)
# Wine version used : 1.2, 1.2.1, 1.2.3
# Distribution used to test : Debian Squeeze Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Etherlords 2"
PREFIX="Etherlords2"
PVERSION="1.03"
WORKING_WINE_VERSION="1.2.3"

if [ "$POL_LANG" == "fr" ]; then
LNG_GAME_UPDATE_WELCOME="Bienvenue dans le script d'installation du patch $PVERSION pour $TITLE"
LNG_PATCH_METHOD="Choisissez votre méthode de patch"
LNG_HAVE_PATCH="Patcher le jeu depuis un fichier local"
LNG_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_GAME_UPDATE_DL="Patientez pendant le téléchargement du patch...\nCette opération peut prendre quelques minutes selon la vitesse de votre connexion."
LNG_GAME_UPDATE_FINISHED="Le patch a été correctement installé"
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch $PVERSION Installation script for $TITLE"
LNG_PATCH_METHOD="Choose your patch method"
LNG_HAVE_PATCH="Patch from local file"
LNG_DL_PATCH="Download then use last patch"
LNG_LOCAL_PATCH="Select patch to execute"
LNG_GAME_UPDATE_DL="Wait while the patch is downloading...\nThis operation can take time, depending of you connexion."
LNG_GAME_UPDATE_FINISHED="Patch installed successfully"
fi

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/top.jpg" "http://files.playonlinux.com/resources/setups/etherlords2/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages

POL_SetupWindow_free_presentation "$TITLE" "$LNG_GAME_UPDATE_WELCOME"

POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		if [ "$POL_LANG" == "fr" ]; then
			LNG_PREFIX_NOT_EXIST="Le jeu n'est pas installé."
		else
			LNG_PREFIX_NOT_EXIST="Game is not installed."
		fi
		POL_SetupWindow_message "$LNG_PREFIX_NOT_EXIST" "$TITLE"
		POL_SetupWindow_Close
		exit
	fi
}
 
POL_SetupWindow_checkexist "$PREFIX"

select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"

# Using specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
	WORKING_WINE_VERSION="$WORKING_WINE_VERSION-64b"
fi
Use_WineVersion "$WORKING_WINE_VERSION"

# Asking about patch local or not
cd "$HOME"
POL_SetupWindow_menu "$LNG_PATCH_METHOD" "Patch" "$LNG_HAVE_PATCH~$LNG_DL_PATCH" "~"
if [ "$APP_ANSWER" == "$LNG_HAVE_PATCH" ]; then
	POL_SetupWindow_browse "$LNG_LOCAL_PATCH" "$TITLE" ""
	wine start /unix "$APP_ANSWER"
else
	cd "$POL_USER_ROOT/tmp"
	if [ "$POL_LANG" == "fr" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "http://www.dcegames.com/support/patchs/ETH2_PATCH_1.03_FR.exe"
		wine start /unix "ETH2_PATCH_1.03_FR.exe"
		rm "ETH2_PATCH_1.03_FR.exe"
	else
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "http://www.strategyfirst.ca/downloads/patches/etherlords2_patch_103_us.zip"
		unzip etherlords2_patch_103_us.zip
		wine start /unix "EL2_103ENG.EXE"
		rm "EL2_103ENG.EXE"
	fi
fi
 
POL_SetupWindow_message "$LNG_GAME_UPDATE_FINISHED" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4XQCUACgkQ5TH6yaoTyketQgCggpoZrjmsdehB/cIOGKglDzqX
7R8AnRUOEWh+yztTmW7RnRDhdbUKkFrm
=xTFN
-----END PGP SIGNATURE-----
