#!/usr/bin/env PlayOnLinux-Bash
# Information
# Date: 2023-12-12
# Last revision: 2023-12-12 
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
TITLE="Nimègue v3"
PREFIX="nimegue3"
POLVERSION="4.3.4"
WINEVERSION="7.22"
OSVERSION="win7"
ARCHITECTURE="x86"
COMPANY="Jean-Louis GARRET & Gilles DAVID"
SITEWEB="https://www.cegfc.net/www/nimegue/nimegue/index.html"
AUTHOR="GuerreroAzul"
DOWNLOAD_URL="https://www.cegfc.net/www/nimegue/nimegue/_iserv/dlfiles/dl.php?ddl=installation-nimegue-v3.18-d.exe"
MD5_CHECKSUM="b266477bb15727f92bd640f88b4d8258"
SETUP="installation-nimegue-v3.18-d.exe"
 
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

POL_Shortcut "NIMEGUE3.exe" "$TITLE"

#End installation
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZZvsHAAKCRDlMfrJqhPK
R6BLAJ9gYqRIUkeAtwScmOpE4KNPVq3ymwCeK+cTwvvZjFeMEiubS81wWX2I2Ko=
=dAX4
-----END PGP SIGNATURE-----
