#!/bin/bash
# Date : (2009-06-14 20-00)
# Last revision : (2009-06-14 20-00)
# Wine version used : N/A 
# Distribution used to test : N/A
# Author : NSLW
# Licence : Retail

#Translated from V2 to V3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources" 

#fetching PROGRAMFILES environmental variable
#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

if [ "$POL_LANG" == "fr_FR.UTF-8" ]; then
LNG_HANDD_DL="Acquisition du jeu complet...    (légalement)"
LNG_HANDD_WARNING_TITRE="Répertoire d'installation"
LNG_HANDD_WARNING="L'installation du jeu va commencer. Ne changez pas le chemin d'installation par défaut! Si vous choisissez un répertoire différent, les raccourcis ne fonctionneront pas."
LNG_HANDD_WARNING_BOUTON="Compris!"
LNG_HANDD_WARNING_TITRE2="Serveur de son OSS"
LNG_HANDD_WARNING2="Si votre ordinateur possède plusieurs cartes son, essayez de brancher vos haut-parleurs sur chacune d'entre elles. En effet, le serveur de son utilisé n'est pas celui habituel."
LNG_HANDD_WARNING_BOUTON2="Compris!"
RACCOURCI_EDITEUR="Hidden and Dangerous Deluxe : Editeur"
else
LNG_HANDD_DL="Getting the full game...    (legally)"
LNG_HANDD_WARNING_TITRE="Installation directory"
LNG_HANDD_WARNING="The game is going to set up on your computer. Don't change the default installation directory! Otherwise the shortcuts won't work."
LNG_HANDD_WARNING_BOUTON="Understood!"
LNG_HANDD_WARNING_TITRE2="OSS sound server"
LNG_HANDD_WARNING2="If your computer has several sound cards, try plugging your speakers on each of them because the sound server used isn't the usual one."
LNG_HANDD_WARNING_BOUTON2="Understood!"
RACCOURCI_EDITEUR="Hidden and Dangerous Deluxe : Editor"
fi

TITLE="Hidden and Dangerous Deluxe"
PREFIX="HandD"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Illusion Softworks" "http://www.illusionsoftworks.com/games/" "Bugage and NSLW" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

cd "$WINEPREFIX/drive_c/windows/temp"
POL_SetupWindow_download "$LNG_HANDD_DL" "$TITLE" "http://mirrors-av.club-internet.fr/pub/games/nofrag/hiddenanddangerous/hddeluxe.exe"

POL_SetupWindow_message "$LNG_HANDD_WARNING" "$LNG_HANDD_WARNING_TITRE" "/usr/share/playonlinux/themes/tango/warning.png"

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
wine hddeluxe.exe
POL_SetupWindow_detect_exit
rm hddeluxe.exe
Set_SoundDriver "oss"

POL_SetupWindow_message "$LNG_HANDD_WARNING2" "$LNG_HANDD_WARNING_TITRE2" "/usr/share/playonlinux/themes/tango/warning.png"

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Take2/Hidden and Dangerous Deluxe/bin" "hde.exe" "$REPERTOIRE/wineprefix/HandD/drive_c/windows/temp/113b_hde.0.xpm" "$TITLE" "" ""

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Take2/Hidden and Dangerous Deluxe/bin" "iconfig.exe" "$REPERTOIRE/wineprefix/HandD/drive_c/windows/temp/113b_hde.0.xpm" "$TITLE : Configuration" "" ""

if [ -f "$REPERTOIRE/wineprefix/HandD/drive_c/Program Files/Take2/Hidden and Dangerous Deluxe/bin/hdedit.exe" ]
then
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Take2/Hidden and Dangerous Deluxe/bin" "hdedit.exe" "$REPERTOIRE/wineprefix/HandD/drive_c/windows/temp/3550_shell32.0.xpm" "$RACCOURCI_EDITEUR" "" ""
fi

POL_SetupWindow_message "$TITLE has been installed successfully" "$TITLE"
POL_SetupWindow_Close
exit

#presentation "Hidden and Dangerous Deluxe" "Illusion Softworks" "http://www.illusionsoftworks.com/games/" "Bugage" "HandD" 1 5
#telecharger "$LNG_HANDD_DL" "http://mirrors-av.club-internet.fr/pub/games/nofrag/hiddenanddangerous/hddeluxe.exe" "" 2 5 1 "" 0 0
#select_prefixe "$REPERTOIRE/wineprefix/HandD"
#creer_prefixe 3 5
#warning "$LNG_HANDD_WARNING" "$LNG_HANDD_WARNING_TITRE" 4 5 0 "" "$LNG_HANDD_WARNING_BOUTON"
#wine hddeluxe.exe
#rm hddeluxe.exe
#Set_SoundDriver "oss"
#warning "$LNG_HANDD_WARNING2" "$LNG_HANDD_WARNING_TITRE2" 5 5 0 "" "$LNG_HANDD_WARNING_BOUTON2"
#creer_lanceur "HandD" "Program Files/Take2/Hidden and Dangerous Deluxe/bin" "hde.exe" "$REPERTOIRE/wineprefix/HandD/drive_c/windows/temp/113b_hde.0.xpm" "Hidden & Dangerous Deluxe"
#creer_lanceur "HandD" "Program Files/Take2/Hidden and Dangerous Deluxe/bin" "iconfig.exe" "$REPERTOIRE/wineprefix/HandD/drive_c/windows/temp/113b_iconfig.0.xpm" "Hidden & Dangerous Deluxe : Configuration"
#if [ -f "$REPERTOIRE/wineprefix/HandD/drive_c/Program Files/Take2/Hidden and Dangerous Deluxe/bin/hdedit.exe" ]
#then
#creer_lanceur "HandD" "Program Files/Take2/Hidden and Dangerous Deluxe/bin" "hdedit.exe" "$REPERTOIRE/wineprefix/HandD/drive_c/windows/temp/3550_shell32.0.xpm" "$RACCOURCI_EDITEUR"
#fi
#exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEYACgkQ5TH6yaoTykcOYwCgjB/WjA6qZq29R6M/7zSp+fB+
X1gAnRTaXE5xpbN7ZxCDLcDOQ3XAVM3q
=/EL3
-----END PGP SIGNATURE-----
