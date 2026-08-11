#!/bin/bash
# Date : (2009-12-02 15-30)
# Last revision : (2010-12-12 20-00)
# Wine version used : 1.3.9
# Distribution used to test : OpenSuse 11.3
# Author : NSLW & GNU_Raziel & TheUnknownCylon
# Licence : Retail
#
# This script can be used as a template for the Age Of Empires III updates
# including the Warchiefs and Asian Dynasties updates
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="AOE3"
WORKINGWINEVERSION="1.3.9"

PATCHVERSION="103"
PATCHVERSIONSTR="1.03"
TITLE_FOR="Age Of Empires III : The Asian Dynasties"
TITLE="$TITLE_FOR Update $PATCHVERSIONSTR"
DOWNLOAD_POSTFIX="y"

#langvars
LNG_GAME_UPDATE_WELCOME="This wizard will help you install the latest patch for $TITLE_FOR."
LNG_SUCCES="$TITLE has been installed successfully."
LNG_INSTALL_GAME_FIRST="Please install $TITLE first."
LNG_CHOOSE_MEDIA_DOWNLOAD_AUTO="Download patch $PATCHVERSIONSTR automatically"
LNG_LANGUAGE="What is your language version?"
LNG_GAME_UPDATE_DL="Please wait while the patch is being downloaded...\nThis operation can take some time, depending of you internet connection." 
LNG_INSTALLATIONINPROGRESS="Installing the patch... please wait..."

LNG_CHOOSE_MEDIA="Please choose between an auto-download of the patch, browse, or install from disk."
LNG_CHOOSE_MEDIA_DOWNLOAD_AUTO="Download patch $PATCHVERSIONSTR automatically"
LNG_CHOOSE_MEDIA_DISK="Patch from a local file"
LNG_CHOOSE_MEDIA_DISK_CHOOSE="Please specify the location of the patch"

#starting the script
rm "$REPERTOIRE/tmp/*.jpg"
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Ensemble Studios" "http://www.agecommunity.com/gameUpdates.aspx" "NSLW & TheUnknownCylon" "$PREFIX"
  
POL_SetupWindow_checkexist()
{	
	if [ ! -e $REPERTOIRE/wineprefix/$1 ]; then
		POL_SetupWindow_message "$LNG_INSTALL_GAME_FIRST" "$TITLE"
		POL_SetupWindow_Close
		exit
	fi
}
 
POL_SetupWindow_checkexist "$PREFIX"
select_prefix "$REPERTOIRE/wineprefix/$PREFIX" 
Use_WineVersion "$WORKING_WINE_VERSION"
POL_LoadVar_PROGRAMFILES

#How does the user wants to continue with the installation? Auto-download or disk?
POL_SetupWindow_menu "$LNG_CHOOSE_MEDIA" "Actions" "$LNG_CHOOSE_MEDIA_DOWNLOAD_AUTO~$LNG_CHOOSE_MEDIA_DISK" "~"

if [ "$APP_ANSWER" == "$LNG_CHOOSE_MEDIA_DOWNLOAD_AUTO" ]; then
	#autodownload:

	POL_SetupWindow_menu "$LNG_LANGUAGE" "Languages" "english~french~italian~german~spanish~brazilian~polish~japanese~korean~chinese~czech~hungarian~russian" "~"
	LANGUAGEVERSION=$APP_ANSWER
	if [ "$APP_ANSWER" == "english" ]; then
	LANGUAGEVERSIONSHRT="EN"
	elif [ "$APP_ANSWER" == "french" ]
	then
	LANGUAGEVERSIONSHRT="FR"
	elif [ "$APP_ANSWER" == "italian" ]
	then
	LANGUAGEVERSIONSHRT="IT"
	elif [ "$APP_ANSWER" == "german" ]
	then
	LANGUAGEVERSIONSHRT="DE"
	elif [ "$APP_ANSWER" == "spanish" ]
	then
	LANGUAGEVERSIONSHRT="ES"
	elif [ "$APP_ANSWER" == "brazilian" ]
	then
	LANGUAGEVERSIONSHRT="BP"
	elif [ "$APP_ANSWER" == "polish" ]
	then
	LANGUAGEVERSIONSHRT="PL"
	elif [ "$APP_ANSWER" == "japanese" ]
	then
	LANGUAGEVERSIONSHRT="JP"
	elif [ "$APP_ANSWER" == "korean" ]
	then
	LANGUAGEVERSIONSHRT="KOR"
	elif [ "$APP_ANSWER" == "chinese" ]
	then
	LANGUAGEVERSIONSHRT="CHT"
	elif [ "$APP_ANSWER" == "czech" ]
	then
	LANGUAGEVERSIONSHRT="CZE"
	elif [ "$APP_ANSWER" == "hungarian" ]
	then
	LANGUAGEVERSIONSHRT="HU"
	elif [ "$APP_ANSWER" == "russian" ]
	then
	LANGUAGEVERSIONSHRT="RU"
	fi

	EXE_STR="aoe3$DOWNLOAD_POSTFIX-$PATCHVERSION-${LANGUAGEVERSION}.exe"
	DOWNLOAD_URI="http://aom.zone.com/MGS/ES/loc/patch$DOWNLOAD_POSTFIX$PATCHVERSION/$LANGUAGEVERSIONSHRT/$EXE_STR"

	#Do the download, execute it, and finish it :)
	cd "$REPERTOIRE/tmp"
	#remove old download if tried before
	if [ -e "$EXE_STR" ]; then
		rm "$EXE_STR"
	fi
	#start the download
	POL_SetupWindow_download "$LNG_GAME_UPDATE_DL" "$TITLE" "$DOWNLOAD_URI"
	POL_SetupWindow_wait_next_signal "$LNG_INSTALLATIONINPROGRESS" "$TITLE"
		wine "$REPERTOIRE/tmp/$EXE_STR"
		rm "$EXE_STR"
	POL_SetupWindow_detect_exit

else
	#patch from local disk
	POL_SetupWindow_browse "$LNG_CHOOSE_MEDIA_DISK_CHOOSE" "$TITLE" ""
	POL_SetupWindow_wait_next_signal "$LNG_INSTALLATIONINPROGRESS" "$TITLE"
		wine "$APP_ANSWER"
	POL_SetupWindow_detect_exit
fi
 
 
POL_SetupWindow_message "$LNG_SUCCES" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF4ACgkQ5TH6yaoTykdvJQCgk77ysUy34SPOu7PtY57vWlsI
6BIAmwefwmPGH3HSGxeRzgAQ9Tbwp4nj
=8rV5
-----END PGP SIGNATURE-----
