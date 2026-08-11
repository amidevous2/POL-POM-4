#!/bin/bash
# Date : (2010-08-01)
# Last revision : (2010-08-08)
# Distribution used to test : ArchLinux
# Author : Valentin PERRUSSEL
# Licence : GPLv3
# PlayOnLinux: 3.7.6
# WineHQ: 1.1.42
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Langues
if [ "$POL_LANG" == "fr" ]; then
LNG_WARNING="Le jeu requiert un crack NO CD pour fonctionner. \nNi PlayOnLinux, ni l'auteur de ce script ne sont responsables de vos agissements."
LNG_WARNING_TITLE="Avertissement"
LNG_INSERT_CD1="Veuillez insérer le CD 1 d'Industry Giant II - Gold Edition."
LNG_INSERT_CD1_TITLE="Inserez CD 1"
LNG_COPY="Veuillez attendre que PlayOnLinux finisse de copier les fichiers du jeu...\nCette opération peut prendre plusieurs minutes."
LNG_COPY_TITLE="Copie en cours"
LNG_INSERT_CD2="Veuillez insérer le CD 2 d'Industry Giant II - Gold Edition."
LNG_INSERT_CD2_TITLE="Inserez CD 2"
LNG_COPY_SUCCESS="La copie s'est déroulée avec succès. \nCliquez sur "Suivant" afin de poursuivre l'installation. \nPensez à installer DirectX 8.1 après avoir installé le jeu.\nUne fois l'installation terminée, veuillez quitter la fenêtre d'installation pour poursuivre la procédure d'installation autrement votre jeu ne sera pas installé !"
LNG_COPY_SUCCESS_TITLE="Installation"
LNG_INSTALL="Installation en cours, ne fermez pas la fenêtre !"
LNG_INSTALL_TITLE="Installation en cours"
LNG_CLEAN="Nettoyage des installateurs..."
LNG_CLEAN_TITLE="Nettoyage"
LNG_INSTALL_SUCCESS="Industry Giant 2 a été correctement installé !"
LNG_INSTALL_SUCCESS_TITLE="Installation réussie"

else
LNG_WARNING="The game requires a crack NO CD to run. \nPlayOnLinux and the author of this script are not responsible for your actions."
LNG_WARNING_TITLE="Warning"
LNG_INSERT_CD1="Please insert the first CD-ROM of Industry Giant II - Gold Edition."
LNG_INSERT_CD1_TITLE="Insert CD 1"
LNG_COPY="Please wait PlayOnLinux finish copying the game files .. \nThis operation can take several minutes."
LNG_COPY_TITLE="Copy Progress"
LNG_INSERT_CD2="Please insert the second CD-ROM of Industry Giant II - Gold Edition."
LNG_INSERT_CD2_TITLE="Insert CD 2"
LNG_COPY_SUCCESS="The copy was successful. \nClick "Next" to continue the setup. \nInstall DirectX 8.1after the game setup. \nA After setup, please exit the setup window to proceed with setup otherwise your game will not install !"
LNG_COPY_SUCCESS_TITLE="Installation"
LNG_INSTALL="Setup progress, do not close the window!"
LNG_INSTALL_TITLE="Setup Progress"
LNG_CLEAN="Cleaning installers..."
LNG_CLEAN_TITLE="Cleaning"
LNG_INSTALL_SUCCESS="Industry Giant 2 has been successfully installed !"
LNG_INSTALL_SUCCESS_TITLE="Installation successful"
fi
 
POL_SetupWindow_Init
 
# Présentation
POL_SetupWindow_presentation "Industry Giant II - Gold Edition" "JoWooD Productions" "ig2.jowood.com" "BlondVador" "IG2GE"
 
POL_SetupWindow_message "$LNG_WARNING" "$LNG_WARNING_TITLE"
 
# Copie des fichiers du CD1
POL_SetupWindow_message "$LNG_INSERT_CD1" "$LNG_INSERT_CD1_TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "jowood_logo.JPG"
POL_SetupWindow_wait_next_signal "$LNG_COPY" "$LNG_COPY_TITLE"
mkdir "$HOME/.PlayOnLinux/tmp/IG2GE"
cp $CDROM/* "$HOME/.PlayOnLinux/tmp/IG2GE/" -r
POL_SetupWindow_detect_exit
 
# Copie des fichiers du CD2
POL_SetupWindow_message "$LNG_INSERT_CD2" "$LNG_INSERT_CD2_TITLE"
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup4.cab"
POL_SetupWindow_wait_next_signal "$LNG_COPY" "$LNG_COPY_TITLE"
chmod 777 "$HOME/.PlayOnLinux/tmp/IG2GE" -R
cp "$CDROM/setup4.cab" "$HOME/.PlayOnLinux/tmp/IG2GE"
cp "$CDROM/Program Files/Industry Giant 2/ig2.exe" "$HOME/.PlayOnLinux/tmp/IG2GE/Program Files/Industry Giant 2"
cp "$CDROM/Program Files/Industry Giant 2/keylibdll.dll" "$HOME/.PlayOnLinux/tmp/IG2GE/Program Files/Industry Giant 2"
POL_SetupWindow_detect_exit
 
# Configuration
Set_OS "winxp"
Set_SoundDriver alsa
 
#Création du préfixe
POL_SetupWindow_prefixcreate
select_prefix "$HOME/.PlayOnLinux/wineprefix/IG2GE/"
 
# Confirmation
POL_SetupWindow_message "$LNG_COPY_SUCCESS" "$LNG_COPY_SUCCESS_TITLE"
 
# Installation
POL_SetupWindow_wait_next_signal "$LNG_INSTALL" "$LNG_INSTALL_TITLE"
wine "$HOME/.PlayOnLinux/tmp/IG2GE/autorun.exe"
POL_SetupWindow_detect_exit
 
# Création du lanceur
POL_SetupWindow_make_shortcut "IG2GE" "Program Files/Industry Giant 2" "ig2.exe" "Industry Giant II - Gold Edition"
 
# Nettoyage
POL_SetupWindow_wait_next_signal "$LNG_CLEAN" "$LNG_CLEAN_TITLE"
chmod 777 "$HOME/.PlayOnLinux/tmp/IG2GE" -R
rm -r "$HOME/.PlayOnLinux/tmp/IG2GE"
POL_SetupWindow_detect_exit
 
# Fin
POL_SetupWindow_message "$LNG_INSTALL_SUCCESS" "$LNG_INSTALL_SUCCESS_TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF8ACgkQ5TH6yaoTykctLACgr/H/X5uGsO3nkdPFi+9So1BX
EL0AnijAwhkiUDREHJ1oP/VMirpyMimO
=j8LC
-----END PGP SIGNATURE-----
