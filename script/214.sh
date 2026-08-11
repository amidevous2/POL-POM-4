#!/bin/bash
# Date : (2009-06-15 15-00)
# Last revision : (2009-06-15 15-00)
# Wine version used : N/A 
# Distribution used to test : N/A
# Author : NSLW
# Licence : Free
 
# CHANGELOG
# [NSLW] (2009-06-15 15-00)
#   #Translated from V2 to V3
# [Dadu042] (2019-06-03 12-37)
#   Fix download link (broken).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#Presentation
POL_SetupWindow_Init
POL_SetupWindow_presentation "Tunneler" "" "" "puk007 and NSLW" "Tunneler"
 
select_prefix "$REPERTOIRE/wineprefix/Tunneler/"
 
dosprefixcreate
 
cd $WINEPREFIX/drive_c/
 
POL_SetupWindow_download "Téléchargement du jeu" "Tunneler" "http://tunneler.org/files/tunneler.zip"
 
rm -rf Tunneler
unzip tunneler.zip
rm tunneler.zip
 
export $CDROM="none"
 
creer_lanceur_dos "Tunneler" "Tunneler/" "TUNNELER.COM" "" "Tunneler"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXPUM2AAKCRDlMfrJqhPK
R7tRAJ9X4cTTnJysj7d88Dph5EhyHo3cjgCdHsmbYJJEQ57irGKCHi/As1SxXd8=
=sQPU
-----END PGP SIGNATURE-----
