#!/bin/bash
# Date : (2010-05-23 10-00)
# Last revision : (2010-05-23 10-00)
# Wine version used : -
# Distribution used to test : -
# Author : NSLW
# Licence : Retail
# Depend : -

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Total Annihilation"
PREFIX="TotalAnnihilation"
WORKINGWINEVERSION="1.1.44"

LNG_DOWNLOADING="PlayOnLinux is downloading"
LNG_LANGUAGE="What is your language version?"
LNG_INSTALLATIONINPROGRESS="Installation in progress..."
LNG_INTRODUCE="This wizard will help you to install patch for $TYTUL."
LNG_INSTALL_GAME_FIRST="Install $TYTUL first."
LNG_PATCHSUCCES="Patch for $TYTUL has been installed successfully."
LNG_CHOOSEACTION="What do you want to do?"
LNG_PATCHM="Let me choose patch manually"
LNG_PATCHA="Download patch automatically"
LNG_PATCHLOCATION="Where is your patch located?"

start_patching()
{

POL_SetupWindow_menu "$LNG_CHOOSEACTION" "Actions" "$LNG_PATCHM~$LNG_PATCHA" "~"
if [ "$APP_ANSWER" == "$LNG_PATCHM" ]; then
POL_SetupWindow_browse "$LNG_PATCHLOCATION" "$TYTUL" ""
PATCHFILE=$APP_ANSWER
elif [ "$APP_ANSWER" == "$LNG_PATCHA" ]; then

cd "$REPERTOIRE/ressources"
if [ ! -e "ta1x-31c.exe" ]; then
POL_SetupWindow_download "$LNG_DOWNLOADING ta1x-31c.exe" "$TYTUL" "ftp://ftp.infogrames.net/patches/totala/ta1x-31c.exe"
fi
PATCHFILE="$REPERTOIRE/ressources/ta1x-31c.exe"
fi

POL_SetupWindow_wait_next_signal "$LNG_INSTALLATIONINPROGRESS" "$TYTUL"
wine "$PATCHFILE"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_PATCHSUCCES" "$TYTUL"
}

POL_SetupWindow_Init
POL_SetupWindow_free_presentation "$TYTUL" "$LNG_INTRODUCE"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#checking if the game is installed
if [ ! -e "$REPERTOIRE/configurations/installed/$TYTUL" ]; then
POL_SetupWindow_message "$LNG_INSTALL_GAME_FIRST" "$TYTUL"
POL_SetupWindow_Close
exit
fi

#downloading specific Wine
POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

#start patching
start_patching

#capitalize executable's name
cd "$REPERTOIRE/configurations/installed"
sed -i "s/totala.exe/TotalA.exe/g" "$TYTUL"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF0ACgkQ5TH6yaoTykeIcACfajLYkWwEiPvNeF4xpQCyOX07
AksAn3TjlmTKuRsX66C7pcvYdgQZkset
=3pnc
-----END PGP SIGNATURE-----
