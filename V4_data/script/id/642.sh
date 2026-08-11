#!/bin/bash
# Date : (2010-05-24)
# Last revision : (2010-07-25)
# Wine version used : 1.1.44
# Distribution used to test : Ubuntu 10.04
# Author : Marco Gerards
# Licence : GPLv3
# Depend : none

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Anno 1602: Creation of a New World - Patch"
AUTHOR="Marco Gerards"
PREFIX="Anno1602"
PREFIXDIR="$REPERTOIRE/wineprefix/$PREFIX"
WORKINGWINEVERSION="1.1.44"

LNG_DOWNLOADING="PlayOnLinux is downloading"
LNG_LANGUAGE="What is your language version?"
LNG_INSTALLATIONINPROGRESS="Installation in progress..."
LNG_PATCHSUCCES="Patch for $TITLE has been installed successfully."
LNG_CHOOSEACTION="What do you want to do?"
LNG_PATCHM="Let me choose patch manually"
LNG_PATCHA="Download patch automatically"
LNG_PATCHLOCATION="Where is your patch located?"

POL_SetupWindow_Init

POL_SetupWindow_checkexist()
{	
	if [ ! -e $REPERTOIRE/wineprefix/$1 ]; then
		if [ "$POL_LANG" == "fr" ]; then
			LNG_PREFIX_NOT_EXIST="Le jeu n'est pas installé."
		else
			LNG_PREFIX_NOT_EXIST="The Game is not installed."
		fi
		POL_SetupWindow_message "$LNG_PREFIX_NOT_EXIST" "$TITLE"
		POL_SetupWindow_Close
		exit
	fi
}
 
POL_SetupWindow_checkexist "$PREFIX"

POL_SetupWindow_presentation "$TITLE" "Sunflowers" "http://anno.uk.ubi.com/pc/history1602.php" "$AUTHOR" "$PREFIX"

select_prefix "$PREFIXDIR"

POL_SetupWindow_install_wine "$WORKINGWINEVERSION"

Use_WineVersion "$WORKINGWINEVERSION"

# Automatically determine which patch to install.  Currently only
# downloading the Dutch version of the game is supported.
if [ -e $WINEPREFIX/drive_c/Anno1602/LeesDit.rtf ] ; then
  PATCHNAME="Anno 1602 patch 1 dutch"
  PATCHFILE="anno1602patch1_dut.exe"
else
  POL_SetupWindow_message "Downloading the patch for your version of Anno 1602 is not supported yet" "$TITLE" "$PLAYONLINUX/themes/tango/error.png"
  POL_SetupWindow_Close
  exit
fi

POL_SetupWindow_menu "$LNG_CHOOSEACTION" "Actions" "$LNG_PATCHM~$LNG_PATCHA" "~"
if [ "$APP_ANSWER" == "$LNG_PATCHM" ]; then
  POL_SetupWindow_browse "$LNG_PATCHLOCATION" "$TITLE" ""
  PATCHFILE="$APP_ANSWER"
else
  # Patch the game
  POL_SetupWindow_message "The patch \"$PATCHNAME\" for Anno 1602 will be downloaded and installed"

  cd "$REPERTOIRE/ressources"
  if [ ! -e "$PATCHFILE" ]; then
    POL_SetupWindow_download "$LNG_DOWNLOADING $TITLE" "$TITLE" "http://annomuseum.de/webseiten/SF/download.sunflowers.de/$PATCHFILE" 
  fi
fi

POL_SetupWindow_wait_next_signal "$LNG_INSTALLATIONINPROGRESS" "$TITLE"
wine "$PATCHFILE"
POL_SetupWindow_detect_exit
POL_SetupWindow_message "$LNG_PATCHSUCCES" "$TITLE"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF4ACgkQ5TH6yaoTykdALwCgjDlWTLDHJ03+LGhHT65MbAjC
nGEAnRhZi/ttFqj9nHKguJMDGKJgh3Jh
=D3W/
-----END PGP SIGNATURE-----
