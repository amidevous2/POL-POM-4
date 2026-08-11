#!/bin/bash
# Date : (2011-01-25 09-30)
# Last revision : 
# Wine version used : 1.2.2
# Distribution used to test : Ubuntu 10.10 x86
# Author : bigeyes
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Deux Ex - HDTP"
PREFIX="deusex_hdtp"
WORKING_WINE_VERSION="1.2.2"

if [ "$POL_LANG" == "fr" ]; then
LNG_INFOS_INSTALL="Ce script va vous aider à installer :\n     - Deus Ex\n     - Les patchs 1.112fm et 1.4\n     - D3DDrv.dll et OpenGLDrv.dll à jour\n     - Deus Ex HDTP Release 1 (High Definition Texture Pack)"
LNG_INFOS_DX="L'installation de Deus Ex va débuter.\n\n\nNe modifiez pas le répertoire d'installation par défaut ! (C:\DeusEx)\nN'oubliez pas de désélectionner l'installation de DirectX !"
LNG_INFOS_HDTP="Deus Ex va être lancé une première fois pour que HDTP puisse s'installer\ncorrectement.\n\n\nDans la fenêtre du choix de périphérique de rendu,\nsélectionnez le rendu OpenGL.\n\nUne fois le jeu lancé, quittez-le immédiatement.\n\nL'installation se poursuivra alors."
LNG_INFOS_SCRIPT="Installation terminée !\n\n\nScript créé d'après des informations tirées du site de Wine :\nhttp://appdb.winehq.org/objectManager.php?sClass=version&iId=3775"
LNG_DL_PATCH1="Téléchargement du patch 1.112fm..."
LNG_DL_PATCH2="Téléchargement du patch 1.4..."
LNG_DL_DLL1="Téléchargement de D3DDrv.dll..."
LNG_DL_DLL2="Téléchargement de OpenGLDrv.dll..."
LNG_DL_HDTP="Téléchargement de Deus Ex HDTP..."
LNG_EXTRACT="Décompression de l'archive..."
LNG_INSTALL="Installation du fichier..."
LNG_WAIT="Lancement de Deus Ex..."
else
LNG_INFOS_INSTALL="This installer will help you to install :\n	- Deus Ex\n	- patchs 1.112fm and 1.4\n	- D3DDrv.dll and OpenGLDrv.dll updated\n	- Deus Ex HDTP Release 1 (High Definition Texture Pack)"
LNG_INFOS_DX="Install will begin.\n\n\nDon't modify install directory ! (C:\DeuxEx)\nDon't install DirectX !"
LNG_INFOS_HDTP="Deus Ex will run now for HDTP. When asked, choose OpenGL renderer and when the game is running, quit it immediatly. Install process will continu."
LNG_INFOS_SCRIPT="Finish ! See it for more informations :\nhttp://appdb.winehq.org/objectManager.php?sClass=version&iId=3775"
LNG_DL_PATCH1="Patch 1.112fm - Downloading, please wait..."
LNG_DL_PATCH2="Patch 1.4 - Downloading, please wait..."
LNG_DL_DLL1="D3DDrv.dll - Downloading, please wait..."
LNG_DL_DLL2="OpenGLDrv.dll - Downloading, please wait..."
LNG_DL_HDTP="Deux Ex HDTP - Downloading, please wait..."
LNG_EXTRACT="Extracting files..."
LNG_INSTALL="Installting file..."
LNG_WAIT="Running Deus Ex..."
fi

# Présentation
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Eidos Interactive/Ion Storm" "http://fr.wikipedia.org/wiki/Deus_Ex" "bigeyes" "$PREFIX"
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

# Installation de Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"

# Informations sur l'installation
POL_SetupWindow_message "$LNG_INFOS_INSTALL" "$TITLE"
POL_SetupWindow_cdrom

mkdir -p $REPERTOIRE/wineprefix/$PREFIX

TEMP="$HOME/.PlayOnLinux/tmp/$PREFIX"
mkdir -p $TEMP
cd $TEMP

# Installation de Deus Ex
POL_SetupWindow_wait_next_signal "$LNG_INFOS_DX" "$TITLE"
cd $CDROM
wine Setup.exe
POL_SetupWindow_detect_exit

# Téléchargement des fichiers nécessaires à l'installation
cd $TEMP
POL_SetupWindow_download "$LNG_DL_PATCH1" "$TITLE" "http://ftp.eidos-france.fr/pub/fr/deus_ex/patches/DeusExMPPatch1112fm_F1.exe" ""
POL_SetupWindow_download "$LNG_DL_PATCH2" "$TITLE" "http://ftp.eidos-france.fr/pub/fr/deus_ex/patches/DeusEx14.exe" ""
POL_SetupWindow_download "$LNG_DL_DLL1" "$TITLE" "http://ftp.eidos-france.fr/pub/fr/deus_ex/patches/D3DDrv.dll" ""
POL_SetupWindow_download "$LNG_DL_DLL2" "$TITLE" "http://www.cwdohnal.com/utglr/dxglr20.zip" ""
POL_SetupWindow_download "$LNG_DL_HDTP" "$TITLE" "http://www.eer.cc/stuff/HDTP-Release1.exe" ""

#Décompression de l'archive
POL_SetupWindow_wait_next_signal "$LNG_EXTRACT" "$TITLE"
unzip dxglr20.zip
POL_SetupWindow_detect_exit

# Installation du patch 1.112fm
POLSetupWindow_wait_next_signal "$LNG_INSTALL" "$TITLE"
wine $TEMP/DeusExMPPatch1112fm_F1.exe
POL_SetupWindow_detect_exit

# Installation du patch 1.4
POL_SetupWindow_wait_next_signal "$LNG_INSTALL" "$TITLE"
wine $TEMP/DeusEx14.exe
POL_SetupWindow_detect_exit

# Installation de D3DDrv.dll
POL_SetupWindow_wait_next_signal "$LNG_INSTALL" "$TITLE"
rm "$REPERTOIRE/wineprefix/$PREFIX/drive_c/DeusEx/System/D3DDrv.dll"
mv "$TEMP/D3DDrv.dll" "$REPERTOIRE/wineprefix/$PREFIX/drive_c/DeusEx/System/"
POL_SetupWindow_detect_exit

# Pré-installation de DX HDTP
POL_SetupWindow_message "$LNG_INFOS_HDTP" "$TITLE"
POL_SetupWindow_wait_next_signal "$LNG_WAIT" "$TITLE"
wine $REPERTOIRE/wineprefix/$PREFIX/drive_c/DeusEx/System/DeusEx.exe
POL_SetupWindow_detect_exit

# Installation de DX HDTP
POL_SetupWindow_wait_next_signal "$LNG_INSTALL" "$TITLE"
cd $TEMP
wine HDTP-Release1.exe
POL_SetupWindow_detect_exit

# Installation de OpenGLDrv.dll
POL_SetupWindow_wait_next_signal "$LNG_INSTALL" "$TITLE"
rm "$REPERTOIRE/wineprefix/$PREFIX/drive_c/DeusEx/System/OpenGLDrv.dll"
mv "$TEMP/OpenGLDrv.dll" "$REPERTOIRE/wineprefix/$PREFIX/drive_c/DeusEx/System/"
POL_SetupWindow_detect_exit

# Nettoyage du dossier temporaire
chmod -R 777 "$TEMP"
rm -rf "$TEMP"

# Fin de l'installation
POL_SetupWindow_auto_shortcut "$PREFIX" "System/HDTP.exe" "$TITLE" "" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"

POL_SetupWindow_message "$LNG_INFOS_SCRIPT" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJGAACgkQ5TH6yaoTykeLCwCfSf1ocyus9lbQGx5YRyySWK4a
8CUAn3ILbd3M0oBSwCF5CggFogQ/DN1f
=hvoP
-----END PGP SIGNATURE-----
