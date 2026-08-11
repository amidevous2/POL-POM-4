#!/bin/bash
# Date: (2009-12-31 11-46)
# Distribution used to test: Debian Sid
# Wine version used: 1.1.35
# Author: Berillions
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
Title="Runaway 3 : A Twist of Fate"
Prefix="Runaway3"
IMG="$WINEPREFIX/drive_c/$PROGRAMFILES/Runaway A Twist of Fate"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera
terminée sous peine de devoir recommencer l'installation."
else
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation
is finished or you will have to redo the installation.."
fi
 
cd $REPERTOIRE/tmp
rm *.jpg
wget http://cdn.cnetnetworks.fr/gamekult-com/images/photos/00/01/19/86/ME0001198630_2.jpg --output-document="$REPERTOIRE/tmp/$Title.jpg"
convert "$REPERTOIRE/tmp/$Title.jpg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpg"
 
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpg" 
 
#Presentation
POL_SetupWindow_presentation "$Title" "Pendulo Studios" "http://www.runaway-lejeu.com/" "Berillions" "$Prefix"
 
#Installation de Wine
POL_SetupWindow_install_wine "1.1.43"
 
#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe" 
 
#Préparation de Wine
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
#POL_SetupWindow_prefixcreate
 
#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
 
#Install Directx9
POL_Call POL_Install_d3dx9
 
#Taille de la mémoire graphique
POL_SetupWindow_menu_list "Your Memory Graphic" "$Title" "32 64 128 256 384 512 768 896 1024 2048" " "
VMS="$APP_ANSWER"
 
#Réglage DirectDrawRenderer
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > OGL.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> OGL.reg
regedit OGL.reg
 
#Configuration de Wine
Set_OS winxp
 
POL_SetupWindow_wait_next_signal "Installing ..." "$Title"
wine "$CDROM/setup.exe"
POL_SetupWindow_detect_exit
 
POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
 
#Création Icone
cd "$REPERTOIRE/tmp"
wget http://sd-1.archive-host.com/membres/images/51568577817080088/ratof.png
mv "$REPERTOIRE/tmp/ratof.png" "$REPERTOIRE/icones/32/$Title"
 
#Création Launcher 
POL_SetupWindow_make_shortcut "$Prefix" "$PROGRAMFILES/Pendulo Studios/RUNAWAY - A TWIST OF FATE" "RATOF.exe" "" "$Title"
 
Set_WineVersion_Assign "1.1.43" "$Title"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFgACgkQ5TH6yaoTykdHEwCfWSfB/dcyKnEn6UHM1rjxEHrK
KiwAoJoPr2u5t45nbtr3cIYBW4o2wSG9
=9XRF
-----END PGP SIGNATURE-----
