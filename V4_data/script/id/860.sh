#!/bin/bash
# Date : (2011-07-07 21-00)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2011-07-07 21-00)
#   First script.
# [Dadu042] (2019-12-21). Not tested because my laptop can't read the disc.
#   Wine v1.2.3 -> 3.0.3:
#   Standardize VMS setup.
#   Standardize shortcut.
#   Standardize cleaning temp.
#   Add POL_RequiredVersion 4.2.12

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Legacy of Kain : Soul Reaver 2"
PREFIX="SoulReaver2"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="128"
SOFTWARE_CATEGORIES="Game;ActionGame;"
  
if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_DVD="Version DVD"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="La taille de votre mémoire graphique?"
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de\n512Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="Which version do you have?"
LNG_DVD="DVD Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Forward\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory do your graphic card have got?"
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than\n512Mb of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi
  
# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/soulreaver2/top.jpg" "http://files.playonlinux.com/resources/setups/soulreaver2/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages
  
POL_SetupWindow_presentation "$TITLE" "Crystal Dynamics" "http://www.crystald.com/" "GNU_Raziel" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"
  
#downloading specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
        POL_Call POL_Install_wine64b
else
        POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
fi
Use_WineVersion "$WORKING_WINE_VERSION"
 
#Creating prefix 
POL_SetupWindow_prefixcreate
 
# Choose between DVD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_DVD~$LNG_DDV" "~"
  
if [ "$APP_ANSWER" == "$LNG_DVD" ]; then
        GAME_MEDIAVERSION="DVD"
else
        GAME_MEDIAVERSION="DDV (HDD)"
fi
 
# Installing mandatory dependencies (To fix some sound issues and for Joystick support), 2011 (Wine 1.2.3).
POL_Call POL_Install_dxfullsetup

  
################
#      GPU     #
################
  
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
  
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx


 
if [ "$GAME_MEDIAVERSION" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$LNG_INSERT_MEDIA"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "sr2.exe"
        cd "$WINEPREFIX"/dosdevices
        ln -s "$CDROM" d:
        wine start /unix "$CDROM/autorun.exe"
        POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$LNG_CHOOSE_DDV" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
        wine start /unix "$SETUP_EXE"
        INSTALL_ON="1"
        until [ "$INSTALL_ON" == "" ]; do
        sleep 5
        INSTALL_ON=`ps aux | grep "wineserver" | grep -v "grep"`
        done
        POL_SetupWindow_detect_exit
fi

 
## Fix for this game
# Sound problem fix - pulseaudio related
POL_Call POL_Function_OverrideDLL "" "mmdevapi"
[ "$PLAYONMAC" == "" ] && Set_SoundDriver "alsa"
[ "$PLAYONMAC" == "" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## Begin Common PlayOnMac Section ##
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"
## End Section ##
  
POL_System_TmpDelete
  
# Making shortcut
POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXf53RAAKCRDlMfrJqhPK
R+/OAJ4vjhwAJN3VqXGsMQiUIuA/9DPxHACfeCCljc/XpC1ATMj4kc/XbHFSY7o=
=ZDXi
-----END PGP SIGNATURE-----
