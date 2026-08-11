#!/bin/bash
# Date: (2009-07-20 12-31)
# Distribution used to test: Ubuntu Jaunty
# Wine version used: 1.1.25
# Author: Berillions
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
Title="BloodBowl"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera
terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL="Quelle version avez-vous?"
else
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation
is finished or you will have to redo the installation.."
LNG_INSTALL="What version have you got?"
fi
 
cd $REPERTOIRE/tmp
rm *.jpg
POL_SetupWindow_Init
 
#Presentation
POL_SetupWindow_presentation "BloodBowl" "Cyanide Studios" "http://www.bloodbowl-game.com/" "Berillions" "BloodBowl"
 
#Installation de Wine
POL_SetupWindow_install_wine "1.1.37"
 
#Préparation de Wine
select_prefixe "$REPERTOIRE/wineprefix/BloodBowl"
 
#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3} 

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#Install Directx9 & dotnet20
POL_Call POL_Install_d3dx9
POL_Call POL_Install_dotnet20

#Taille de la mémoire graphique
POL_SetupWindow_menu_list "Your Memory Graphic" "$Title" "32 64 128 256 384 512 768 1024 2048" " "
VMS="$APP_ANSWER"
 
#Réglage DirectDrawRenderer
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > OGL.reg
echo "\"UseGLSL\"=\"enabled\"" >> OGL.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> OGL.reg
regedit OGL.reg
 
#Configuration de Wine
Set_OS winxp
 
POL_SetupWindow_menu "$LNG_INSTALL" "Actions" "Downloadable version~DVD version" "~"
 
if [ "$APP_ANSWER" == "DVD version" ]; then
#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe" 

POL_SetupWindow_wait_next_signal "Installing ..." "$Title"
wine $CDROM/Setup.exe
POL_SetupWindow_detect_exit

POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
 
elif [ "$APP_ANSWER" == "Downloadable version" ]
then
#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "SetupBloodBowl_edsr_efgis.exe" 
 
wine $CDROM/SetupBloodBowl_edsr_efgis.exe
 
POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
fi

#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi
 
convert "$HOME/.local/share/icons/*_unins000.0.xpm" -geometry 32x32 "$REPERTOIRE/icones/32/$Title"
 
#Création Launcher 
POL_SetupWindow_make_shortcut "BloodBowl" "$PROGRAMFILES/Cyanide/Blood Bowl/" "BB.exe" "" "BloodBowl"
 
Set_WineVersion_Assign "1.1.37" "BloodBowl"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFIACgkQ5TH6yaoTykcHuwCcC5nfR7r+anLUTmzI/kGQCPKr
rVEAoIqjTCtH5H5c+vM5Wnaj3E+2z1p/
=HTet
-----END PGP SIGNATURE-----
