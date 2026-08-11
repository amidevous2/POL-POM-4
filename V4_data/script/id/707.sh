#!/bin/bash
#Date : (2010-10-01)
# Last revision : (2010-10-01)
# Wine version used : 1.2
# Distribution used to test : Opensuse 11.3 64 bits
# Author : Ang1fr
 
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
 
TITLE="Two Worlds GOTY"
PREFIX="Two_Worlds"
WORKING_WINE_VERSION="1.2"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_DVD="Version DVD"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de\n$TITLE"
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE\ndans votre lecteur si ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_SUCCES="$TITLE a été installé avec succès."
LNG_TODO="Pour pouvoir jouer correctement, vous devrez aller dans les paramètres du jeu puis dans clavier\n et reconfigurer les touches correspondantes aux actions, raccourcis etc. En effet le logiciel ne tient\n pas compte du type de clavier (Pays).\n\n Bon jeu !"
 
else
LNG_CHOOSE_MEDIA="What version do you have?"
LNG_DVD="DVD Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE\nDigital Download executable"
LNG_INSERT_MEDIA="Please insert $TITLE\nmedia into your disk drive if not already done."
LNG_WAIT_END="Click on \"Next\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_SUCCES="$TITLE has been installed successfully."
LNG_TODO="To Play, you will have to go in the parameters of the game, and next keyboard to config\n again actions and shortcut ... The game doesn't take care of the country of the keyboard.\n\n Good Game !"
fi
 
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$TITLE" "Zuxxez Entertainment" "http://www.2-worlds.com" "ang1fr" "$PREFIX"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
 
#downloading and using specific Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"
 
#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
 
#Choose between DVD and Digital Download version
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "Actions" "$LNG_DVD~$LNG_DDV" "~"
 
if [ "$APP_ANSWER" == "$LNG_DVD" ]; then
        GAME_MEDIAVERSION="DVD"
else
        GAME_MEDIAVERSION="DD"
fi
 
if [ "$GAME_MEDIAVERSION" == "DVD" ]; then
        #asking for CDROM and checking if it is correct one
        POL_SetupWindow_message "$LNG_INSERT_MEDIA"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Autorun.exe"
        wine start /unix "$CDROM/Autorun.exe"
        POL_SetupWindow_message "$LNG_WAIT_END" "$TITLE"
else
        #Asking then installing DDV of the game
        cd $HOME
        POL_SetupWindow_browse "$LNG_CHOOSE_DDV" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
        wine start /unix "$SETUP_EXE"
        INSTALL_ON="1"
        until [ "$INSTALL_ON" == "" ]; do
        sleep 5
        INSTALL_ON=`ps aux | grep "wineserver" | grep -v "grep"`
        done
        POL_SetupWindow_detect_exit
 fi
 
#Setting mandatory wine modifications
cd $REPERTOIRE/tmp/
echo "[HKEY_CURRENT_USER\Software\Wine\DirectSound]" > $REPERTOIRE/tmp/directsound.reg
echo "\"DefaultSampleRate\"=\"48000\"" >> $REPERTOIRE/tmp/directsound.reg
regedit $REPERTOIRE/tmp/directsound.reg
 
 
#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "TwoWorlds.exe" "$TITLE"
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"
 
#install OK message 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
 
#game keyboard config message
POL_SetupWindow_message "$LNG_TODO" "$TITLE"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFwACgkQ5TH6yaoTykcoLwCgoOC8lxkNo34FAz0KVvOehZJ8
xuoAniVqnfTcp8yvkcweibBZ/KU2bc2G
=Hgbr
-----END PGP SIGNATURE-----
