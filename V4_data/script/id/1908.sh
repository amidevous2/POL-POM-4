#!/bin/bash
# Date : (2013-12-17 17-51)
# Last revision : (2013-12-17 17-51)
# Wine version used : 1.2.3
# Distribution used to test : Ubuntu Gnome 13.10
# Author : Christophe B.
# Script licence : GPLv3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Photomatix Pro 3.2.9"
PREFIX="photomatix3"

# Début du script
POL_SetupWindow_Init
POL_SetupWindow_SetID 1908
POL_Debug_Init

# Fenêtre de présentation
POL_SetupWindow_presentation  "$TITLE" "HDRsoft" "http://www.hdrsoft.com/fr/" "Christophe B."

# Préparation de Wine
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.2.3"

# Extensions nécessaires
POL_Call POL_Install_corefonts
POL_Call POL_Install_dotnet20
POL_Call POL_Install_gdiplus

# Installation
POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run :')" "$TITLE"
    SetupFile="$APP_ANSWER"

elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_USER_ROOT/tmp"
    POL_Download "http://www.hdr-photography.com/download/fr/PhotomatixPro329frx32.exe"
    SetupFile="$PWD/PhotomatixPro329frx32.exe"
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupFile"

# Création du lanceur
POL_Shortcut "PhotomatixPro.exe" "$TITLE"

POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"

# Fin du script
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlK0hM8ACgkQ5TH6yaoTykfTGACeJzr23daRsoFopcBxzO0US8c5
NZEAn1BJdgIB12V/QN6o64JkNezmSwss
=yMXN
-----END PGP SIGNATURE-----
