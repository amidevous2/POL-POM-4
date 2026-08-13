#!/bin/bash
# Date : (2010-23-11 21-00)
# Last revision : (2011-02-08 21-00)
# Wine version used : 1.3.9, 1.3.23
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Grand Theft Auto IV"
PREFIX="GTAIV"
WORKING_WINE_VERSION="1.3.23"

if [ "$POL_LANG" == "fr" ]; then
LNG_GAME_UPDATE_WELCOME="Bienvenue dans l'installeur du patch 7 pour $TITLE"
LNG_STEAM="Steam a son propre système de mise à jour automatique."
LNG_PATCH_METHOD="Choisissez votre méthode de patch"
LNG_HAVE_PATCH="Patcher le jeu depuis un fichier local"
LNG_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_GAME_UPDATE_DL="Patientez pendant le téléchargement du patch...\nCette opération peut prendre quelques minutes selon la vitesse de votre connexion."
LNG_GAME_UPDATE_FINISHED="Le patch a été correctement installé"
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch 7 Installer for $TITLE"
LNG_STEAM="Steam have is own automatic update system."
LNG_PATCH_METHOD="Choose your patch method"
LNG_HAVE_PATCH="Patch from local file"
LNG_DL_PATCH="Download then use last patch"
LNG_LOCAL_PATCH="Select patch to execute"
LNG_GAME_UPDATE_DL="Wait while the patch is downloading...\nThis operation can take time, depending of you connexion."
LNG_GAME_UPDATE_FINISHED="Patch installed successfully"
fi

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_SetupWindow_Init
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
 
select_prefixe "$POL_USER_ROOT/wineprefix/$PREFIX"

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$LNG_STEAM" "$TITLE"
	POL_SetupWindow_Close
	exit
fi

# Using specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
	WORKING_WINE_VERSION="$WORKING_WINE_VERSION-64b"
fi
Use_WineVersion "$WORKING_WINE_VERSION"

# Asking about patch local or not
cd "$HOME"
POL_SetupWindow_menu "$LNG_PATCH_METHOD" "$TITLE" "$LNG_HAVE_PATCH~$LNG_DL_PATCH" "~"
if [ "$APP_ANSWER" == "$LNG_HAVE_PATCH" ]; then
	POL_SetupWindow_browse "$LNG_LOCAL_PATCH" "$TITLE" ""
	wine "$APP_ANSWER"
else
	cd "$POL_USER_ROOT/tmp"
	if [ "$POL_LANG" == "fr" ]; then
		PATCH_URL="http://updates.rockstargames.com/patches/gtaiv/title_update_7_FR.zip"
		PATCH_DIR="title_update_7_FR"
		PATCH_EXE="title_update_7_FR/UpdateTitle.exe"
	elif [ "$POL_LANG" == "de" ]; then
		PATCH_URL="http://updates.rockstargames.com/patches/gtaiv/title_update_7_DE.zip"
		PATCH_DIR="title_update_7_DE"
		PATCH_EXE="title_update_7_DE/UpdateTitle.exe"
	elif [ "$POL_LANG" == "es" ]; then
		PATCH_URL="http://updates.rockstargames.com/patches/gtaiv/title_update_7_ES.zip"
		PATCH_DIR="title_update_7_ES"
		PATCH_EXE="title_update_7_ES/UpdateTitle.exe"
	elif [ "$POL_LANG" == "it" ]; then
		PATCH_URL="http://updates.rockstargames.com/patches/gtaiv/title_update_7_IT.zip"
		PATCH_DIR="title_update_7_IT"
		PATCH_EXE="title_update_7_IT/UpdateTitle.exe"
	elif [ "$POL_LANG" == "jp" ]; then
		PATCH_URL="http://updates.rockstargames.com/patches/gtaiv/title_update_7_JP.zip"
		PATCH_DIR="title_update_7_JP"
		PATCH_EXE="title_update_7_JP/UpdateTitle.exe"
	elif [ "$POL_LANG" == "ru" ]; then
		PATCH_URL="http://updates.rockstargames.com/patches/gtaiv/title_update_7_RU.zip"
		PATCH_DIR="title_update_7_RU"
		PATCH_EXE="title_update_7_RU/UpdateTitle.exe"
	else
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "http://updates.rockstargames.com/patches/gtaiv/title_update_7_EN.zip"
		PATCH_DIR="title_update_7_EN"
		wine start /unix "title_update_7_EN/UpdateTitle.exe"
	fi
	POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "$PATCH_URL"
	unzip "$PATCH_DIR.zip"
	wine start /unix "$PATCH_EXE"
	rm "$PATCH_DIR"
fi
 
POL_SetupWindow_message "$LNG_GAME_UPDATE_FINISHED" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk436SIACgkQ5TH6yaoTykc0ZwCgpxei8cKnAbu0PjGf2x8VRbsa
49oAoJf/AHct9lh50khKRKJ8Pa0J5j6j
=9eKm
-----END PGP SIGNATURE-----
