#!/bin/bash
# Date: (2009-07-28 11-16)
# Last revision: (2009-12-03 16-00)
# Distribution used to test: Ubuntu Jaunty
# Wine version used: 1.1.26
# Author: Berillions
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
Title="Runaway  : A Road Adventure"
Prefix="Runaway"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera
terminée sous peine de devoir recommencer l'installation."
else
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation
is finished or you will have to redo the installation.."
fi
 
cd $REPERTOIRE/tmp
rm *.jpg
wget http://cdn.cnetnetworks.fr/gamekult-com/images/photos/00/00/28/77/ME0000287788_2.jpg --output-document="$REPERTOIRE/tmp/$Title.jpg"
convert "$REPERTOIRE/tmp/$Title.jpg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpg"
 
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpg" 
 
#Presentation
POL_SetupWindow_presentation "$Title" "Pendulo Studios" "http://www.runaway-lejeu.com/" "Berillions" "$Prefix"
 
#Installation de Wine
POL_SetupWindow_install_wine "1.1.43"
 
#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe" 
 
#Préparation de Wine
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
#POL_SetupWindow_prefixcreate
 
#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
 
#Taille de la mémoire graphique
POL_SetupWindow_menu_list "Your Memory Graphic" "$Title" "32 64 128 256 384 512 768 896 1024 2048" " "
VMS="$APP_ANSWER"
 
#Réglage Direct3D
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > OGL.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> OGL.reg
regedit OGL.reg
 
#Configuration de Wine
Set_OS winxp
 
POL_SetupWindow_wait_next_signal "Installing ..." "$Title"
wine "$CDROM/Setup.exe"
POL_SetupWindow_detect_exit
 
POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
 
#Création Icone
convert "$HOME/.local/share/icons/*_runaway.0.xpm" -geometry 32x32 "$REPERTOIRE/icones/32/$Title"
 
#Création Launcher 
POL_SetupWindow_make_shortcut "$Prefix" "$PROGRAMFILES/PENDULO Studios/RUNAWAY - A road adventure" "Runaway.exe" "" "$Title"
 
Set_WineVersion_Assign "1.1.43" "$Title"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFEACgkQ5TH6yaoTykds/ACaAx0K1NCT1nYZOK+qRO4VoLBG
FeAAnR1Z/r2bgAlTKFaw5Hc96+LB/RDr
=jFUy
-----END PGP SIGNATURE-----
