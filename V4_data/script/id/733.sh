#!/bin/bash
# Date : (2010-07-11 21-00)
# Last revision : (2010-20-07 21-00)
# Wine version used : 1.3.7, 1.3.15, 1.3.23
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Star Wars : The Force Unleashed - Ultimate Sith Edition"
PREFIX="swtfu"
WORKING_WINE_VERSION="1.3.15"
PVERSION="1.2"

if [ "$POL_LANG" == "fr" ]; then
TITLE="Star Wars : Le Pouvoir de la Force - Ultimate Sith Edition"
LNG_GAME_UPDATE_WELCOME="Bienvenue dans le programme d'installation du\npatch $PVERSION pour $TITLE"
LNG_PATCH_METHOD="Choisissez votre méthode de patch"
LNG_HAVE_PATCH="Patcher le jeu depuis un fichier local"
LNG_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_PATCH_VERSION="Quelle version du jeu possèdez-vous ?"
LNG_PATCH_US="Version US"
LNG_PATCH_EU="Version Européenne"
LNG_GAME_UPDATE_DL="Patientez pendant le téléchargement du patch...\nCette opération peut prendre quelques minutes selon la vitesse de votre connexion."
LNG_INSTALL_ON="Installation en cours..."
LNG_PATCH_DONE="Le patch pour $TITLE à été\ninstallé avec succès."
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch $PVERSION Installation software\nfor $TITLE"
LNG_PATCH_METHOD="Choose your patch method"
LNG_HAVE_PATCH="Patch from local file"
LNG_DL_PATCH="Download then use last patch"
LNG_LOCAL_PATCH="Select patch to execute"
LNG_PATCH_VERSION="Which version do you have?"
LNG_PATCH_US="US version"
LNG_PATCH_EU="European version"
LNG_GAME_UPDATE_DL="Wait while the patch is downloading...\nThis operation can take time, depending of you connexion."
LNG_INSTALL_ON="Installation in progress..."
LNG_PATCH_DONE="Patch for $TITLE has been\ninstalled successfully."
fi

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/swtfu/top.jpg" "http://files.playonlinux.com/resources/setups/swtfu/left.jpg" "$TITLE"
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

# Creating prefix 
POL_SetupWindow_prefixcreate

# Asking about patch local or not
cd "$HOME"
POL_SetupWindow_menu "$LNG_PATCH_METHOD" "$TITLE" "$LNG_HAVE_PATCH~$LNG_DL_PATCH" "~"
if [ "$APP_ANSWER" == "$LNG_HAVE_PATCH" ]; then
	POL_SetupWindow_browse "$LNG_LOCAL_PATCH" "$TITLE" ""
	POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
	wine start /unix "$APP_ANSWER"
	wineserver -w
	POL_SetupWindow_detect_exit
else
	POL_SetupWindow_menu "$LNG_PATCH_VERSION" "$TITLE" "$LNG_PATCH_US~$LNG_PATCH_EU" "~"
	GAME_VERSION="$APP_ANSWER"
	if [ "$GAME_VERSION" == "$LNG_PATCH_EU" ]; then
		PATCH_URL="http://files.aspyr.com/support/SWTFU_PC_EFIGS_1.2_Update.exe"
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "$PATCH_URL"
		POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
		wine start /unix "SWTFU_PC_EFIGS_1.2_Update.exe"
		POL_SetupWindow_detect_exit
		rm "SWTFU_PC_EFIGS_1.2_Update.exe"
	else
		PATCH_URL="http://files.aspyr.com/support/SWTFU_PC_EF_1.2_Update.exe"
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "$PATCH_URL"
		POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
		wine start /unix "SWTFU_PC_EF_1.2_Update.exe"
		POL_SetupWindow_detect_exit
		rm "SWTFU_PC_EF_1.2_Update.exe"
	fi
fi

POL_SetupWindow_message "$LNG_PATCH_DONE" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4nAIQACgkQ5TH6yaoTykctGwCfXqRCixcick3kiKDIv9if/MyN
1Q4AoKesHKwLFLtXQqGir3+HRFKptHgz
=ViMQ
-----END PGP SIGNATURE-----
