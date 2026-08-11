#!/bin/bash
# Date: (2009-10-29 13-20)
# Last revision : (2010-05-30)
# Author: Berillions
# Graphic Card : GeForce GTX275
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
Title="Football Manager 2010"
Prefix="FM10"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_MEM="La taille de votre mémoire graphique? (Ex : 512)"
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu sera\n terminée sous peine de devoir recommencer l'installation."
LNG_INST="Utilisez obligatoirement l'installation Offline"
else
LNG_MEM="How much memory do your graphic card have got? (Ex : 512)"
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation\n is finished or you will have to redo the installation."
LNG_INST="To install correctly the game, use the offline installation"
fi
 
cd "$REPERTOIRE/tmp"
rm *.jpg
wget http://upload.wikimedia.org/wikipedia/en/2/24/FM2010cover.jpg --output-document="$REPERTOIRE/tmp/$Prefix.jpg"
convert "$REPERTOIRE/tmp/$Prefix.jpg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpg"
 
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpg"
 
#Presentation
POL_SetupWindow_presentation "$Title" "Sports Interactive" "http://www.sigames.com/" "Berillions" "$Prefix"
 
#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

POL_SetupWindow_install_wine "1.1.44"
 
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
POL_SetupWindow_prefixcreate
 
#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
 
#Install Directx9
POL_Call POL_Install_d3dx9
 
#Taille de la mémoire graphique
POL_SetupWindow_menu_list "$LNG_MEM" "$Title" "32-64-128-256-384-512-768-896-1024-2048" "-" "128"
VMS="$APP_ANSWER"
 
if [ "$VMS" -lt "128" ]; then
	POL_SetupWindow_message "$LNG_VMS_ERROR" "$Title" "$PLAYONLINUX/themes/tango/warning.png"
fi
 
#Réglage Direct3D
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > OGL.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> OGL.reg
echo "\"PixelShaderMode\"=\"disabled\"" >> OGL.reg
regedit OGL.reg
 
#Configuration de Wine
Set_OS winxp
 
POL_SetupWindow_message "$LNG_INST" "$Title"
 
wine "$CDROM/Disk1/InstData/Windows/VM/setup.exe"
 
POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
 
POL_SetupWindow_make_shortcut "$Prefix" "$PROGRAMFILES/Sports Interactive/Football Manager 2010" "fm.exe" "" "$Title"
 
convert "~/.local/share/icons/*_fm.0.png" -geometry 32X32 "$REPERTOIRE/icones/32/$Title"
 
#Réglage Direct3D
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > PS.reg
echo "\"PixelShaderMode\"=\"enabled\"" >> PS.reg
regedit PS.reg
 
Set_WineVersion_Assign "1.1.44" "$Title"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFYACgkQ5TH6yaoTykdYqQCdG43gXjVexknnyDmnpJ9XzSTg
nZcAn2m0BWE+Dz+/SkaRn5BYPrNtTvkq
=U0u/
-----END PGP SIGNATURE-----
