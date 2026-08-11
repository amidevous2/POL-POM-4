#!/bin/bash
# Date : (2008-01-06 16-09)
# Last revision : (2011-01-23 13-52)
# Wine version used : 1.2
# Distribution used to test : ?
# Author : liquidalien and Tinou, Updated by SuperPlumus

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Microsoft Money 2004"
PREFIX="money2004"
WORKING_WINE_VERSION="1.2"

if [ "$POL_LANG" == "fr" ]
then
LNG_CDROM_NOT_FOUND="ERREUR : Le CD-ROM n'a pas été trouvé !"
LNG_INSTALL_RUN="Installation en cours..."
LNG_WAIT_END="Cliquez sur \"Suivant\" UNIQUEMENT quand l'installation de\n$TITLE sera terminée."
LNG_SUCCES="$TITLE a été installé avec succès !"
else
LNG_CDROM_NOT_FOUND="ERROR : Unable to find the CD-ROM!"
LNG_INSTALL_RUN="Installation in progress..."
LNG_WAIT_END="Click on \"Forward\" ONLY when the\n$TITLE installation is finished."
LNG_SUCCES="$TITLE has been installed successfully."
fi

POL_SetupWindow_Init
POL_System_SetArch "x86"
POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.microsoft.com/" "liquidalien and Tinou, Modified by SuperPlumus" "$PREFIX"

POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_LoadVar_PROGRAMFILES

POL_Call POL_Install_ie6

SETUP=""
while [ "$SETUP" = "" ]
do
    POL_SetupWindow_cdrom
    if [ "$(find "$CDROM" -iname setup.exe)" = "$CDROM/setup.exe" ]; then
        SETUP="setup.exe"
    elif [ "$(find "$CDROM" -iname install.exe)" = "$CDROM/install.exe" ]; then
        SETUP="install.exe"
    else
        POL_SetupWindow_message "$LNG_CDROM_NOT_FOUND" "$TITLE"
    fi
done

cd "$CDROM"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
wine start /unix "$CDROM/$SETUP"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"

POL_SetupWindow_auto_shortcut "$PREFIX" "msmoney.exe" "$TITLE" "money.xpm"
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk5XgWIACgkQ5TH6yaoTykd2CQCglunU6To20a2bu1b8xY6GnS5a
310An0PSyzdH1Y5riQV+jx53dg0Njubo
=P2/S
-----END PGP SIGNATURE-----
