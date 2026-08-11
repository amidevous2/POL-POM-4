#!/bin/bash
# Date : (2013-12-20 10-33)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 13.10, Kubuntu 18.04 amd64
# Author : Christophe B.
# Script licence : GPLv3

# CHANGELOG
# [Christophe B.] (2013-12-20 10-33)
#   First script.
# [Dadu042] (2019-11-28)
#   Wine 1.6.1 -> 3.0.3
#   Force x86 mode.
#   Repair download URL.
#   Add categories.
#   Add warning fixme-all
#   Add POL_RequiredVersion "4.2.12"

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Photomatix Pro 4"
PREFIX="photomatix4"

# Début du script
POL_SetupWindow_Init
POL_SetupWindow_SetID 1909
POL_Debug_Init

# Fenêtre de présentation
POL_SetupWindow_presentation  "$TITLE" "HDRsoft" "http://www.hdrsoft.com/fr/" "Christophe B."

# Avertissement
POL_SetupWindow_message "$(eval_gettext 'Lorsque Wine demande à installer le paquet "Mono", cliquer sur "Annuler"')" "$TITLE"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Préparation de Wine
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "3.0.3"

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
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
    SetupFile="$APP_ANSWER"

elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_USER_ROOT/tmp"
    POL_Download "https://www.hdrsoft.com/download/win/fr/PhotomatixPro427frx32.exe" "be425455900802c66eb5c90277c69d08"
    SetupFile="$PWD/PhotomatixPro427frx32.exe"
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupFile"

# Création du lanceur
POL_Shortcut "PhotomatixPro.exe" "$TITLE"  "" "" "Graphics;RasterGraphics;"

POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"

# Fin du script
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXeD45AAKCRDlMfrJqhPK
Ry3TAKCMG00gI5ur2BVqiLBioUnOu0/gQwCfUDZXpuBadQ39HqEDSSJDx7VcAxA=
=VWi6
-----END PGP SIGNATURE-----
