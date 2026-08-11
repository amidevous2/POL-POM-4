#!/bin/bash
# Date : (2011-02-01 21-20)
# Last revision : (2011-02-01 21-20)
# Wine version used : 1.3.12
# Distribution used to test : Ubuntu 10.10
# Author : thib25
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="BMW M3 Challenge"
PREFIX="BMW_M3_Challenge"
WORKING_WINE_VERSION="1.3.12"

URL="http://origin.bmw.com/_common/visualizer/data/experience/m3_challenge/BMW_M3_Challenge.zip?download=true"

if [ "$POL_LANG" == "fr" ]; then
LNG_ABOUT="Ce jeu est gratuit et va être téléchargé par Playonlinux (environ 350 Mo).\nCela va durer un certain temps.\n\nVous pouvez, si vous disposez déjà du fichier, choisir d'installer le jeu avec ce fichier."
LNG_CHOOSE_MEDIA="Quelle souhaitez-vous faire?"
LNG_DOWNLOAD="Télécharger automatiquement le fichier"
LNG_CHOOSE="Choisir le fichier"
LNG_CHOOSE_QUESTION="Veuillez selectionner votre executable de $TITLE"
LNG_DOWNLOAD_PROGRESS="Téléchargement en cours..."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?\n(minimum pour ce jeu : 64)" 
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 64Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_ABOUT="This game is free et is going to be downloaded by Playonlinux (around 350 Mo).\nThis may take some time.\n\nYou can, if you already have the file, choose to install the game with this file."
LNG_CHOOSE_MEDIA="What version do you have?"
LNG_DOWNLOAD="Download automatically the file"
LNG_CHOOSE="Select the file"
LNG_CHOOSE_QUESTION="Please select your $TITLE executable"
LNG_DOWNLOAD_PROGRESS="Download in progress..."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory does your graphics board have?\n(minimum for this game : 64)" 
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 64Mo of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi

#starting the script
cd $REPERTOIRE/tmp
rm *.jpg
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "10Tacle" "http://www.bmw.com/com/en/newvehicles/mseries/m3coupe/2007/experience/game/content.html" "thib25" "$PREFIX"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_SetupWindow_message "$LNG_ABOUT" "$TITLE"

#Choose to download the file or select it
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "Actions" "$LNG_DOWNLOAD~$LNG_CHOOSE" "~"
 
if [ "$APP_ANSWER" == "$LNG_DOWNLOAD" ]; then
	GAME_MEDIAVERSION="DOWNLOAD"	
else
	GAME_MEDIAVERSION="SELECT"
fi

#downloading specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
	POL_Call POL_Install_wine64b
else
	POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
fi
Use_WineVersion "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES

if [ "$GAME_MEDIAVERSION" == "DOWNLOAD" ]; then
cd  $REPERTOIRE/tmp/
POL_SetupWindow_download "$LNG_DOWNLOAD_PROGRESS" "$TITLE" "$URL"
unzip BMW_M3_Challenge.zip -d $REPERTOIRE/tmp/
wine "BMW_M3_Challenge.exe"
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
rm *.zip
rm *.exe
else
#Asking for selecting the file
cd $HOME
POL_SetupWindow_browse "$LNG_CHOOSE_QUESTION" "$TITLE"
SETUP_EXE="$APP_ANSWER"
wine "$SETUP_EXE"
POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
fi

#asking about memory size of graphic card
POL_SetupWindow_menu_list "$LNG_GAME_VMS" "$TITLE" "128-256-320-384-512-640-768-896-1024-1792-2048" "-" "64"
VMS="$APP_ANSWER"
 
cd "$WINEPREFIX/drive_c/windows/temp/"
echo "[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]" > vms.reg
echo "\"VideoMemorySize\"=\"$VMS\"" >> vms.reg
regedit vms.reg
if [ "$VMS" -lt "64" ]; then
POL_SetupWindow_message "$LNG_VMS_ERROR" "$TITLE"
fi

#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "BMW.exe" "$TITLE" "" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJGAACgkQ5TH6yaoTykdD1ACeOhIjnxTbaQghtmYTf5vkdAFY
JR0An15qNSVhgmTBjyJ6O9eAjAKJ7YaX
=BAAi
-----END PGP SIGNATURE-----
