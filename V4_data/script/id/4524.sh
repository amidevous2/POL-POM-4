#!/usr/bin/env PlayOnLinux-Bash
# Information
# Date: 2023-11-16
# Last revision: 2023-11-16
# Wine Version: 7.22
# OS: Linux Mint 21.2 x86_64 
# Author: GuerreroAzul
# PlayOnLinux : 4.3.4
# Script licence : GPL3
# Program licence : Retail

# Running the Scripts
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
POL_SetupWindow_Init
POL_Debug_Init
 
# Variable
TITLE="Wadanohara and the Great Blue Sea"
PREFIX="WATGBS"
POLVERSION="4.3.4"
WINEVERSION="7.22"
OSVERSION="win7"
ARCHITECTURE="x86"
COMPANY="Quality Games"
SITEWEB="https://vgperson.com/games/wadanohara.htm"
AUTHOR="GuerreroAzul"
 
#Presentation
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$SITEWEB" "$AUTHOR" "$TITLE"
 
# POL Validations
POL_RequiredVersion $POLVERSION || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION !nPlease update!"
 
#Linux Validations
if [ "$POL_OS" = "Linux" ]; then
    wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE!"
fi
 
#Mac Validations
if [ "$POL_OS" = "Mac" ]; then
    POL_Call POL_GetTool_samba3
    source "$POL_USER_ROOT/tools/samba3/init"
fi
 
#wine Setup And Installation
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OS"
POL_System_SetArch "$ARQUITECTURE"
 
# Installation of Libraries
POL_Call POL_Install_d3dx9

#Installation
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the file  zip to run')" "$TITLE"
INSTALLER="$APP_ANSWER"

#Installation started
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
POL_System_unzip "$INSTALLER" -d "$WINEPREFIX/drive_c/Game/"

POL_Shortcut "RPG_RT.exe" "Wadanohara and the Great Blue Sea"
POL_Shortcut "StarFullscreen.exe" "Wadanohara and the Great Blue Sea (Full Screen)"

#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZZvsywAKCRDlMfrJqhPK
Rx9AAJ0d6xs3ZFpfLU3dCRqUj5ncvl6uigCgisMzTLq8SVA5ef8yhqULZYRyveA=
=DbBQ
-----END PGP SIGNATURE-----
