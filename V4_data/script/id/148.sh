#!/bin/bash
# Date : (????-??-?? ??-??)
# Last revision : (2011-01-20 04-45)
# Wine version used : -
# Distribution used to test : ?
# Author : ?, Update by SuperPlumus

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Starcraft : Brood War - Patch 1.15.2"
TITLE_BASE="Starcraft : Brood War"
TITLE_PATCH="1.15.2"
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
LNG_INSERT_MEDIA="Le patch a été correctement installé.\nLe patch 1.15.2 permet de jouer sans le CD,\nmais il faut copier un fichier depuis le CD-ROM de $TITLE_BASE\n\n\nVeuillez insérer le disque $TITLE_BASE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_COPY="Copie du fichier en cours..."
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
LNG_INSERT_MEDIA="The installation went fine.\nThe 1.15.2 patch allow you to play without the CD-ROM,\nbut we need to copy a file from the $TITLE_BASE CD-ROM\n\n\nPlease insert $TITLE_BASE media into your disk drive\nif not already done."
LNG_COPY="Copying the file..."
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
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$TITLE" "http://ftp.blizzard.com/pub/broodwar/patches/PC/BW-1152.exe"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
wine "BW-1152.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
rm "$REPERTOIRE/tmp/BW-1152.exe"

fi

POL_SetupWindow_message "$LNG_INSERT_MEDIA" "$TITLE"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "install.exe"

POL_SetupWindow_wait_next_signal "$LNG_COPY" "$TITLE"
cp "$CDROM/install.exe" "$WINEPREFIX/drive_c/$PROGRAMFILES/Starcraft/Broodwar.mpq"
POL_SetupWindow_detect_exit

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEMACgkQ5TH6yaoTykcVQwCfVw9/5znRG/AyUxcDkCHdwNBA
CEgAnRC96NyiiMkuEhZQXtjGNp8XVpQs
=VZXO
-----END PGP SIGNATURE-----
