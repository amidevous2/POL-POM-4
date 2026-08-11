#!/bin/bash
# Date : (2009-06-17 14-00)
# Last revision : (2009-06-17 14-00)
# Wine version used : N/A 
# Distribution used to test : N/A
# Author : NSLW

#Translated from V2 to V3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

TITLE="Ragnarok Online"
PREFIX="RagnarokOnline"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Gravity Corp. et Lee Myoungjin" "http://www.ragnarokonline.fr" "Xafic and NSLW" "$PREFIX"  

POL_SetupWindow_question "Do you have got $TITLE installation file?" "$TITLE"
if [ "$APP_ANSWER" == "TRUE" ] ;then
POL_SetupWindow_browse "Select RagnarokOnline installation file" "$TITLE" ""
ROINSTALLATIONFILE="$APP_ANSWER"
else

cd "$REPERTOIRE/ressources/"
if [ ! -e "RagnarokOnline_11.2a.exe" ]; then
POL_SetupWindow_download "Veuillez patienter pendant le téléchargement du client de Ragnarok..." "$TITLE" "http://www.ragnarokexperience.com/RagnarokOnline_11.2a.exe"
fi
ROINSTALLATIONFILE="RagnarokOnline_11.2a.exe"
fi

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

cd "$REPERTOIRE/ressources/"
POL_SetupWindow_wait_next_signal "Patientez pendant l'extraction de Ragnarok Online" "$TITLE"
wine "$ROINSTALLATIONFILE"
POL_SetupWindow_detect_exit

POL_Shortcut "Ragnarok.exe" "$TITLE"
POL_SetupWindow_reboot

POL_SetupWindow_message "Installation terminée" "$TITLE"
POL_SetupWindow_Close
exit

#Presentation
#presentation "Ragnarok Online" "Gravity Corp. et Lee Myoungjin" "http://www.ragnarokonline.fr" "Xafic" "RagnarokOnline"
 
#Cette partie contiendra le code du jeu.
#mkdir -p $REPERTOIRE/wineprefix/RagnarokOnline
#rm $REPERTOIRE/tmp/RagnarokOnline/ -R
#mkdir -p $REPERTOIRE/tmp/RagnarokOnline
#cd $REPERTOIRE/tmp/RagnarokOnline
#telecharger "Veuillez patienter pendant le téléchargement du client de Ragnarok..." "http://www.ragnarokonline.fr/FR_OB/download/Client/InstallRagnarok.exe"
#message "Téléchargement terminé. nAppuyez sur entrer, puis patientez le temps de préparer l'installation"
#select_prefixe "$HOME/.PlayOnLinux/wineprefix/RagnarokOnline/"
#creer_prefixe
#attendre "Patientez pendant l'extraction de Ragnarok Online"
#wine ./InstallRagnarok.exe
#Fin du code du jeu
#simuler_reboot
#Création du lanceur
#creer_lanceur "RagnarokOnline" "Program Files/Gravity/Ragnarok_france/" "Ragnarok.exe"
#rm $REPERTOIRE/tmp/RagnarokOnline/ -R
 
#message "Installation terminée"
#exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPT0ZwAKCRDlMfrJqhPK
R2VDAKCPL89KnnuMYjL0nXP4wHybblPbaACfXuxpcF43TfJ4DkoHNyujylIuk0g=
=p97r
-----END PGP SIGNATURE-----
