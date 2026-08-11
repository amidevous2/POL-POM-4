#!/bin/bash
# Date : (2010-03-09 10-00)
# Last revision : (see changelog)
# Wine version used : 1.3.9, 1.3.23, 2.22
# Distribution used to test : Debian Testing x64
# Author : NSWL & GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [NSWL & GNU_Raziel] (2010)
#   First script.
# [Dadu042] (2019-10-03)
#   Wine 1.3.23 (2011) -> 2.22 (2017), this may help.
#   Standardize VMS.
#   Add GPU selection, SOFTWARE_CATEGORIES.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Grand Theft Auto IV"
PREFIX="GTAIV"
WORKING_WINE_VERSION="2.22"
  
if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_DVD="Version DVD"
LNG_STEAM="Version Steam Store"
LNG_DDV="Version Digital Download"
LNG_INSTALL_NOTE="Annulez la vérification de la date à la fin de\nl'installation, elle ne fonctionnera pas correctement."
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_WAIT_STEAM_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu Steam\nsera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_DL_XLIVELESS="Téléchargement de xliveless 1.0a4..."
LNG_INSTALL_XLIVELESS="Installation de xliveless 1.0a4..."
LNG_GAME_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?"
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de 256Mo de mémoire."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="Which version do you have?"
LNG_DVD="DVD Version"
LNG_STEAM="Steam Store Version"
LNG_DDV="Digital Download Version"
LNG_INSTALL_NOTE="Cancel online release date check at the end of installation\nit will not work properlly."
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Forward\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_WAIT_STEAM_END="Click on \"Forward\" ONLY when Steam game installation\nwill be finished or you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_DL_XLIVELESS="Downloading xliveless 1.0a4..."
LNG_INSTALL_XLIVELESS="Installing xliveless 1.0a4..."
LNG_GAME_VMS="How much memory does your graphics board have?"
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than 256MB of memory."
LNG_SUCCES="$TITLE has been installed successfully."
fi
  
# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "Rockstar Games" "www.rockstargames.com/IV/" "NSLW & GNU_Raziel" "$PREFIX"
  
select_prefix "$POL_USER_ROOT/wineprefix/$PREFIX"
 
# Downloading specific Wine
if [ "$MACHTYPE" == "x86_64-pc-linux-gnu" ]; then
        POL_Call POL_Install_wine64b
else
        POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
fi
Use_WineVersion "$WORKING_WINE_VERSION"
 
# Creating prefix 
POL_SetupWindow_prefixcreate
 
# Choose between DVD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "$TITLE" "$LNG_DVD~$LNG_STEAM~$LNG_DDV" "~"
  
if [ "$APP_ANSWER" == "$LNG_DVD" ]; then
        GAME_MEDIAVERSION="DVD"
elif [ "$APP_ANSWER" == "$LNG_STEAM" ]; then
        GAME_MEDIAVERSION="STEAM"
else
        GAME_MEDIAVERSION="DD"
fi
 
# Installing mandatory components
if [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
        POL_Call POL_Install_steam
else
        POL_Call POL_Install_vcrun2005
fi
POL_Call POL_Install_msxml3
POL_Call POL_Install_gfwl
POL_Call POL_Install_wmp9
POL_Call POL_Install_wmpcodecs
 
POL_SetupWindow_message "$LNG_INSTALL_NOTE"
 
if [ "$GAME_MEDIAVERSION" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$LNG_INSERT_MEDIA"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "GTAIV/setup.exe"
        wine start /unix "$CDROM/Autorun.exe"
        POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
elif [ "$GAME_MEDIAVERSION" == "STEAM" ]; then
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        wine "Steam.exe" -applaunch 12210
        POL_SetupWindow_message "$LNG_WAIT_STEAM_END" "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$LNG_CHOOSE_DDV" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
        wine start /unix "$SETUP_EXE"
        wineserver -w
        POL_SetupWindow_detect_exit
fi

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
GAME_VMS="256"
POL_SetupWindow_VMS $GAME_VMS
 
## Fix for this game
GAME_PATH=`find $WINEPREFIX -name "LaunchGTAIV.exe" | sed s/LaunchGTAIV.exe//g`
cd "$POL_USER_ROOT/ressources"
if [ ! -e "xliveless-1.0a4.zip" ]; then
    POL_SetupWindow_download "$LNG_DL_XLIVELESS" "$TITLE" "http://files.playonlinux.com/xliveless-1.0a4.zip"
fi
cd "$WINEPREFIX/drive_c/windows/temp/"
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_XLIVELESS" "$TITLE"
unzip "$POL_USER_ROOT/ressources/xliveless-1.0a4.zip"
mv xlive.dll "$GAME_PATH"
POL_SetupWindow_detect_exit
 
POL_Call POL_Function_OverrideDLL "" "mmdevapi"
 
# Sound problem fix - pulseaudio related
[ "$PLAYONMAC" == "" ] && Set_SoundDriver "alsa"
[ "$PLAYONMAC" == "" ] && Set_SoundEmulDriver "Y"
## End Fix
 
# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
        rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
        chmod -R 777 "$POL_USER_ROOT/tmp/"
        rm -rf "$POL_USER_ROOT/tmp/*"
fi
 
# Making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "LaunchGTAIV.exe" "$TITLE" "" "" "Game;ActionGame;"
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
  
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXZXPnQAKCRDlMfrJqhPK
R14XAKCK9JCdzvwVcePRZNjsB0P8n+9V6ACeKOmunfSLnzVWzsTpcveUIJnbN1s=
=KBId
-----END PGP SIGNATURE-----
