#! /bin/bash
# Date: (2009-12-11 13-58)
# Distribution used to test: Ubuntu 9.10
# Wine version used: 1.1.34
# Author: CKDevelop
# Graphic Card : GeForce 8600 GT
# Drivers : 185.18.36
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
Title="Swat 4"
Prefix="Swat4"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_MEM="La taille de votre mémoire graphique? (Ex : 512)"
LNG_INSTALL="Quelle version avez-vous?"
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera
terminée sous peine de devoir recommencer l'installation."
LNG_GAME="Selectionnez le fichier d'installation"
else
LNG_MEM="How much memory do your graphic card have got? (Ex : 512)"
LNG_INSTALL="What version have you got?"
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation
is finished or you will have to redo the installation."
LNG_GAME="Select the installation file"
fi
 
cd "$REPERTOIRE/tmp"
rm *.jpg
wget http://upload.wikimedia.org/wikipedia/en/7/71/SWAT_4_Coverart.png --output-document="$REPERTOIRE/tmp/$Prefix.png"
convert "$REPERTOIRE/tmp/$Prefix.png" -scale 150x356\! "$REPERTOIRE/tmp/left.png"
 
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.png"
 
#Presentation
POL_SetupWindow_presentation "$Title" "Vivendi Universal Games and Sierra Entertainment" "http://www.swat4.com" "CKDevelop" "$Prefix"
 
#Installation de Wine
POL_SetupWindow_install_wine "1.1.34"
Use_WineVersion "1.1.34"
 
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
POL_SetupWindow_prefixcreate
 
#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}
 
#Taille de la mémoire graphique
POL_SetupWindow_menu_list "$LNG_MEM" "$Title" "32-64-128-256-384-512-768-896-1024-2048" "-" "256"
VMS="$APP_ANSWER"
 
if [ "$VMS" -lt "128" ]; then
	POL_SetupWindow_message "$LNG_VMS_ERROR" "$Title" "$PLAYONLINUX/themes/tango/warning.png"
fi
 
#Réglage DirectDrawRenderer
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > OGL.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> OGL.reg
regedit OGL.reg
 
#Configuration de Wine
Set_OS winxp
 
#Création Icone
cd "$REPERTOIRE/ressources"
convert "$CDROM/autorun.ico" -geometry 32X32 "swat4ico.png"
mv "$REPERTOIRE/ressources/swat4ico.png" "$REPERTOIRE/icones/32/$Title" 
 
POL_SetupWindow_menu "$LNG_INSTALL" "Actions" "CD version~Downloaded version" "~"
 
if [ "$APP_ANSWER" == "CD version" ]; then
#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
 
wine "$CDROM/setup.exe"
POL_SetupWindow_message "$LNG_WAIT_END" "$Title"

elif [ "$APP_ANSWER" == "Downloaded version" ] 
then
POL_SetupWindow_browse "$LNG_GAME" "$Title" ""
wine "$APP_ANSWER" 
 
POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
fi
 
POL_SetupWindow_make_shortcut "$Prefix" "$PROGRAMFILES/Sierra/SWAT 4/Content/System" "Swat4.exe" "" "$Title"
 
Set_WineVersion_Assign "1.1.34" "$Title"
 
POL_SetupWindow_message "Please note that this game has a copy protection system
and sadly, it prevents Wine from running the game.
PlayOnLinux will not provide any help concerning any illegal
stuff." "Note about copy protection" "$PLAYONLINUX/themes/tango/warning.png"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFcACgkQ5TH6yaoTykcgGgCgp3rg9IGqnu32Rv0rRV92jbtO
qzoAnj9RB64Jl8DwAH9xyigNEVBn473l
=/Ffi
-----END PGP SIGNATURE-----
