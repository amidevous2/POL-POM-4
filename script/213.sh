#!/bin/bash
# Date : (2009-05-23 11-00)
# Last revision : (2009-11-30)
# Wine version used : N/A 
# Distribution used to test : N/A
# Author : NSLW
# Maintener : Berillions
# Licence : Retail

#Translated from V2 to V3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

TITLE="Zoo Tycoon 2"
PREFIX="ZT2" 

wget http://upload.wikimedia.org/wikipedia/en/thumb/0/06/Zoo_Tycoon_2_Coverart.png/256px-Zoo_Tycoon_2_Coverart.png --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$TITLE" "Microsoft Games" "http://www.microsoft.com/games/pc/zootycoon2.aspx" "Chriswill and NSLW" "$PREFIX" 
 
if [ "$POL_LANG" == "fr_FR.UTF-8" ]; then
LNG_ZT2_WELCOME="le script va maintenant télécharger un fichier dll afin que le jeu fonctionne correctement."
LNG_MFC42_DL="Téléchargement de MFC42.dll...."
LNG_ZT2_BECAREFUL=" Veuillez attendre la fin de la procédure de PlayOnLinux avant de lancer le jeu."
LNG_ZT2_END=" Fin de l'installation de Zoo Tycoon 2 par PlayOnLInux - Vous n'avez besoin d'aucun executable nocd avec ce jeu "
else
LNG_ZT2_WELCOME="This script will now download a dll file for this game."
LNG_GDI_DL="Downloading MFC42.dll...."
LNG_ZT2_BECAREFUL=" You have to wait after the end of PlayOnLinux's procedure before to start the game."
LNG_ZT2_END=" End of Zoo Tycoon 2 installation by PlayOnLinux - You don't need any nocd executable with this game "
fi 
 
#Préparation de Wine
#mkdir -p $REPERTOIRE/wineprefix/ZT2
#select_prefixe "$REPERTOIRE/wineprefix/ZT2"
#creer_prefixe 2 7

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

#message "$LNG_ZT2_WELCOME" "" 3 7
POL_SetupWindow_message "$LNG_ZT2_WELCOME" "$TITLE"
 
cd $REPERTOIRE/tmp/
if [ ! -e $REPERTOIRE/tmp/mfc42.dll.zip ]; then
#telecharger "$LNG_MFC42_DL" http://www.dllbank.com/zip/m/mfc42.dll.zip "" 4 7

POL_SetupWindow_download "$LNG_MFC42_DL" "$TYTUL" "http://www.dllbank.com/zip/m/mfc42.dll.zip"
fi
 
cd $REPERTOIRE/tmp/
unzip mfc42.dll.zip -d $REPERTOIRE/wineprefix/ZT2/drive_c/windows/system32/
 
 
#Détection du cd-rom
#Ask_For_cdrom 5 7
#Check_cdrom "install.exe"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "install.exe"
cd "$WINEPREFIX/dosdevices"
ln -s $CDROM d:
 
echo "[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]" > $REPERTOIRE/tmp/cdrom.reg
echo "\"d:\"=\"cdrom\"" >> $REPERTOIRE/tmp/cdrom.reg
regedit $REPERTOIRE/tmp/cdrom.reg
POL_SetupWindow_message "Wait 5 seconds then click next" "$TITLE"

#Avertissement
#message "$LNG_ZT2_BECAREFUL" "" 6 7

POL_SetupWindow_message "$LNG_ZT2_BECAREFUL" "$TITLE"
 
#Lancement de l'installeur
#wine $CDROM/install.exe
POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
cd $CDROM
wine "install.exe"
POL_SetupWindow_detect_exit

 
#Configuration de Wine
Set_OS winXP
Set_SoundDriver alsa
 
# la fonction simuler_reboot n'est pas nécessaire
 
#Création du lanceur
#creer_lanceur "ZT2" "/Program Files/Microsoft Games/Zoo Tycoon 2" "zt.exe" "" "Zoo Tycoon 2"

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Microsoft Games/Zoo Tycoon 2" "zt.exe" "" "$TITLE" "" ""

#Fin
#message "$LNG_ZT2_END" "" 7 7
POL_SetupWindow_message "$LNG_ZT2_END" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEQACgkQ5TH6yaoTykdMigCePSGyywThClEPfyRM5T5sMDrS
wy0AnR3V2RwXUgdUhgXAS+9ltr4Tobmz
=K3x9
-----END PGP SIGNATURE-----
