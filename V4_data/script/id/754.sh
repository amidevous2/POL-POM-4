#!/bin/bash
# Date : (2010-27-11 21-00)
# Last revision : (2010-27-11 21-00)
# Wine version used : 1.3.1
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Need For Speed Underground 2"
PREFIX="NFSUnderground2"
WORKING_WINE_VERSION="1.3.1"

if [ "$POL_LANG" == "fr" ]; then
LNG_GAME_UPDATE_WELCOME="Bienvenue dans le script d'installation du patch 1.2 pour $TITLE"
LNG_PATCH_METHOD="Choisissez votre méthode de patch"
LNG_HAVE_PATCH="Patcher le jeu depuis un fichier local"
LNG_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_GAME_UPDATE_DL="Patientez pendant le téléchargement du patch...\nCette opération peut prendre quelques minutes selon la vitesse de votre connexion."
LNG_GAME_UPDATE_FINISHED="Le patch a été correctement installé"
else
LNG_GAME_UPDATE_WELCOME="Welcome in the patch 1.2 Installation script for $TITLE"
LNG_PATCH_METHOD="Choose your patch method"
LNG_HAVE_PATCH="Patch from local file"
LNG_DL_PATCH="Download then use last patch"
LNG_LOCAL_PATCH="Select patch to execute"
LNG_GAME_UPDATE_DL="Wait while the patch is downloading...\nThis operation can take time, depending of you connexion."
LNG_GAME_UPDATE_FINISHED="Patch installed successfully"
fi

#starting the script
rm "$REPERTOIRE/tmp/*.jpg"
POL_SetupWindow_Init
POL_SetupWindow_free_presentation "$TITLE" "$LNG_GAME_UPDATE_WELCOME"

POL_SetupWindow_checkexist()
{	
	if [ ! -e $REPERTOIRE/wineprefix/$1 ]; then
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
 
select_prefixe "$REPERTOIRE/wineprefix/$PREFIX"

#Using specific Wine
Use_WineVersion "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES

#asking about patch local or not
cd $HOME
POL_SetupWindow_menu "$LNG_PATCH_METHOD" "$TITLE" "$LNG_HAVE_PATCH~$LNG_DL_PATCH" "~"
if [ "$APP_ANSWER" == "$LNG_HAVE_PATCH" ]; then
	POL_SetupWindow_browse "$LNG_LOCAL_PATCH" "$TITLE" ""
	wine "$APP_ANSWER"
else
	cd $REPERTOIRE/tmp
	if [ "$POL_LANG" == "fr" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfsu2/FR/NFSUG2V1-2FR.EXE"
		wine start /unix "NFSUG2V1-2FR.EXE"
		rm "NFSUG2V1-2FR.EXE"
	elif [ "$POL_LANG" == "de" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfsu2/GE/NFSUG2V1-2GE.EXE"
		wine start /unix "NFSUG2V1-2GE.EXE"
		rm "NFSUG2V1-2GE.EXE"
	elif [ "$POL_LANG" == "it" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfsu2/IT/NFSUG2V1-2IT.EXE"
		wine start /unix "NFSUG2V1-2IT.EXE"
		rm "NFSUG2V1-2IT.EXE"
	elif [ "$POL_LANG" == "uk" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfsu2/UK/NFSUG2V1-2UK.EXE"
		wine start /unix "NFSUG2V1-2UK.EXE"
		rm "NFSUG2V1-2UK.EXE"
	elif [ "$POL_LANG" == "es" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfsu2/SP/NFSUG2V1-2SP.EXE"
		wine start /unix "NFSUG2V1-2SP.EXE"
		rm "NFSUG2V1-2SP.EXE"
	elif [ "$POL_LANG" == "ko" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfsu2/KR/NFSUG2V1-2KR.EXE"
		wine start /unix "NFSUG2V1-2KR.EXE"
		rm "NFSUG2V1-2KR.EXE"
	elif [ "$POL_LANG" == "zh" ]; then
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfsu2/CH/NFSUG2V1-2CH.EXE"
		wine start /unix "NFSUG2V1-2CH.EXE"
		rm "NFSUG2V1-2CH.EXE"
	else
		POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "ftp://ftp.ea.com/pub/ea/patches/nfsu2/US/NFSUG2V1-2US.EXE"
		wine start /unix "NFSUG2V1-2US.EXE"
		rm "NFSUG2V1-2US.EXE"
	fi
fi
 
POL_SetupWindow_message "$LNG_GAME_UPDATE_FINISHED" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF0ACgkQ5TH6yaoTykeLYgCffuE/K6DEy1SsfEUpl50pAUjz
TNoAn0NYunbFhrFEvRPRZy+6gmPmk0+U
=+fUu
-----END PGP SIGNATURE-----
