#!/bin/bash
# Installation de Picasa 3.9
# RealName: Picasa 3.9
# Date : (2012-11-19 14-52)
# Last revision : (2019-12-27 01-50)
# Author : raybb

# CHANGELOG
#
# 2019-12-27 22:20 [Dadu042]:
#   - Standardize comments.
#   - Add POL_Shortcut category.
#
# 2019-12-27 01-50 [raybb]:
#    - Upgrade to wine 3.20 to avoid freefont issue
#    - Remove IE8 Installation (wasn't working and google APIs are no longer working anyway https://www.programmableweb.com/news/picasa-web-albums-data-api-to-be-deprecated/brief/2018/12/08)
#    - Update download url to archive.org
#    - If you want to avoid the crash messages add `export POL_IgnoreWineErrors=True` to your start script.
#
# 2015-02-06 00-34 [strudl]: 
#  Added Wine 1.7.33 x86 
#  Adding HKEY_CURRENT_USER\Software\Google\Picasa\Picasa2\Preferences GoogleOAuth* value
#  from a working machine, worked fine till ~2015-01-15 
#
# 2014-12-08 19-36 [petch]:
#    Wine 1.6.2
#    set $TITLE before POL_Debug_Init call
#    only use Set_OS after prefix creation
#    call POL_System_TmpCreate before using $POL_System_TmpDir
#    only create the prefix once the installer has been located
 
 
# Is POL running ?
[ "$PLAYONLINUX" = "" ] && exit 0
 
 
# Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
# Nom du script et du disque
TITLE="Picasa 3.9"
PREFIX="Picasa"
WORKING_WINE="2.22"
 
# Controle de version
POL_SetupWindow_Init
POL_Debug_Init
 
# Nom des raccourcis
SHORTCUT="Picasa 3.9"
 
# Nom des fichier BIN
BIN="picasa39-setup.exe"
 
# Presentation
POL_SetupWindow_presentation "$TITLE" "Google" "http://www.google.com/" "Percherie" "$PREFIX"
 
 
# Choix du fichier de la source d'installation
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "$BIN"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    # Téléchargement de Picasa
    POL_Download "https://web.archive.org/web/2016/https://dl.google.com/picasa/picasa39-setup.exe"
    INSTALLER="$POL_System_TmpDir/$BIN"
fi
 
# Configuration du disque virtuel
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE"
POL_SetupWindow_improve_fonts
Set_OS "winxp"

POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "$INSTALLER"
 
 
# Raccourci pour Picasa
POL_Shortcut "Picasa3.exe" "$SHORTCUT" "" "" "Graphics;"
 
# Fermeture de l'assistant d'installation
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgZ3IQAKCRDlMfrJqhPK
R87OAJ4+N+Eu+Wa1d9XSJFV+OltWKdzUGQCggr/bcgRezzxMfAc3jvGqGFx6IUw=
=VcxY
-----END PGP SIGNATURE-----
