#!/bin/bash
# PlayOnLinux Function
 
# Date : (2011-01-21 04-54)
# Last revision : (2011-01-21 04-54)
# Author : SuperPlumus

# Arguments
# $1 : Nom du script
# $2 : Nom du préfixe
# $3 : Editeur
# $4 : URL Editeur
# $5 : URL du programme à télécharger
# $6 : Nom de l'éxécutable
# $7 : Auteur du script
TITLE="$1"
PREFIX="$2"

EDITEUR="$3"
EDITEUR_URL="$4"
URL="$5"
FILE="${URL##*/}"
FILE="${FILE%%\?*}"
EXECUTABLE="$6"
AUTEUR="$7"

if [ "$POL_LANG" == "fr" ]
then
LNG_DOWNLOAD_RUN="Téléchargement en cours..."
LNG_INSTALL_RUN="Installation en cours..."
LNG_WAIT_END="Cliquez sur \"Suivant\" UNIQUEMENT quand l'installation de\n$TITLE sera terminée."
LNG_SUCCES="$TITLE a été installé avec succès !"
else
LNG_DOWNLOAD_RUN="Downloading..."
LNG_INSTALL_RUN="Installation in progress..."
LNG_WAIT_END="Click on \"Forward\" ONLY when the\n$TITLE installation is finished."
LNG_SUCCES="$TITLE has been installed successfully."
fi

POL_SetupWindow_presentation "$TITLE" "$EDITEUR" "$EDITEUR_URL" "$AUTEUR" "$PREFIX"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_LoadVar_PROGRAMFILES

cd "$REPERTOIRE/tmp"
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$TITLE" "$URL"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
POL_Wine "$FILE"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
rm "$FILE"

POL_SetupWindow_auto_shortcut "$PREFIX" "$EXECUTABLE" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk9We6IACgkQ5TH6yaoTykd5BQCggdpW5jC//prEUORcvr+HzXvX
fn4AoJeuY5R/j8bfGB86OqHWAIAC5NHX
=4mcd
-----END PGP SIGNATURE-----
