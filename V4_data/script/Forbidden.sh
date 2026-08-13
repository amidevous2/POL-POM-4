#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
 
cfg_check
 
#Presentation
POL_SetupWindow_Init
POL_SetupWindow_presentation "Forbidden.exe (free)" "Kloonigames" "http://www.kloonigames.com/blog/games/forbidden_exe" "Twinoatl" "Forbidden"
 
mkdir -p $REPERTOIRE/wineprefix/Forbidden
 
TEMP="$HOME/.PlayOnLinux/tmp/Forbidden"
chmod 777 $TEMP -R
rm $TEMP -R
mkdir -p $TEMP
cd $REPERTOIRE/wineprefix/Forbidden
 
select_prefixe "$(pwd)"
POL_SetupWindow_prefixcreate 
Set_SoundDriver esd
cd $WINEPREFIX/dosdevices
rm ./*
ln -s ../drive_c c:
ln -s / z:
ln -s $TEMP d:
 
cd $TEMP
POL_SetupWindow_download "Téléchargement du jeu..." "Installation" "http://www.kloonigames.com/download.php?file=forbidden.zip"
POL_SetupWindow_download "Téléchargement de MSVCP60.dll" "Installation" "http://www.dllbank.com/zip/m/msvcp60.dll.zip"
mv download.php forbidden.zip # compatibilité avec le script de zoloom
 
mkdir -p $WINEPREFIX/drive_c/
cd $WINEPREFIX/drive_c/
 
unzip $TEMP/forbidden.zip
 
cd $WINEPREFIX/drive_c/forbidden
unzip "$TEMP/msvcp60.dll.zip"
 
chmod 777 $TEMP -R
rm $TEMP -R
cd $WINEPREFIX/dosdevices
rm ./d:
 
# POL_SetupWindow_make_shortcut "Forbidden" "forbidden" "forbidden.exe" "" "Forbidden.exe"
POL_Shortcut "forbidden.exe" "$TITLE" "" "Game;AdventureGame;"
POL_SetupWindow_message "Forbidden has been installed successfully" "Installation finished"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOb+LQAKCRDlMfrJqhPK
RwvFAJ0eDgFMCxQ+7OGAcT9v1MqeToleAwCgoYUi1d0JhpuXCibqCd+MQxfKw6o=
=HtpP
-----END PGP SIGNATURE-----
