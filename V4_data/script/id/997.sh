#!/bin/bash 
# Date : (2011-6-11 19-41) 
# Last revision : see changelog
# Wine version used : 1.3.18 - 1.3.32 
# Distribution used to test : Kubuntu 11.10 x64 
# Author : Ulrick(No) 
# Licence : Retail 
# Only For : http://www.playonlinux.com 
#
# CHANGELOG
# [NSLW] (2009-05-29 18-00)
#   Initial script.
# [Dadu042] (2020-01-15 19:00)
#   Wine 1.3.18 -> 3.20
# [Dadu042] (2020-01-20 11:00)
#   Add POL_RequiredVersion

[ "$PLAYONLINUX" = "" ] && exit 0 
source "$PLAYONLINUX/lib/sources" 

# Setting the variables
TITLE="Gothic 3" 
PREFIX="gothic3" 
WORKING_WINE_VERSION="3.20" 
GAME_VMS="512" 
DEVELOPER="Piranha Bytes"
SCRIPTCREATOR="Ulrick(No)"
COMPANYSITE="http://www.pluto13.de/"

# Starting the script 
POL_SetupWindow_Init 

# Starting debugging API 
POL_Debug_Init 

POL_SetupWindow_presentation "$TITLE" "$DEVELOPER" "$COMPANYSITE" "$SCRIPTCREATOR" "$PREFIX" 

POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path 
POL_Wine_SelectPrefix "$PREFIX" 

# Downloading wine if necessary and creating prefix 
Set_Arch "x86" 
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION" 

# Choose between DVD and Digital Download version 
POL_SetupWindow_InstallMethod "DVD,LOCAL" 

# Installing mandatory dependencies 
POL_Call POL_Install_dxfullsetup # To fix game crash
POL_Call POL_Install_devenum # To fix sound interruption
POL_Call POL_Install_dsound # To fix sound interruption
POL_Call POL_Install_vcrun6 # To fix game crash

# Begin game installation 
if [ "$INSTALL_METHOD" == "DVD" ]; then 
# Asking for CDROM and checking if it's correct one 
POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" 
POL_SetupWindow_cdrom 
POL_Wine start /unix "$CDROM/setup.exe" 
POL_Wine_WaitExit "$TITLE" 
else 
# Asking then installing DDV of the game 
cd "$HOME" 
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
SETUP_EXE="$APP_ANSWER" 
POL_Wine start /unix "$SETUP_EXE" 
POL_Wine_WaitExit "$TITLE" 
fi 

# Fix for this game 
POL_Wine_DirectSound "MaxShadowSize" "0" 
POL_Wine_Direct3D "UseGLSL" "enabled" 
Set_DXGrab On
Set_Managed Off

# Set Graphic Card information keys for wine 
POL_Wine_SetVideoDriver 

# Sound problem fix - pulseaudio related 
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa" 
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y" 
## End Fix 

## Begin Common PlayOnMac Section ## 
[ "$POL_OS" = "Mac" ] && Set_Managed "Off" 
## End Section ## 

# Graphic fix
# Asking for resolution
POL_SetupWindow_menu_list "$(eval_gettext "Choose the game resolution")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"
 
resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"

 
cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/$PROGRAMFILES/Gothic 3/Ini/" || POL_Debug_Error "Unable to find Gothic 3 folder"
mv ge3.ini ge3.ini.back 

cat ge3.ini.back | sed s/Bottom\=768/Bottom\=$HEIGHT/ | sed s/Right\=1024/Right\=$WIDTH/ > ge3.ini
Set_Desktop On $WIDTH $HEIGHT

# Asking about game mode
POL_SetupWindow_menu_list "$(eval_gettext "Now you will be able to choose the game mode:\n1)Windowed mode:\nAll works besides system cursor in the game's window.\n\n2)Fullscreen mode:\nAll works besides the sky, it is black.\n\n\n\nWhat mode do you prefer?")" "$TITLE" "WINDOWED_MODE-FULLSCREEN_MODE" "-" "WINDOWED_MODE"

GAMEVISUALMODE="$APP_ANSWER"

# Setting windowed mode
if [ "$GAMEVISUALMODE" == "WINDOWED_MODE" ]; then
cd "$POL_USER_ROOT/wineprefix/$PREFIX/drive_c/$PROGRAMFILES/Gothic 3/Ini/" || POL_Debug_Error "Unable to find Gothic 3 folder"
mv ge3.ini ge3.ini.back 
cat ge3.ini.back | sed s/Fullscreen\=true/Fullscreen\=false/ > ge3.ini
fi

# Making shortcut 
POL_Shortcut "Gothic3.exe" "$TITLE" "" "" "Game;"

# Final note
POL_SetupWindow_message "$(eval_gettext '$TITLE is installed')" "$TITLE"

# Exiting the  POL window
POL_SetupWindow_Close 
exit 0 
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiV+8AAKCRDlMfrJqhPK
R0jlAJ9WLiozd9FkEimYsLkjjGPg8CPTIACfeH1eR8h8Lfl/8gvp8Ivz5F7UXGQ=
=YQW3
-----END PGP SIGNATURE-----
