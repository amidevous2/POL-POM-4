#!/bin/bash
 
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
 
source "$PLAYONLINUX/lib/sources"
 
wget http://upload.wikimedia.org/wikipedia/en/thumb/0/09/Sc4box.jpg/250px-Sc4box.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"
 
#Check dependencies

cfg_check
 
#Presentation

POL_SetupWindow_presentation "SimCity 4" "EA Games - Maxis" "http://www.electronicarts.com" "Toumeno" "SimCity4"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_SC4PATCH_DL="Téléchargement de la mise à jour..."
LNG_SC4_WHERE="Où avez-vous acheté votre jeu SimCity 4 ?"
LNG_SC4_WAIT="Patientez pendant la préparation de l'installation"
LNG_SC4_CD2="Veuillez insérer le CD2 et cliquer sur Suivant"
LNG_SC4_REMCD2="Veuillez enlever le CD2 et cliquer sur Suivant"
LNG_SC4_CHANGE="Quand l'installateur vous demandera le CD2, cliquez sur Suivant dans cette fenêtre"
LNG_SC4_CONTINUE="Continuez l'installation s'il vous plait en cliquant sur Ok dans l'installateur\nCliquez sur suivant dans cette fenêtre UNIQUEMENT quand\nl'installation sera terminée"
LNG_SC4_CRACK="Vous aurez besoin d'un crack no cd pour lancer SimCity 4.\nVous devez posséder le jeu original.\nPlayOnLinux ne vous fournira aucune aide pour les cracks no cd.\nPlayOnLinux n'est pas reponsable de l'utilisation que vous faites du logiciel."
LNG_SC4_CD1="Veuillez insérer le CD 1 et cliquer sur Suivant"
LNG_SC4_RUN="Si le jeu ne se lance pas correctement, appuyez sur Echap."
LNG_SC4_FIN="Installation terminée"
 
else
 
LNG_SC4PATCH_DL="Downloading the update..."
LNG_SC4_WHERE="Where did you buy your SimCity 4 game?"
LNG_SC4_WAIT="Please wait during the installation's preparation"
LNG_SC4_CD2="Please insert the CD2 and click on Next"
LNG_SC4_REMCD2="Please remove the CD2 and click on Next"
LNG_SC4_CHANGE="When the installer will ask you for the CD2, click on Next (in this window)"
LNG_SC4_CONTINUE="Please continue the installation by clicking Ok in the installer\nClick on Next in this window ONLY if the install is finished"
LNG_SC4_CRACK="You will need a no cd crack to run SimCity 4.\nYou must own the original game.\nPlayOnLinux will not give you any help about no cd cracks.\nPlayOnLinux is not responsible of the use of the software."
LNG_SC4_CD1="Please insert the CD 1 and click on Next"
LNG_SC4_RUN="If the game does not run correctly, press Esc (Echap)."
LNG_SC4_FIN="Installation Finished"
 
fi
 
#Wine preparation

mkdir -p "$REPERTOIRE/wineprefix/SimCity4"
cd "$REPERTOIRE/wineprefix/SimCity4"
select_prefixe "$(pwd)"
POL_SetupWindow_prefixcreate
 
POL_SetupWindow_message "$LNG_SC4_CD1"
 
#CD-ROM detection

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
 
# Wine settings

Set_OS "win2k"
Set_SoundDriver alsa
Set_GLSL Off
Set_WineVersion_Session 0.9.44
 
# Game installation
 
# Create Windows drives
cd "$REPERTOIRE/wineprefix/SimCity4/dosdevices"
rm ./*
ln -s "$REPERTOIRE/wineprefix/SimCity4/drive_c" "c:"
ln -s "$CDROM" "d:"
ln -s "/" "z:"
 
mkdir "$REPERTOIRE/wineprefix/SimCity4/temp"
cd "$REPERTOIRE/wineprefix/SimCity4/temp"
mkdir sc4setup
 
POL_SetupWindow_wait_next_signal "$LNG_SC4_WAIT" "SimCity 4"
cp -vR $CDROM/* ./sc4setup/
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_SC4_CD2"
 
cd "$REPERTOIRE/wineprefix/SimCity4/temp"
mkdir sc4setup2
POL_SetupWindow_wait_next_signal "$LNG_SC4_WAIT" "SimCity 4"
cp -vR $CDROM/* ./sc4setup2/
chmod -R 777 "$REPERTOIRE/wineprefix/SimCity4/temp"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_SC4_REMCD2"

POL_SetupWindow_message "$LNG_SC4_CD1"
 
cd sc4setup
 
wine setup.exe
POL_SetupWindow_message "$LNG_SC4_CHANGE"
cd "$REPERTOIRE/wineprefix/SimCity4/temp"
mv sc4setup sc4setup1
mv sc4setup2 sc4setup
POL_SetupWindow_message "$LNG_SC4_CONTINUE"
 
#Fixed Graphics Rules issue
 
cd "$REPERTOIRE/wineprefix/SimCity4/drive_c/Program Files/Maxis/SimCity 4"
cp "Graphics Rules.sgr" "Graphics Rules.backup"
 
### Download and update installation ###
 
cd "$REPERTOIRE/wineprefix/SimCity4/temp"
 
POL_SetupWindow_menu "$LNG_SC4_WHERE" "" "Europe/South and Central America/Africa/Russia/Mexico~North America/South Africa/India/Pakistan/Australia/New Zealand~Korea/Thailand/Tawain/Hong Kong~China~Japan" "~"
COUNTRY="$APP_ANSWER"
if [ "$COUNTRY" == "Europe/South and Central America/Africa/Russia/Mexico" ]
then
 
POL_SetupWindow_download "$LNG_SC4PATCH_DL" "SimCity 4" "http://simcity.ea.com/update/exe/R1/UPDATE-SKU2-TO-P2.EXE"
POL_SetupWindow_wait_next_signal "Installing update" "SimCity 4"
wine UPDATE-SKU2-TO-P2.EXE
POL_SetupWindow_detect_exit
POL_SetupWindow_message "SimCity 4 updated."
fi
 
if [ "$COUNTRY" == "North America/South Africa/India/Pakistan/Australia/New Zealand" ]
then
 
POL_SetupWindow_download "$LNG_SC4PATCH_DL" "SimCity 4" "http://simcity.ea.com/update/exe/R1/UPDATE-SKU1-TO-P2.EXE"
POL_SetupWindow_wait_next_signal "Installing update" "SimCity 4"
wine UPDATE-SKU1-TO-P2.EXE
POL_SetupWindow_detect_exit
POL_SetupWindow_message "SimCity 4 updated."
 
fi
 
if [ "$COUNTRY" == "Korea/Thailand/Tawain/Hong Kong" ]
then
 
POL_SetupWindow_download "$LNG_SC4PATCH_DL" "SimCity 4" "http://simcity.ea.com/update/exe/R1/UPDATE-SKU3-TO-P2.EXE"
POL_SetupWindow_wait_next_signal "Installing update" "SimCity 4"
wine UPDATE-SKU3-TO-P2.EXE
POL_SetupWindow_detect_exit
POL_SetupWindow_message "SimCity 4 updated."
 
fi
 
if [ "$COUNTRY" == "China" ]
then
 
POL_SetupWindow_download "$LNG_SC4PATCH_DL" "SimCity 4" "http://simcity.ea.com/update/exe/R1/UPDATE-SKU4-TO-P2.EXE"
POL_SetupWindow_wait_next_signal "Installing update" "SimCity 4"
wine UPDATE-SKU4-TO-P2.EXE
POL_SetupWindow_detect_exit
POL_SetupWindow_message "SimCity 4 updated."
 
fi
 
if [ "$COUNTRY" == "Japan" ]
then
 
POL_SetupWindow_download "$LNG_SC4PATCH_DL" "SimCity 4" "http://simcity.ea.com/update/exe/R1/UPDATE-SKU5-TO-P2.EXE"
POL_SetupWindow_wait_next_signal "Installing update" "SimCity 4"
wine UPDATE-SKU5-TO-P2.EXE
POL_SetupWindow_detect_exit
POL_SetupWindow_message "SimCity 4 updated."
 
fi
 
### END of download and update installation ###
 
cd "$REPERTOIRE/wineprefix/SimCity 4/drive_c/Program Files/Maxis/SimCity 4"
cp "Graphics Rules.sgr" "Graphics Rules.new"
cp "Graphics Rules.backup" "Graphics Rules.sgr"
 
#End of the game code

#Launcher creation
 
POL_SetupWindow_make_shortcut "SimCity4" "Program Files/Maxis/SimCity 4/Apps/" "SimCity 4.exe" "simcity4.xpm" "SimCity 4" "" "-d:software"
Set_WineVersion_Assign "1.1.0" "SimCity 4"
Set_Desktop Off
 
POL_SetupWindow_reboot
rm -rf "$REPERTOIRE/wineprefix/SimCity4/temp"
POL_SetupWindow_message "$LNG_SC4_FIN"

POL_SetupWindow_message "$LNG_SC4_CRACK"
POL_SetupWindow_message "$LNG_SC4_RUN"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXxlJagAKCRDlMfrJqhPK
R01zAJ9ISACrXMaRkX80CWTold9PRttiYwCeIRr6aRc64pYNmUCjJ9wkg8olcqA=
=gR97
-----END PGP SIGNATURE-----
