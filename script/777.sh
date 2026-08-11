#!/bin/bash
# Date : (2011-01-21 19-48)
# Last revision : (2011-01-21 19-48)
# Wine version used : 1.3.5
# Distribution used to test : Debian Squeeze (Testing)
# Author : syberia303
 
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
TITLE="ReBirth RB-338"
PREFIX="ReBirth"
WORKING_WINE_VERSION="1.3.5"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_WAIT_WARNING="ReBirth: un studio complet pour les amateurs de musique électronique"
LNG_WAIT_START="L'installation va commencer..."
LNG_INSTALL_RUN="Installation en cours..."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du programme sera\nterminée sous peine de devoir recommencer l'installation."
LNG_WAIT_HF="Deux TB 303, une TR 808 et une TR 909, enjoy..." 
else
LNG_WAIT_WARNING="ReBirth: a complete studio for electronic music lovers"
LNG_WAIT_START="Installation is going to begin..." 
LNG_INSTALL_RUN="Installation in progress..."
LNG_WAIT_END="Click on \"Next\" ONLY when the software installation is finished\nor you will have to install again the game."
LNG_WAIT_HF="Two TB 303, a TR 808 and a TR 909, enjoy..."
fi
 
#Starting the script
#POL_GetSetupImages "<ADRESSE_IMAGE_TOP>" "<ADRESSE_IMAGE_LEFT>" "$TITLE"
#POL_SetupWindow_InitWithImages
POL_SetupWindow_Init
 
#Presentation
POL_SetupWindow_presentation "$TITLE" "Propellerhead Software" "http://www.rebirthmuseum.com/" "syberia303" "$PREFIX"
 
POL_SetupWindow_message "$LNG_WAIT_WARNING" "$TITLE"
 
POL_SetupWindow_message "$LNG_WAIT_START" "$TITLE"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
 
#downloading specific Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"
 
#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Install Rebirth RB-338.exe"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$TITLE"
wine start /unix "$CDROM/Install Rebirth RB-338.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"

 
POL_SetupWindow_auto_shortcut "$PREFIX" "rebirth.exe" "$TITLE"
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_WAIT_HF" "$TITLE"
 
POL_SetupWindow_Close 
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFwACgkQ5TH6yaoTykfbtQCdHQdjN3KgywbQDkYB2qjQwH3m
A8sAniPLyWGjWLFWH6EfYOTH5O5z3vFx
=ozxR
-----END PGP SIGNATURE-----
