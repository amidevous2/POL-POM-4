#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# CHANGELOG
# BeberKing (200x)
#   First script.
# Dadu042 (2019-08-01)
#   Fix download URL (Previous website is closed).

cfg_check

#Message aux scripteurs : Merci de placer ce script dans la partie Dosbox support, et ça serait sympa d'y mettre aussi SimCity2000 et Duke Nukem 3D

#Presentation
presentation "Lemmings 2" "Psygnosis" "" "BBK" "Lemmings2"

if [ "$POL_LANG" == "fr_FR.UTF-8" ]; then
LNG_ZIP_DL="Téléchargement du jeu..."
LNG_INSTALL="Cliquez sur suivant et choisissez Sound Blaster, puis toutes les valeurs par défaut"
else
LNG_ZIP_DL="Downloading the game..."
LNG_INSTALL="Click on Next and then choose Sound Blaster and all default options for the sound card"
fi 

select_prefixe "$REPERTOIRE/wineprefix/Lemmings2/"
dosprefixcreate

cd $WINEPREFIX/drive_c/

telecharger "$LNG_ZIP_DL" "https://archive.org/download/FMTOWNSHACKS/Lemmings%202.zip/"
mv Lemmings%202.zip Lemmings2.zip
unzip Lemmings2.zip

cd L2

message "$LNG_INSTALL"

start_dos INSTALL.EXE

cd ..
rm Lemmings2.zip

export $CDROM="none"

creer_lanceur_dos "Lemmings2" "L2/" "L2.EXE" "" "Lemmings 2"
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbywSwAKCRDlMfrJqhPK
R3sqAJ97sN9Amefy2+ZFiFzEnXqvAipBQQCfUozxvpOznzOlJtSxDc3DlUbTLrk=
=zz8X
-----END PGP SIGNATURE-----
