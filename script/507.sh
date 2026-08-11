#!/bin/bash
# Date : (dd-mm-yyyy 26-10-2009  hh:mm 21:44)
# Last Revision : (dd-mm-yyyy 28-10-2009 hh:mm 15:19)
# Wine version used : 1.0.1
# Distribution used to test : Ubuntu 9.04
# Game Version : 1.23
# Graphic Card : nVidia 7950GT
# nVidia Driver version : 180.44
# Author : -
# Licence : -
# Depend : -
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

if [ "$POL_LANG" == "it" ]

then
LNG_WAIT="Installazione..."
LNG_NEXT="Clicka Avanti SOLO se l'installazione è stata completata."
LNG_WARNING1="NON avviare il gioco durante l'installazione \n\n Per prima cosa installare il gioco, quindi avviarlo da PlayOnLinux \n\n NON installare Acrobat Reader durante l'installazione \n\n Si ricorda che GameSpy non è necessario per giocare a Warrior Kings Battles"
LNG_RESOLUTION1="Modalità di gioco"
LNG_RESOLUTION2="Selezionare la modalità con cui si desidera giocare (E' Consigliabile la Modalità Finestra):"
LNG_RESOLUTION21="Modalità_Schermo_Intero"
LNG_RESOLUTION22="Modalità_Finestra"
LNG_RESOLUTION31="Hai selezionato la modalità Schermo Intero! \n\n Nota Bene: \n Dovrai modificare la risoluzione durante il gioco per poter visualizzare \n tutti i bottoni disponibili nella finestra."
LNG_RESOLUTION32="Hai selezionato la modalità di gioco in finestra! \n\n Nota Bene: \n Se nella configurazione del gioco selezionerai risoluzioni troppo elevate \n non riuscirai a visualizzare tutti i bottoni disponibili nella finestra."

else
LNG_WAIT="Installing..."
LNG_NEXT="Click on Forward ONLY if the installation is finished."
LNG_WARNING1="Please do NOT select Play Game Now during installation! \n\n First Complete the installation, then run the game from Playonlinux. \n\n Please do NOT install Acrobet Reade during installation \n\n Note That GameSpy is NOT needed in order to play the game!"
LNG_RESOLUTION1="Game mode"
LNG_RESOLUTION2="Please select the game mode (Window Mode is Preferred):"
LNG_RESOLUTION21="Full_Screen_Mode"
LNG_RESOLUTION22="Window_Mode"
LNG_RESOLUTION31="You have selected Full Screen Mode! \n\n Please Take Note: \n You'll have to change the resolution in game's options in order to display \n all buttons available."
LNG_RESOLUTION32="You have selected Window Mode! \n\n Please Take Note: \n If you'll select too high resolutions in game's options you'll not be able to \n view all buttons available."

fi

wget http://upload.wikimedia.org/wikipedia/en/d/d1/Warrior_Kings_Battles_Cover.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

#Select prefix
PREFISSO=Warrior_Kings_Battles

POL_SetupWindow_presentation "Warrior Kings Battles" "Empire Interactive Entertainment" "http://en.wikipedia.org/wiki/Empire_Interactive" "Vortigern" "$PREFISSO"
 
 
select_prefix "$REPERTOIRE/wineprefix/$PREFISSO"
POL_SetupWindow_prefixcreate 

#Select window mode
POL_SetupWindow_menu "$LNG_RESOLUTION2" "$LNG_RESOLUTION1" "$LNG_RESOLUTION22 $LNG_RESOLUTION21" " "
POOL_ANSWER=$APP_ANSWER
if [ "$POOL_ANSWER" == "$LNG_RESOLUTION21" ]
then
POL_SetupWindow_message "$LNG_RESOLUTION31"
else if [ "$POOL_ANSWER" == "$LNG_RESOLUTION22" ]
then
POL_SetupWindow_message "$LNG_RESOLUTION32"
fi
fi

#Warning about installation
POL_SetupWindow_message "$LNG_WARNING1" "NOTE:"
 
POL_SetupWindow_cdrom
GAME_PATH=$(find $CDROM -iname Setup.exe)
if [ "$GAME_PATH" == "$CDROM/Setup.exe" ]
 
then
POL_SetupWindow_check_cdrom "Setup.exe"
wine "$GAME_PATH"
POL_SetupWindow_message "$LNG_NEXT"
 
else if [ "$GAME_PATH" == "$CDROM/setup.exe" ]

then
POL_SetupWindow_check_cdrom "setup.exe"
wine "$GAME_PATH"
POL_SetupWindow_message "$LNG_NEXT"
 
else if [ "$GAME_PATH" == "$CDROM/SETUP.EXE" ]

then
POL_SetupWindow_check_cdrom "SETUP.EXE"
wine "$GAME_PATH"
POL_SetupWindow_message "$LNG_NEXT"

fi

fi
 
fi

#Set window mode if choosen before
if [ "$POOL_ANSWER" == "$LNG_RESOLUTION22" ]
then
Set_Desktop On 800 600
fi

POL_SetupWindow_install_wine "1.0.1"
 
POL_SetupWindow_make_shortcut "$PREFISSO" "$PROGRAMFILES/Empire Interactive/Warrior Kings - Battles" "Warrior_Kings_Battles.exe" "" "Warrior Kings Battles"

#Wine 1.0.1 is mandatory to run the game
#Wine 1.1.31, 1.1.32 and also other releases won't work
Set_WineVersion_Assign "1.0.1" "Warrior Kings Battles"
 
POL_SetupWindow_reboot
 
POL_SetupWindow_Close
 
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFYACgkQ5TH6yaoTykeLZACgkEqNKdiQ4X1cgSdkspS2PmK6
9w4AoJztTa85I/IbOfO5Or+uIZAQi5/a
=9fC0
-----END PGP SIGNATURE-----
