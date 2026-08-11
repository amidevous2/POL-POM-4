#!/usr/bin/env playonlinux-bash
# Date : (2019-05-29)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: v1.4 (2007)
# Software based on: DirectX7
#
# CHANGELOG:
# [Dadu042] (2019-05-29 16-32)
#   Initial writting.
#
# Known issues:
# - Wine 4.0.1: no MIDI music (even when POL's directmusic installed).
# - Wine 3.0.0: game crash when launching.
# - Wine 3.21: game run but no MIDI music.
# - Screen resolution supported max : 640x480.
  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
      
TITLE="Frozen Fruits 1"
PREFIX="frozen_fruits1"
WORKING_WINE_VERSION="4.0.1"
AUTHOR="Dadu042"
EDITOR="BlueSkied"
GAME_URL="http://www.blueskied.com"
   
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
  
Set_OS "winxp"

# Useless for Frozen Fruits 1:
# POL_Call POL_Install_directmusic
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_d3dx10
# POL_Call POL_Install_d3dx11
  
# Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
# POL_Call POL_Install_VideoDriver
#
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS

###############
# Go          #
###############

POL_Call POL_Function_SetResolution 
 
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
 
	#    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"

	# Debug
	#    POL_SetupWindow_message "File: $APP_ANSWER\n\nPath:$WINEPREFIX/drive_c/" "$TITLE"
	#    POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"

	# 'POL_System_unrar failed with error 7!'
	#    POL_System_unrar "$APP_ANSWER"  "$WINEPREFIX/drive_c/"

	#    unrar x "$APP_ANSWER"  "$WINEPREFIX/drive_c/"
     
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
	#	cd "$WINEPREFIX/drive_c"
	cd "$POL_System_TmpDir"
	POL_Download "http://wwwu.edu.uni-klu.ac.at/khofer/Fruits_setup.exe"

	#	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Downloading...')" "$TITLE"
	#	POL_Wine start /unix "Fruits_setup.exe"
	POL_Wine "$POL_System_TmpDir/Fruits_setup.exe" 

	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing...')" "$TITLE"

	#    POL_System_unzip "echoes_plus.zip"
	#    POL_System_unrar "echoes_plus.rar"
	#    unrar x "echoes_plus.rar"  "$WINEPREFIX/drive_c/"
	#    POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
 
fi
 
POL_Shortcut "FrozenFruits.exe" "$TITLE" "" "Game;"
    
POL_Shortcut_Document "$TITLE" "ReadMe.htm"
  
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXO6f0AAKCRDlMfrJqhPK
RzkUAJ4rp51BTwwq+dmxqFHqaacz2OHkxwCgncdMUVs64LvSkNp7SdtzQVtzpYs=
=9aen
-----END PGP SIGNATURE-----
