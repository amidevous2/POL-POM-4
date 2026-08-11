#!/bin/bash
# Date : (????-??-?? ??-??)
# Last revision : (2014-08-13 12-22)
# Wine version used : -
# Distribution used to test : ?
# Stolen from: malownu, Updated by SuperPlumus

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Soldier of Fortune II: Double Helix Gold Edition"
PREFIX="SoldierofFortuneIIDoubleHelixGoldEdition"

if [ "$POL_LANG" == "fr" ]
then
LNG_INSTALL_RUN="Installation en cours..."
LNG_WAIT_END="Cliquez sur \"Suivant\" UNIQUEMENT quand l'installation de\n$TITLE sera terminée."
LNG_SUCCESS="$TITLE a été installé avec succès !"
else
LNG_INSTALL_RUN="Installation in progress..."
LNG_WAIT_END="Click on \"Forward\" ONLY when the\n$TITLE installation is finished."
LNG_SUCCESS="$TITLE has been installed successfully."
fi

POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Raven Software" "http://www.activision.com/games/soldieroffortune" "malownu, Modified by SuperPlumus, stolen and modified by TwistedDrifter" "$PREFIX"

POL_Wine_SelectPrefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_Wine_PrefixCreate

POL_LoadVar_PROGRAMFILES

POL_SetupWindow_browse
POL_Wine start /unix "$APP_ANSWER"

Set_OS "win2k"

POL_SetupWindow_wait "$LNG_INSTALL_RUN" "$TITLE"

POL_Wine start /unix "$APP_ANSWER"

POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"

POL_SetupWindow_auto_shortcut "$PREFIX" "SoF2.exe" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCESS" "$TITLE"

POL_SetupWindow_Close

exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhTd5gAKCRDlMfrJqhPK
R9e2AJwOjV/GT3bHLS6wJuN0iW1lvbPYPgCbBjWllgFojcLMZUgjSx0vnyCS+WM=
=G7Ye
-----END PGP SIGNATURE-----
