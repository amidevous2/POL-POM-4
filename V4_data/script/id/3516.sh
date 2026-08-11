#!/usr/bin/env playonlinux-bash
# Date : (2019-05-17 09-56)
# Last revision : (2019-05-17 09-56)
# Wine version used : see below
# Distribution used to test : Ubuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Software version used of the software to write this script: 1.x ? (Start.exe : december 2012)
# 
# Game based on DirectX 9, X3DAudio1_7.dll, Nvidia Physx.
#
# Known issues :
# Wine 4.1: game crash as soon it start to load, nothing appear.
#
# Wine 4.8: game crash as soon it start to load, nothing appear.
# [05/17/19 10:28:38] - Running wine-4.8 woodcutter2013.exe (Working directory : /home/me/.PlayOnLinux/wineprefix/woodcutter_sim_2013/drive_c/Program Files/Woodcutter Simulator 2013)
# 002c:err:module:load_builtin_dll failed to load .so lib for builtin L"X3DAudio1_7.dll": libFAudio.so.0: Ne peut ouvrir le fichier d'objet partagé: Aucun fichier ou dossier de ce type
# 002c:err:module:import_dll Loading library X3DAudio1_7.dll (which is needed by L"C:\\Program Files\\Woodcutter Simulator 2013\\woodcutter2013.dll") failed (error c000007a).
# 002c:err:module:LdrInitializeThunk Importing dlls for L"C:\\Program Files\\Woodcutter Simulator 2013\\woodcutter2013.dll" failed, status c0000135


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Woodcutter Simulator 2013"
PREFIX="woodcutter_sim_2013"
WORKING_WINE_VERSION="4.8"
AUTHOR="Dadu042"
EDITOR="UIG Entertainment"
GAME_URL="http://www.uieg.de"
 
POL_SetupWindow_Init
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
    
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "win7"

###############
# Go          #
###############

POL_SetupWindow_InstallMethod "LOCAL,CD"

POL_SetupWindow_message  "Warning: when the installer will ask you, You should disable automatic updates !.\n" "$TITLE"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "UIG GmbH Online.url"
        POL_Wine start /unix "$CDROM/Start.exe"
        POL_Wine_WaitExit "Start.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "woodcutter2013.exe" "$TITLE" ""
  
POL_Call POL_Install_VideoDriver

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiOIQAKCRDlMfrJqhPK
R7/TAJ4h8LwpZqlLvmadkq5j7PpCNAnJowCfcLu/Zwcfvr0LOhXinGg/1pxZkFs=
=eQpE
-----END PGP SIGNATURE-----
