#!/bin/bash
# Date : (????-??-?? ??-??)
# Last revision : (2011-01-20 05-05)
# Wine version used : -
# Distribution used to test : ?
# Author : ?, Update by SuperPlumus

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Starcraft - Patch 1.15"
TITLE_BASE="Starcraft"
TITLE_PATCH="1.15"
PREFIX="Starcraft"

if [ "$POL_LANG" == "fr" ]; then
LNG_WELCOME="Bienvenue dans le script d'installation du patch $TITLE_PATCH pour $TITLE_BASE."
LNG_PREFIX_NOT_EXIST="Le jeu n'est pas installé."
LNG_CHOOSE_MEDIA_PATCH="Choisissez votre méthode de patch"
LNG_MEDIA_LOCAL_PATCH="Patcher le jeu depuis un fichier local"
LNG_MEDIA_DL_PATCH="Télécharger le dernier patch puis l'utiliser"
LNG_CHOOSE_LOCAL_PATCH="Selectionnez le patch à executer"
LNG_DOWNLOAD_RUN="Téléchargement en cours..."
LNG_INSTALL_RUN="Installation en cours..."
LNG_WAIT_END="Cliquez sur \"Suivant\" UNIQUEMENT quand l'installation de\n$TITLE sera terminée."
LNG_SUCCES="Le patch a été correctement installé"
else
LNG_WELCOME="Welcome in the patch $TITLE_PATCH Installation script for $TITLE."
LNG_PREFIX_NOT_EXIST="Game is not installed."
LNG_CHOOSE_MEDIA_PATCH="Choose your patch method"
LNG_MEDIA_LOCAL_PATCH="Patch from local file"
LNG_MEDIA_DL_PATCH=="Download then use last patch"
LNG_CHOOSE_LOCAL_PATCH="Select patch to execute"
LNG_DOWNLOAD_RUN="Downloading..."
LNG_INSTALL_RUN="Installation in progress..."
LNG_WAIT_END="Click on \"Forward\" ONLY when the\n$TITLE installation is finished."
LNG_SUCCES="Patch installed successfully"
fi

POL_SetupWindow_Init

POL_SetupWindow_free_presentation "$TITLE" "$LNG_WELCOME"

if [ ! -e "$REPERTOIRE/wineprefix/$PREFIX" ]; then
    POL_SetupError "$LNG_PREFIX_NOT_EXIST"
fi

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_LoadVar_PROGRAMFILES

POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA_PATCH" "$TITLE" "$LNG_MEDIA_LOCAL_PATCH~$LNG_MEDIA_DL_PATCH" "~"
GAME_MEDIAVERSION="$APP_ANSWER"

if [ "$GAME_MEDIAVERSION" == "$LNG_MEDIA_LOCAL_PATCH" ]; then

cd "$HOME"
POL_SetupWindow_browse "$LNG_CHOOSE_LOCAL_PATCH" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
wine start /unix "$SETUP_EXE"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"

elif [ "$GAME_MEDIAVERSION" == "$LNG_MEDIA_DL_PATCH" ]; then

cd "$REPERTOIRE/tmp"
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$TITLE" "http://ftp.blizzard.com/pub/starcraft/patches/PC/SC-115.exe"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
wine "SC-115.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
rm "$REPERTOIRE/tmp/SC-115.exe"

fi


POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJDwACgkQ5TH6yaoTykf4pQCfcofpynprnkY9MY+Vb96y69zR
lIYAn1jAuWEyOzdbFiIJqzOsehOtYDTR
=yBJH
-----END PGP SIGNATURE-----
