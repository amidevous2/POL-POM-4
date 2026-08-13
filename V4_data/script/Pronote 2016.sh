#!/bin/bash
# Installation de Pronote
# RealName: Pronote 2016
# Date : (2015-09-12 14-52)
# Last revision : (2016-09-22 20-20)
# Author : Percherie
 
 
#Vérifier que PlayOnLinux est exécuté
[ "$PLAYONLINUX" = "" ] && exit 0
 
 
# Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
# Nom du script et du disque
TITLE="Pronote 2016"
PREFIX="Pronote"
WORKING_WINE="1.8.4"
 
# Controle de version
POL_SetupWindow_Init
POL_Debug_Init
 
# Nom des raccourcis
SHORTCUT="Client Pronote"
 
# Nom des fichier BIN
BIN="Install_PRNclient_FR2700202.exe"
 
# Presentation
POL_SetupWindow_presentation "$TITLE" "Index Education" "http://www.index-education.com/" "Percherie" "$PREFIX"
 
 
# Choix du fichier de la source d'installation
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Veuillez choisir le fichier d'installation')" "$TITLE" "$BIN"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    # Téléchargement de Pronote
    POL_Download "http://tele3.index-education.com/telechargement/pn/V27.0/exe/$BIN"
    INSTALLER="$POL_System_TmpDir/$BIN"
fi
 
# Configuration du disque virtuel
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE"
POL_Call POL_Install_msxml6
POL_Wine_OverrideDLL "native,builtin" "msxml6"
Set_OS win7
 
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "$INSTALLER"
 
 
# Raccourci pour Pronote
POL_Shortcut "Client PRONOTE.exe" "$SHORTCUT"
 
 
# Fermeture de l'assistant d'installation
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlfoAooACgkQ5TH6yaoTykefbgCgh/XJ8PXK7DSORKawJdnBg16s
pokAn3Q40Djr3A8T7Q398JwiPtfzh6nK
=gAlO
-----END PGP SIGNATURE-----
