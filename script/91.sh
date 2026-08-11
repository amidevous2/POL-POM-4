#!/bin/bash

# CHANFELOG
# Twinoatl (2009-12-02)
#   First script
# Dadu042 (2019-10-30)
#   Fix for POL 4.2.12
# Dadu042 (2020-02-07)
#  Fix POL_Shortcut categories.

#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
source "$PLAYONLINUX/lib/sources"

Title="Cacodemons barbecue party in hell"
Prefix="Cacodemon"

POL_SetupWindow_Init 

#Presentation
POL_SetupWindow_presentation "$Title" "Kloonigames" "http://www.kloonigames.com/blog/games/cacodemon" "Twinoatl" "$Prefix"
 
#Préparation du prefix
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
POL_SetupWindow_prefixcreate

Set_SoundDriver esd
 
cd "$REPERTOIRE/ressources"
POL_SetupWindow_download "Téléchargement du jeu..." "$Title" "http://www.kloonigames.com/download.php?file=cacodemon.zip" ""
POL_SetupWindow_download "Téléchargement de MSVCP60.dll" "$Title" "http://www.dllbank.com/zip/m/msvcp60.dll.zip" ""

# compatibilité avec le script de zoloom
mv download.php cacodemon.zip
 
cd "$WINEPREFIX/drive_c/"
unzip "$REPERTOIRE/ressources/cacodemon.zip"
 
cd "$WINEPREFIX/drive_c/cacodemon"
unzip "$REPERTOIRE/ressources/msvcp60.dll.zip"
 
# POL_SetupWindow_make_shortcut "$Prefix" "cacodemon" "cacodemon.exe" "" "$Title"
POL_Shortcut "cacodemon.exe" "Cacodemon" "" "" "Game;ActionGame;"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXj0NngAKCRDlMfrJqhPK
RyycAJ90SDOvgO44ZkrYMneakpo3nq51bACfdll2GW1Gq/B48YHK8exsMjxzhjo=
=8mJS
-----END PGP SIGNATURE-----
