#!/bin/bash
# Date : (????-??-?? ??-??)
# Last revision : (2011-01-21 12-20)
# Wine version used : -
# Distribution used to test : ?
# Author : malownu, Updated by SuperPlumus

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Soldier of Fortune Platinum"
PREFIX="SoldierofFortunePlatinum"

if [ "$POL_LANG" == "fr" ]
then
LNG_INSTALL_RUN="Installation en cours..."
LNG_WAIT_END="Cliquez sur \"Suivant\" UNIQUEMENT quand l'installation de\n$TITLE sera terminée."
LNG_SUCCES="$TITLE a été installé avec succès !"
else
LNG_INSTALL_RUN="Installation in progress..."
LNG_WAIT_END="Click on \"Forward\" ONLY when the\n$TITLE installation is finished."
LNG_SUCCES="$TITLE has been installed successfully."
fi

POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Raven Software" "http://www.activision.com/games/soldieroffortune" "malownu, Modified by SuperPlumus" "$PREFIX"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_LoadVar_PROGRAMFILES

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"

Set_OS "win2k"

cd "$CDROM"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
wine "$CDROM/Setup.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"

POL_SetupWindow_auto_shortcut "$PREFIX" "SoF.exe" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEIACgkQ5TH6yaoTykfrvQCfUfketjlVq65BZXjPCRjveDEn
arIAoJJizO88kHbNeT6PqIKYrK6PfkJs
=KJnF
-----END PGP SIGNATURE-----
