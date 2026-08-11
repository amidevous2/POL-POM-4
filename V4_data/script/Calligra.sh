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
TITLE="Calligra Suite"
PREFIX="caligra"
POLVERSION="4.3.4"
WINEVERSION="7.22"
OSVERSION="win7"
ARCHITECTURE="x86"
COMPANY="Calligra Suite"
SITEWEB="https://calligra.org/"
AUTHOR="GuerreroAzul"
DOWNLOAD_URL="https://mirror.math.princeton.edu/pub/kde/ftp/Attic/calligra-2.9.6/calligragemini_x86_2.9.6.0.msi"
MD5_CHECKSUM="22065488fd7e8e2acabd99807f838c5f"
SETUP="calligragemini_x86_2.9.6.0.msi"
 
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
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
# Local Installation
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    INSTALLER="$APP_ANSWER"
# Web Installation
else
    DOWNLOAD_URL=$DOWNLOAD_URL
    MD5_CHECKSUM="$MD5_CHECKSUM"

    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"

    POL_Download "$DOWNLOAD_URL" "$MD5_CHECKSUM"
    INSTALLER="$POL_System_TmpDir/$SETUP"
fi

#Installation started
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "$INSTALLER"

POL_Extension_Write doc "Calligra Words"
POL_Extension_Write docx "Calligra Words"
POL_Extension_Write ppt "Calligra Stage"
POL_Extension_Write pptx "Calligra Stage"

POL_Shortcut "calligragemini.exe" "Calligra Gemini"
POL_Shortcut "calligrawords.exe" "Calligra Words"
POL_Shortcut "calligrastage.exe" "Calligra Stage"

#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZZvs8QAKCRDlMfrJqhPK
R6W2AJ9meklIHZQx8FW1dkLEXZJDLSTlZwCdGInn4aIBTtXmyHcnbr0JQzRROAw=
=Chyl
-----END PGP SIGNATURE-----
