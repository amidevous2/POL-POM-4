#!/bin/bash
# Date : (2009-11-23 03-05)
# Last revision : (2011-06-12 16-10)
# Wine version used : session : 1.1.17, assign : 1.1.22
# Distribution used to test : 
# Author : ljmellor, Updated by SuperPlumus
# Depend :
#
# CHANGELOG
# [SuperPlumus] (2011)
#   First script.
# [SuperPlumus] (2014 ?)
#   Updated
# [Dadu042] (2019-11-28)
#   Wine 1.2.3 -> 3.0.3
#   Script updated.

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Adobe Photoshop CS4"
PREFIX="PSCS4"
WORKING_WINE_VERSION="3.0.3"

if [ "$POL_LANG" = "fr" ]; then
LNG_CHOOSE_FILE="Veuillez selectionner le fichier .exe d'installation."
LNG_INSTALL_RUN="Installation en cours..."
LNG_SUCCES="$TITLE\na été installé avec succès !"
else
LNG_CHOOSE_FILE="Please select the .exe installation file."
LNG_INSTALL_RUN="Installation in progress..."
LNG_SUCCES="$TITLE\nhas been installed successfully."
fi

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Adobe" "http://www.adobe.com/products/photoshop/" "ljmellor and SuperPlumus" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "win7"

POL_Call POL_Install_msxml6
POL_Call POL_Install_gdiplus
POL_Call POL_Install_gecko
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_ie6

cd "$HOME"
POL_SetupWindow_browse "$LNG_CHOOSE_FILE" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine start /unix "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"


POL_Call POL_Function_OverrideDLL native atmlib.dll

POL_Shortcut "Photoshop.exe" "$TITLE" "" "" "Graphics;"
POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXeDjZgAKCRDlMfrJqhPK
R2V5AKCUMjO/dseOp3txppELMXrw0nFVIwCfXlU6lbmOStk5roA9BeOwgxrX6M8=
=oLYJ
-----END PGP SIGNATURE-----
