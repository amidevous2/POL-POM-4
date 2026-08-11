#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"


cfg_check

#Presentation

POL_SetupWindow_Init
POL_SetupWindow_presentation "Deus Ex HDTP" "Eidos Interactive" "http://fr.wikipedia.org/wiki/Deus_Ex" "bigeyes & yimm" "DeusEx_HDTP"

#Informations sur l'installation
POL_SetupWindow_message "Ce script va vous aider à installer :\n     - Deus Ex\n     - Le patch 1.4\n     - D3DDrv.dll et OpenGLDrv.dll\n     - Deus Ex HDTP Release 1 (High Definition Texture Pack)" "Deus Ex"
POL_SetupWindow_cdrom

mkdir -p $REPERTOIRE/wineprefix/DeusEx_HDTP

TEMP="$HOME/.PlayOnLinux/tmp/DeusEx_HDTP"
chmod 777 $TEMP -R
rm $TEMP -R
mkdir -p $TEMP
cd $REPERTOIRE/wineprefix/DeusEx_HDTP

select_prefixe "$(pwd)"
POL_SetupWindow_prefixcreate
Set_SoundDriver alsa
Set_DXGrab On
Set_OS winxp
cd $WINEPREFIX/dosdevices
rm ./*
ln -s ../drive_c c:
ln -s / z:
ln -s $TEMP e:
ln -s $CDROM d:
echo "[HKEY_CURRENT_USER\Software\Wine\X11 Driver]" > $REPERTOIRE/tmp/DesktopRoot.reg
echo "\"Desktop\"=\"1024x768\"" >> $REPERTOIRE/tmp/DesktopRoot.reg
regedit $REPERTOIRE/tmp/DesktopRoot.reg
rm -f $REPERTOIRE/tmp/DesktopRoot.reg 

#Installation de Deus Ex
POL_SetupWindow_wait_next_signal "L'installation de Deus Ex va débuter.\n\n\n\nNe modifiez pas le répertoire d'installation par défaut ! (C:\DeusEx)\n\nN'oubliez pas de désélectionner l'installation de DirectX !" "Deus Ex"
cd $CDROM
wine $CDROM/Setup.exe
POL_SetupWindow_detect_exit
#POL_SetupWindow_message "Appuyez sur 'Suivant' uniquement quand l'installation du jeu\nsera terminée sous peine de devoir recommencer l'installation." "Deus Ex"

#Téléchargement des fichiers nécessaires à l'installation
cd $TEMP
#POL_SetupWindow_message "PlayOnLinux va télécharger tous les fichiers nécessaires à l'installation." "Information" ""
POL_SetupWindow_download "Téléchargement du patch 1.4..." "Deus Ex" "http://ftp.eidos-france.fr/pub/fr/deus_ex/patches/DeusEx14.exe"
POL_SetupWindow_download "Téléchargement de D3DDrv.dll..." "Deus Ex" "http://ftp.eidos-france.fr/pub/fr/deus_ex/patches/D3DDrv.dll" ""
POL_SetupWindow_download "Téléchargement de Deus Ex HDTP Release 1..." "Téléchargement de HDTP-Release1.exe..." "http://www.eer.cc/stuff/HDTP-Release1.exe" ""
POL_SetupWindow_download "Téléchargement de OpenGLDrv.dll..." "Deus Ex" "http://cwdohnal.home.mindspring.com/utglr/dxglr18.zip" ""

#Décompression de l'archive ZIP
POL_SetupWindow_wait_next_signal "Extraction ..." "Deus Ex"
unzip dxglr18.zip
POL_SetupWindow_detect_exit

#Installation du patch 1.4
#POL_SetupWindow_message "Vous allez à présent installer le patch 1.4." "Information" ""
POL_SetupWindow_wait_next_signal "Installation du patch 1.4" "Deus Ex"
wine $TEMP/DeusEx14.exe
POL_SetupWindow_detect_exit
#POL_SetupWindow_message "Appuyez sur 'Suivant' UNIQUEMENT quand l'installation du patch\nsera terminée sous peine de devoir recommencer l'installation." "Attention !" ""

#Installation de D3DDrv.dll
POL_SetupWindow_wait_next_signal "Installation de D3DDrv.dll 1.0." "Deus Ex"
#POL_SetupWindow_message "Installation de D3DDrv.dll 1.0." "Information" ""
rm "$REPERTOIRE/wineprefix/DeusEx_HDTP/drive_c/DeusEx/System/D3DDrv.dll"
mv "$TEMP/D3DDrv.dll" "$REPERTOIRE/wineprefix/DeusEx_HDTP/drive_c/DeusEx/System/"
POL_SetupWindow_detect_exit

#Pré-installation de DX-HDTP
POL_SetupWindow_message "Deus Ex va être lancé une première fois pour que HDTP puisse s'installer\ncorrectement.\n\n\nDans la fenêtre du choix de périphérique de rendu,\nsélectionnez le rendu OpenGL.\n\nUne fois le jeu lancé, quittez-le immédiatement.\n\nL'installation se poursuivra alors." "Deus Ex"
POL_SetupWindow_wait_next_signal "Ouverture de Deus Ex" "Deus Ex"
wine $REPERTOIRE/wineprefix/DeusEx_HDTP/drive_c/DeusEx/System/DeusEx.exe
POL_SetupWindow_detect_exit
#POL_SetupWindow_message "Appuyez sur 'Suivant' UNIQUEMENT quand le jeu aura\nété quitté sous peine de devoir recommencer l'installation." "Attention !" ""

#Installation de DX-HDTP
#POL_SetupWindow_message "Vous allez à présent installer Deus Ex HDTP Release 1." "Information" ""
POL_SetupWindow_wait_next_signal "Installation de Deus Ex HDTP Release 1" "Deus Ex"
cd $TEMP
wine HDTP-Release1.exe
POL_SetupWindow_detect_exit
#POL_SetupWindow_message "Appuyez sur 'Suivant' UNIQUEMENT quand l'installation du pack\nsera terminée sous peine de devoir recommencer l'installation." "Attention !" ""

#Installation de OpenGLDrv.dll
#POL_SetupWindow_message "Installation de OpenGLDrv.dll 1.8." "Information" ""
POL_SetupWindow_wait_next_signal "Installation de OpenGLDrv.dll 1.8" "Deus Ex"
rm "$REPERTOIRE/wineprefix/DeusEx_HDTP/drive_c/DeusEx/System/OpenGLDrv.dll"
mv "$TEMP/OpenGLDrv.dll" "$REPERTOIRE/wineprefix/DeusEx_HDTP/drive_c/DeusEx/System/"
POL_SetupWindow_detect_exit

#Fin de l'installation
POL_SetupWindow_make_shortcut "DeusEx_HDTP" "DeusEx/System" "HDTP.exe" "" "Deus Ex HDTP"
POL_SetupWindow_message "Installation terminée !\n\n\nScript créé d'après des informations tirées du site de Wine :\nhttp://appdb.winehq.org/objectManager.php?sClass=version&iId=3775" "Deus Ex"
POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEYACgkQ5TH6yaoTykei6wCfdtDvY2jPeSOBInf2u2YVE6kc
C1QAnAph3Bi9eWM01B79ZMy2MQ/KQ1gL
=XsNn
-----END PGP SIGNATURE-----
