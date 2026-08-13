#!/bin/bash
# Date : (2010-06-18 15-00)
# Last revision : (2011-07-17 19-30)
# Wine version used : 1.3.24
# Distribution used to test : Fedora 13 & Debian Squeeze
# Author : NSLW &Berillions
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TYTUL="Warcraft III : The Frozen Throne"
PREFIX="WarcraftIII"
PATCHVERSION="126a"
WORKINGWINEVERSION="1.3.24"

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

	POL_SetupWindow_menu "$LNG_LANGUAGE" "Languages" "english~french~italian~german~spanish~polish~japanese~korean~chinese traditional~chinese simplified~czech~russian~taiwanese" "~"
	LANGUAGEVERSION="$APP_ANSWER"
	if [ "$APP_ANSWER" == "english" ]; then
	LANGUAGEVERSIONSHRT="English"
	elif [ "$APP_ANSWER" == "french" ]; then
	LANGUAGEVERSIONSHRT="Francais"
	elif [ "$APP_ANSWER" == "italian" ]; then
	LANGUAGEVERSIONSHRT="Italiano"
	elif [ "$APP_ANSWER" == "german" ]; then
	LANGUAGEVERSIONSHRT="Deutsch"
	elif [ "$APP_ANSWER" == "spanish" ]; then
	LANGUAGEVERSIONSHRT="Castellano"
	elif [ "$APP_ANSWER" == "polish" ]; then
	LANGUAGEVERSIONSHRT="Polski"
	elif [ "$APP_ANSWER" == "japanese" ]; then
	LANGUAGEVERSIONSHRT="Japanese"
	elif [ "$APP_ANSWER" == "korean" ]; then
	LANGUAGEVERSIONSHRT="Korean"
	elif [ "$APP_ANSWER" == "chinese traditional" ]; then
	LANGUAGEVERSIONSHRT="Chinese_Trad"
	elif [ "$APP_ANSWER" == "chinese simplified" ]; then
	LANGUAGEVERSIONSHRT="Chinese_Simp"
	elif [ "$APP_ANSWER" == "taiwanese" ]; then
	LANGUAGEVERSIONSHRT="Taiwanese"
	PATCHVERSION="126a"
	elif [ "$APP_ANSWER" == "czech" ]; then
	LANGUAGEVERSIONSHRT="Cesky"
	elif [ "$APP_ANSWER" == "russian" ]; then
	LANGUAGEVERSIONSHRT="Russian"
	fi
	
cd "$REPERTOIRE/ressources"
#downloading patch
if [ ! -e "War3TFT_${PATCHVERSION}_${LANGUAGEVERSIONSHRT}.exe" ]; then
POL_SetupWindow_download "$LNG_DOWNLOADING War3TFT_${PATCHVERSION}_${LANGUAGEVERSIONSHRT}.exe" "Downloading patch" "http://ftp.blizzard.com/pub/war3x/patches/pc/War3TFT_${PATCHVERSION}_${LANGUAGEVERSIONSHRT}.exe"
fi
POL_SetupWindow_wait_next_signal "$LNG_INSTINPROGRESS" "$TYTUL"
wine "War3TFT_${PATCHVERSION}_${LANGUAGEVERSIONSHRT}.exe"
POL_SetupWindow_detect_exit
PATCHFILE="$REPERTOIRE/ressources/War3TFT_${PATCHVERSION}_${LANGUAGEVERSIONSHRT}.exe"
fi

POL_SetupWindow_wait_next_signal "$LNG_INSTALLATIONINPROGRESS" "$TYTUL"
wine "$PATCHFILE"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_PATCHSUCCES" "$TYTUL"
}

POL_SetupWindow_Init
POL_SetupWindow_free_presentation "$TYTUL" "$LNG_INTRODUCE"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"



#downloading specific Wine
POL_SetupWindow_install_wine "$WORKINGWINEVERSION"
Use_WineVersion "$WORKINGWINEVERSION"

#fetching PROGRAMFILES environmental variable
PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

#start patching
start_patching

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk53g5EACgkQ5TH6yaoTykdl9wCgqkwXknaGIsf+p5E7HEQSd5wG
lFAAni0fLR7ReRpJ+B+lEMjCWzsiOM/B
=zto/
-----END PGP SIGNATURE-----
