#!/bin/bash
# Date : (2010-29-10 22-00)
# Last revision : see changelog
# Wine version used : 1.3.8, 1.3.9, 1.3.27, 1.6, 3.0.3
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#

# CHANGELOG
# [GNU_Raziel] (2010-29-10 22-00)
#   Initial script
# [ ] (2013-01-22)
#   ?
# [Petch] (2015-06-07)
#   Remove unused translations, update Wine version used to 1.6.2
# [Dadu042] (2013-01-22)
#   Fix a sad issue (Wine 3.O.2 instead of 3.0.2 (letter O instead of zero)). I replace with 3.0.5
# [Dadu042] (2020-01-07)
#   Wine 3.0.5 -> 3.0.3 (because of POL 4.2.12, still widely installed).
#   Add POL_RequiredVersion
#   Improve POL_Shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Fallout : New Vegas"
PREFIX="FalloutNewVegas"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"

if [ "$POL_LANG" == "fr" ]; then
LNG_CHOOSE_MEDIA="Quelle version possédez-vous?"
LNG_DVD="Version DVD"
LNG_STEAM="Version Steam Store"
LNG_DDV="Version Digital Download"
LNG_CHOOSE_DDV="Veuillez selectionner votre executable Digital Download de $TITLE"
LNG_INSERT_MEDIA="Veuillez insérer le disque $TITLE dans votre lecteur\nsi ce n'est pas déja fait."
LNG_WAIT_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du\njeu sera terminée sous peine de devoir recommencer l'installation."
LNG_WAIT_STEAM_END="Appuyez sur \"Suivant\" UNIQUEMENT quand l'installation du jeu Steam\nsera terminée sous peine de devoir recommencer l'installation."
LNG_INSTALL_ON="Installation en cours..."
LNG_GAME_VMS="Quelle est la quantité de mémoire (Mo) de votre carte graphique ?\n(minimum pour ce jeu : 256)" 
LNG_VMS_ERROR="Ce jeu ne fonctionnera correctement qu'avec une carte graphique ayant plus de\n256Mo de mémoire."
LNG_VC90_DL="Téléchargement de MSvc90..."
LNG_VC90_INSTALL="Installation MSvc90..."
LNG_GAME_WARNING="Vous devez contourner les protections anti-piratage de ce jeu\npour qu'il fonctionne avec wine."
LNG_SUCCES="$TITLE a été installé avec succès."
else
LNG_CHOOSE_MEDIA="What version do you have?"
LNG_DVD="DVD Version"
LNG_STEAM="Steam Store Version"
LNG_DDV="Digital Download Version"
LNG_CHOOSE_DDV="Please select your $TITLE Digital Download executable"
LNG_INSERT_MEDIA="Please insert $TITLE media into your disk drive\nif not already done."
LNG_WAIT_END="Click on \"Forward\" ONLY when the game installation is finished\nor you will have to redo the installation."
LNG_WAIT_STEAM_END="Click on \"Forward\" ONLY when Steam game installation\nwill be finished or you will have to redo the installation."
LNG_INSTALL_ON="Installation in progress..."
LNG_GAME_VMS="How much memory does your graphics board have?\n(minimum for this game : 256)" 
LNG_VMS_ERROR="This game will work correctly only with a graphic card with more than\n256Mb of memory."
LNG_VC90_DL="Downloading MSvc90..."
LNG_VC90_INSTALL="Installing MSvc90..."
LNG_GAME_WARNING="You must disable anti-piracy protections of this game\nif you want to play it with wine."
LNG_SUCCES="$TITLE has been installed successfully."
fi

#starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/FNV/top.jpg" "http://files.playonlinux.com/resources/setups/FNV/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bethesda Softworks" "http://fallout.bethsoft.com/" "GNU_Raziel" "$PREFIX" 

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory components
Set_OS "win7"
POL_Call POL_Install_quartz
POL_Call POL_Install_steam
POL_Call POL_Install_dxfullsetup

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "22380"

if [ "$INSTALL_METHOD" == "DVD" ]; then
	# asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "Setup.exe"
	POL_Wine start /unix "$CDROM/Setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/22380
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

#Fix for this game
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/22380"
else
	POL_Shortcut "FalloutNVLauncher.exe" "$TITLE" "$TITLE.png" "" "Game;"
fi

# Game protection warning
#if [ "$INSTALL_METHOD" == "DVD" ]; then
#	POL_SetupWindow_message "$(eval_gettext 'You must disable anti-piracy protections of this game\nif you want to play it with wine.')" "$TITLE"
#fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhTg4AAKCRDlMfrJqhPK
R7suAJ41x/Qj/peOPro9dpn9WwYNHD7wjgCfcjSTq/fvuTHLOh60djROW3qB41w=
=0gZX
-----END PGP SIGNATURE-----
