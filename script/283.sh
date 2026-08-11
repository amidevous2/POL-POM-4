#!/bin/bash
#INIT SCRIPT PLAYONLINUX.COM
#Is playonlinux running?
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
#Load & Check dependencies
source "$PLAYONLINUX/lib/sources"
cfg_check

##Translation:
if [ "$POL_LANG" == "fr" ]; then
INSTALL="En attente de l'installation de JediKnightAcademy..."
FINISH="JediKnightAcademy à été installé avec succes."
Q_UPDATE="Voulez vous installez maintenant le Patch 1.01 de Jedi Knight Jedi Academy -?"
DOWNLOAD="Téléchargement du patch en cours..."
else
INSTALL="Installing JediKnightAcademy..."
FINISH="JediKnightAcademy has been sucessfully installed."
Q_UPDATE="Do you want to install now the Jedi Knight Jedi Academy - Patch 1.01 ?"
DOWNLOAD="Downloading patch..."
fi

#-----------------------------------------------------------------------------------
#Init script v_3 JediKnightAcademy
#-----------------------------------------------------------------------------------

POL_SetupWindow_Init "" ""

#Game and script presentation
POL_SetupWindow_presentation "Jedi Knight : Jedi Academy" "LucasArts" "http://www.lucasarts.com" "dl.bonsai" "JediKnightAcademy"

# playonlinux_install_directory
select_prefixe "$REPERTOIRE/wineprefix/JediKnightAcademy"
POL_SetupWindow_prefixcreate
POL_SetupWindow_reboot

# JediKnightAcademy Install
POL_SetupWindow_cdrom "1" 
POL_SetupWindow_check_cdrom /GameData/Setup.exe
POL_SetupWindow_wait_next_signal "$INSTALL" "JediKnightAcademy"

TEMP="$CDROM"
cd $WINEPREFIX/dosdevices
rm ./*
ln -s ../drive_c c:
ln -s / z:
ln -s $TEMP d:
cd $REPERTOIRE/wineprefix/JediKnightAcademy

wine $TEMP/GameData/Setup.exe

POL_SetupWindow_detect_exit

#UPDATE 1.01
POL_SetupWindow_menu "$Q_UPDATE" "JediKnightAcademy" "YES_NO" "_"
CHOOSE="$APP_ANSWER"

if [ "$CHOOSE" == "YES" ]; then
cd $REPERTOIRE/tmp
POL_SetupWindow_wait_next_signal "$DOWNLOAD" "JediKnightAcademy"
wget ftp://ftp.lucasarts.com/patches/pc/JKAcademy1_01.exe -q
POL_SetupWindow_wait_next_signal "$INSTALL" "JediKnightAcademy"
wine ./JKAcademy1_01.exe
rm ./JKAcademy1_01.exe
fi

#Shortcut
POL_SetupWindow_make_shortcut "JediKnightAcademy" "Program Files/LucasArts/Star Wars Jedi Knight Jedi Academy/" "JediAcademy.exe" "JediKnightAcademy.xpm" "Jedi Knight Academy"

POL_SetupWindow_message "$FINISH" "JediKnightAcademy"
POL_SetupWindow_Close

#-----------------------------------------------------------------------------------
#End script v_3 JediKnightAcademy
#-----------------------------------------------------------------------------------

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEgACgkQ5TH6yaoTykdovQCfdseX1Bg4dP7wj1vRi2iqHUfs
27cAoJuwqn3vDYC1pB/wgUwQ9zGKPm9H
=X6UX
-----END PGP SIGNATURE-----
