#!/bin/bash
# Date : (2010-30-04 21-00)
# Last revision : (2011-12-07 21-00)
# Wine version used : 1.3.19, 1.3.23
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="The Sims Medieval"
PREFIX="thesimsmedieval"
WORKING_WINE_VERSION="1.3.23"
PVERSION="1.3.13"

if [ "$POL_LANG" == "fr" ]; then
TITLE="Les Sims Medieval"
LNG_GAME_UPDATE_WELCOME="Bienvenue dans le script d'installation du\npatch $PVERSION pour $TITLE"
LNG_STEAM="Steam a son propre système de mise à jour automatique."
LNG_PATCH_METHOD="Choisissez votre méthode de patch"
LNG_HAVE_PATCH="Patcher le jeu depuis un fichier local"
LNG_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_GAME_UPDATE_DL="Patientez pendant le téléchargement du patch...\nCette opération peut prendre quelques minutes selon la vitesse de votre connexion."
LNG_PATCH_DONE="Le patch pour $TITLE à été\ninstallé avec succès."
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch $PVERSION Installation script\nfor $TITLE"
LNG_STEAM="Steam have is own automatic update system."
LNG_PATCH_METHOD="Choose your patching method"
LNG_HAVE_PATCH="Patch from local file"
LNG_DL_PATCH="Download then use last patch"
LNG_LOCAL_PATCH="Select patch to execute"
LNG_GAME_UPDATE_DL="Wait while the patch is downloading...\nThis operation can take time, depending of you connexion."
LNG_PATCH_DONE="Patch for $TITLE has been\ninstalled successfully."
fi

# Starting the script
cd "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/thesimsmedieval/top.jpg" "http://files.playonlinux.com/resources/setups/thesimsmedieval/left.jpg" "$TITLE"
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

# Check if it's Digital Version
unset GAME_DIGITAL
if [ -e "$WINEPREFIX/drive_c/DIGITAL_CHECK" ]; then
	GAME_DIGITAL="1"
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
	POL_SetupWindow_message "$LNG_GAME_UPDATE_DL" "$TITLE"
	if [ "$GAME_DIGITAL" == "1" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "http://akamai.cdn.ea.com/eadownloads/u/f/sims/sims/patches/TheSimsMedievalPatch_1.3.13.00107_Update.exe"
		wine start /unix "TheSimsMedievalPatch_1.3.13.00107_Update.exe"
		rm "TheSimsMedievalPatch_1.3.13.00107_Update.exe"
	else	
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "http://akamai.cdn.ea.com/eadownloads/u/f/sims/sims/patches/TheSimsMedievalPatch_1.3.13.00001_Update.exe"
		wine start /unix "TheSimsMedievalPatch_1.3.13.00001_Update.exe"
		rm "TheSimsMedievalPatch_1.3.13.00001_Update.exe"
	fi
fi

POL_SetupWindow_message "$LNG_PATCH_DONE" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4chgUACgkQ5TH6yaoTykdNVQCgp4fJXvvaDtKejMeoSgvz+jHV
/3QAnil+Zn+7cKw9BvgI3WwUDHXzfnzH
=lzk/
-----END PGP SIGNATURE-----
