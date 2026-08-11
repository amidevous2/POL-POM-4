#!/bin/bash
# Date : (????-??-?? ??-??)
# Last revision : (2011-01-20 12-20)
# Wine version used : -
# Distribution used to test : ?
# Author : THAiSi, Updated by GNU_Raziel and SuperPlumus

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Sam and Max Season 1"
PREFIX="sam-max-season-1"

if [ "$POL_LANG" == "fr" ]
then
LNG_WAIT="Veuillez patienter..."
LNG_DOWNLOAD_RUN="Téléchargement en cours..."
LNG_INSTALL_RUN="Installation en cours..."
LNG_WAIT_END="Cliquez sur \"Suivant\" UNIQUEMENT quand l'installation de\n$TITLE sera terminée."
LNG_INFO="Voici comment faire fonctionner le jeu.\n 1.Entrez le serial (obtenu après création d'un compte valide sur le site de Telltale)\n 2.Alt+F4 pour fermer la fenêtre.\n 3.Relancer le jeu et cliquez sur le lien pour démarrer.\n 4.Cliquez plusieurs fois sur l'écran d'introduction pour démarrer le jeu.\n 5.Après avoir réglé la résolution et/ou le mode fenêtré, faite Alt+F4 pour sortir.\nLes paramêtres seront appliqués au prochains lancement."
LNG_SUCCES="$TITLE a été installé avec succès !"
else
LNG_WAIT="Please wait..."
LNG_DOWNLOAD_RUN="Downloading..."
LNG_INSTALL_RUN="Installation in progress..."
LNG_WAIT_END="Click on \"Forward\" ONLY when the\n$TITLE installation is finished."
LNG_INFO="Use these steps to play the game.\n 1. Enter serial (found in account section on telltale site)\n2. Alt + F4 to close.\n3. Run again and click the link to run.\n4. click a few times for the introduction to start.\n5. After changing to windowed mode or resolution, press Alt+F4 to exit.\nChanges are applied next time you start the game."
LNG_SUCCES="$TITLE has been installed successfully."
fi

EPISOD_101="Sam and Max 101: Culture Shock"
EPISOD_102="Sam and Max 102: Situation Comedy"
EPISOD_103="Sam and Max 103: The Mole, the Mob, and the Meatball"
EPISOD_104="Sam and Max 104: Abe Lincoln Must Die!"
EPISOD_105="Sam and Max 105: Reality 2.0"
EPISOD_106="Sam and Max 106: Bright side of the Moon"

POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Telltale Games" "http://www.telltalegames.com/samandmax" "THAiSi, Modified by GNU_Raziel and SuperPlumus" "$PREFIX"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

POL_LoadVar_PROGRAMFILES

TEMP="$REPERTOIRE/tmp/$PREFIX"
mkdir -p "$TEMP"

Set_OS "vista" 
Set_Iexplore

# Download all episodes from the telltale website
cd "$TEMP"

# Episode 1
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$EPISOD_101" "http://www.telltalegames.com/demo/cultureshock"
mv cultureshock 101_Setup.exe
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$EPISOD_101"
wine "$TEMP/101_Setup.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_auto_shortcut "$PREFIX" "SamMax101.exe" "$EPISOD_101"

# Episode 2
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$EPISOD_102" "http://www.telltalegames.com/demo/situationcomedy"
mv situationcomedy 102_Setup.exe
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$EPISOD_102"
wine "$TEMP/102_Setup.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_auto_shortcut "$PREFIX" "SamMax102.exe" "$EPISOD_102"

# Episode 3
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$EPISOD_103" "http://www.telltalegames.com/demo/meatball"
mv meatball 103_Setup.exe
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$EPISOD_103"
wine "$TEMP/103_Setup.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_auto_shortcut "$PREFIX" "SamMax103.exe" "$EPISOD_103"

# Episode 4
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$EPISOD_104" "http://www.telltalegames.com/demo/lincolnmustdie"
mv lincolnmustdie 104_Setup.exe
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$EPISOD_104"
wine "$TEMP/104_Setup.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_auto_shortcut "$PREFIX" "SamMax104.exe" "$EPISOD_104"

# Episode 5
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$EPISOD_105" "http://www.telltalegames.com/demo/reality2.0"
mv reality2.0 105_Setup.exe
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$EPISOD_105"
wine "$TEMP/105_Setup.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_auto_shortcut "$PREFIX" "SamMax105.exe" "$EPISOD_105"

# Episode 6
POL_SetupWindow_download "$LNG_DOWNLOAD_RUN" "$EPISOD_106" "http://www.telltalegames.com/demo/brightside"
mv brightside 106_Setup.exe
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_RUN" "$EPISOD_106"
wine "$TEMP/106_Setup.exe"
POL_SetupWindow_detect_exit
POL_SetupWindow_auto_shortcut "$PREFIX" "SamMax106.exe" "$EPISOD_106"

chmod -R 777 "$TEMP"
rm -rf "$TEMP"

POL_SetupWindow_message "$LNG_INFO" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEQACgkQ5TH6yaoTyke8KACeLn3ZZL1gRV/nZmC2COF7dWRF
8f0AoKKLebYN0z6Micpe8VeEt86642y4
=yqap
-----END PGP SIGNATURE-----
