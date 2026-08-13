#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# CHANGELOG
# Dadu042  05/10/2019
#  Fix broken URL (to 2013's) because official website has shutdown.


POL_SetupWindow_Init
TITLE="Graphe 2D"
PREFIX="Graphe2D"
 
EDITEUR="Jean-Yves Magna"
EDITEUR_URL="http://www.jymagna.com/"
URL="http://web.archive.org/web/20131005144439/http://jymagna.com/G2D.exe"
FILE="G2D.exe"
EXECUTABLE="Graphe_2D.exe"
AUTEUR="Tinou"
 
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
 
 
cd "$REPERTOIRE/tmp"
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$TITLE" "$URL"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
wine "$FILE"
POL_SetupWindow_detect_exit
rm "$FILE"
 
POL_SetupWindow_auto_shortcut "$PREFIX" "$EXECUTABLE" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXZghIQAKCRDlMfrJqhPK
RzW0AKCx7rbgT3Z6RZ3kAXhz7QzHmEogIACfbM4TENuD7/g/cozBNM5aom+59vs=
=JwkM
-----END PGP SIGNATURE-----
