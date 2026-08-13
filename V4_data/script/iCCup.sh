#!/usr/bin/env PlayOnLinux-Bash
# Information
# Date: 2023-11-15
# Last revision: 2023-11-15
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
TITLE="iCCup"
PREFIX="iccup"
POLVERSION="4.3.4"
WINEVERSION="7.22"
OSVERSION="win7"
ARCHITECTURE="x86"
COMPANY="iCCup"
SITEWEB="https://iccup.com/"
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

# Installation
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
INSTALLER="$APP_ANSWER"

#Installation started
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"

POL_Shortcut "Launcher.exe" "$TITLE"

#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZZvtRwAKCRDlMfrJqhPK
RxA/AJ4k52+Mupb2/tWHd2eQfQIG6HzjjQCfT5SkS48rUJ3ClJUG7sqpS0AOkqQ=
=k+Zl
-----END PGP SIGNATURE-----
