#!/bin/bash
# Last Revision : (2009-12-02)

#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
source "$PLAYONLINUX/lib/sources"
 
#Declaration des variables
CODENAME="BestOnePoker"
REALNAME="Best One Poker"
EDITEUR="BestOnePoker"
WEBSITE="http://www.bestonepoker.com"
SCRIPTEUR="Tr4sK"

if [ "$POL_LANG" == "fr" ]; then
LNG_DL="Veuillez patienter pendant le téléchargement du client Best One Poker"
LNG_MESS="Téléchargement terminé.\nAppuyez sur suivant, puis patientez le temps de préparer l'installation"
else
LNG_DL="Waiting please. PlayOnLinux download Best One Poker Client"
LNG_MESS="Download complete. Click on Next and wait durong the installation"
fi

POL_SetupWindow_Init 

#Presentation
POL_SetupWindow_presentation "$REALNAME" "$EDITEUR" "$WEBSITE" "$SCRIPTEUR" "$CODENAME"
 
#Préparation du prefix
select_prefix "$REPERTOIRE/wineprefix/$CODENAME"
POL_SetupWindow_prefixcreate
 
#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}
 
cd "$REPERTOIRE/ressources"
POL_SetupWindow_download "$LNG_DL" "$REALNAME" "http://download.b2bpoker.com/client/bestonepoker/bestonepokersetup.exe"
 
POL_SetupWindow_message "$LNG_MESS" "$REALNAME"
 
POL_SetupWindow_wait_next_signal "Installing ..." "$Title"
wine "./bestonepokersetup.exe"
 
#Fin du code du jeu
#Création du lanceur
 
POL_SetupWindow_make_shortcut "$CODENAME" "$PROGRAMFILES/B2BPOKER/Bestonepoker/" "Client.exe" "" "$REALNAME"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEAACgkQ5TH6yaoTykdqUwCfej9tzghHrHQRgr0Pyr2R+lpO
gjAAn3TED9ljid36OKZ2wx5luxSzjBKN
=S+9m
-----END PGP SIGNATURE-----
