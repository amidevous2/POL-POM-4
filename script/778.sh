#!/bin/bash
# Date : (2010-08-12 21-00)
# Last revision : (2010-08-12 21-00)
# Wine version used : 1.3.8
# Distribution used to test : Debian Testing
# Author : GNU_Raziel
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Ski Challenge 2011"
PREFIX="SC2k11"
WORKING_WINE_VERSION="1.3.8"

if [ "$POL_LANG" == "fr" ]; then
GAME_VERSION="TSR-SkiChallenge11.exe"
LNG_DOWNLOAD_GAME="Téléchargement du freeware $TITLE..."
LNG_INSTALL_ON="Installation en cours..."
LNG_SUCCES="$TITLE a été installé avec succès."
elif [ "$POL_LANG" == "de" ]; then
GAME_VERSION="SF-SkiChallenge11.exe"
elif [ "$POL_LANG" == "it" ]; then
GAME_VERSION="RSI-SkiChallenge11.exe"
else
GAME_VERSION="SF-SkiChallenge11.exe"
LNG_DOWNLOAD_GAME="Downloading $TITLE freeware..."
LNG_INSTALL_ON="Installation in progress..."
LNG_SUCCES="$TITLE has been installed successfully."
fi

#starting the script
rm "$REPERTOIRE/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/sc2k11/top.jpg" "http://files.playonlinux.com/resources/setups/sc2k11/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages
 
POL_SetupWindow_presentation "$TITLE" "Green Tube" "http://www.skichallenge.ch" "GNU_Raziel" "$PREFIX" 

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#downloading specific Wine
POL_SetupWindow_install_wine "$WORKING_WINE_VERSION"
Use_WineVersion "$WORKING_WINE_VERSION"

#fetching PROGRAMFILES environmental variable 
POL_LoadVar_PROGRAMFILES

#Installing mandatory dependencies
POL_Call POL_Install_gecko

#downloading then install this FREE game
cd "$REPERTOIRE/ressources/"
if [ ! -e "$REPERTOIRE/ressources/$GAME_VERSION" ]; then
POL_SetupWindow_download "$LNG_DOWNLOAD_GAME" "$TITLE" "http://download.skichallenge.ch/SC11/installer/$GAME_VERSION"
fi
POL_SetupWindow_wait_next_signal "$LNG_INSTALL_ON" "$TITLE"
wine start /unix "$GAME_VERSION"
INSTALL_ON="1"
until [ "$INSTALL_ON" == "" ]; do
sleep 5
INSTALL_ON=`ps aux | grep "wineserver" | grep -v "grep"`
done
POL_SetupWindow_detect_exit

## PlayOnMac Section
#This game have native OSX version available
## End Section

#cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$REPERTOIRE/tmp/"
	rm -rf "$REPERTOIRE/tmp/*"
fi

#making shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "Updater.exe" "$TITLE" "$TITLE.png" ""
Set_WineVersion_Assign "$WORKING_WINE_VERSION" "$TITLE"

POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEMACgkQ5TH6yaoTykf6VgCePCPYOahKXyy10IJnAMDNdkEy
xKMAoJ93mm1lm/ov2K/Zvfw8roXPg6zT
=oFKT
-----END PGP SIGNATURE-----
