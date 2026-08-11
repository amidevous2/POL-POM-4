#!/bin/bash
# Date: (2010-08-13)
# Distribution used to test: Debian Sid 32Bits
# Wine version used: 1.3.0
# Author: Berillions
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
Title="Call Of Duty : Modern Warfare 2"
Prefix="COD:MW2"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera
terminée sous peine de devoir recommencer l'installation."
LNG_CHANGE_DVD="Appuyez sur \"Suivant\" lorsque l'installation demande d'insérer le second DVD."
else
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation
is finished or you will have to redo the installation.."
LNG_CHANGE_DVD="Click on \"Next\" when the installation ask you to insert the Second DVD."
fi
 
POL_SetupWindow_Init
 
#Presentation
POL_SetupWindow_presentation "$Title" "	Infinity Ward" "http://www.modernwarfare2.com/" "Berillions" "$Prefix"
 
#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe" 
 
#Wine Installation
POL_SetupWindow_install_wine "1.3.0"
 
#Préparation du prefix
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
POL_SetupWindow_prefixcreate

#Ajout du CDROM à Winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" d:

cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > cdrom.reg
echo "\"d:\"=\"cdrom\"" >> cdrom.reg
regedit cdrom.reg
 
#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

#Installation corefonts and Directx9
POL_Call POL_Install_d3dx9
POL_Call POL_Install_d3dx10
POL_Call POL_Install_vcrun2005
fonts_to_prefix
 
#Taille de la mémoire graphique
POL_SetupWindow_menu_list "Your Memory Graphic" "$Title" "32 64 128 256 384 512 768 896 1024 2048" " "
VMS="$APP_ANSWER"
 
#Réglage Direct3D
cd "$WINEPREFIX/drive_c/windows/temp"
cat << EOF > OGL.reg
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"VideoMemorySize"="$VMS"
EOF
regedit OGL.reg
 
POL_SetupWindow_wait_next_signal "Installing ..." "$Title"
wine start /unix "$CDROM/Setup.exe"

POL_SetupWindow_message "$LNG_CHANGE_DVD" "$Title"
wine eject d:

POL_SetupWindow_message "$LNG_WAIT_END" "$Title"

#Création Icone
cd "$REPERTOIRE/tmp"
convert "$REPERTOIRE/tmp/mw2.png" -geometry 32x32 "$REPERTOIRE/icones/32/$Title"
 
#Création Launcher 
POL_SetupWindow_make_shortcut "$Prefix" "$PROGRAMFILES/Steam" "Steam.exe" "" "$Title"
 
Set_WineVersion_Assign "1.3.0" "$Title"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFwACgkQ5TH6yaoTykdqQQCePqVQUuKD3OSDYnOrInCSxQim
Fq0AoLBYoqcwNgqKl5J4vkyj0ZeH2j9m
=vNGX
-----END PGP SIGNATURE-----
