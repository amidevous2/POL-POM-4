#!/bin/bash
# Date : (2011-02-01 21-20)
# Last revision : see changelog
# Wine version used : 1.3.12, 3.0.3
# Distribution used to test : Ubuntu 18.04
# Author : thib25
# Licence : Retail

# CHANGELOG
# [thib25] (2011-02-01 21-20)
#   First script.
# [Dadu042] (2019-11-10)
#   Wine 1.3.12 -> 3.0.3
#   Standardize GAME_VMS
#   Warn about log file size.
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Volvo - The Game"
PREFIX="Volvo_Game"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
 
URL="ftp://ftp.i3d.net/SimBin/volvo_thegame_1.0_setup.exe"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_ABOUT="Ce jeu est gratuit et va être téléchargé par Playonlinux (environ 600 Mo).\nCela va durer un certain temps.\n\nVous pouvez, si vous disposez déjà du fichier, choisir d'installer le jeu avec ce fichier."
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
LNG_ABOUT="This game is free et is going to be downloaded by Playonlinux (around 600 Mo).\nThis may take some time.\n\nYou can, if you already have the file, choose to install the game with this file."
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
  
POL_SetupWindow_presentation "$TITLE" "SimBin" "http://www.simbin.se/games/volvogame.htm" "thib25" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

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
    wine "volvo_thegame_1.0_setup.exe"
    POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
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
POL_SetupWindow_VMS $GAME_VMS
   
#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "Volvo.exe" "$TITLE" "" "Game;"
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcggVQAKCRDlMfrJqhPK
R3YgAJ9zH1rbE80d5H9Z7Pm2Yemfx7XQeACgg/iSGZKnoBXcRM/4kCSR9IkGL38=
=YyU0
-----END PGP SIGNATURE-----
