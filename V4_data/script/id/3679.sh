#!/usr/bin/env playonlinux-bash
# Date : (2019-10-25 18-11)
# Last revision : (2019-10-31 15-55)
# Wine version used : 2.22
# Distribution used to test : Ubuntu 18.04 LTS
# Author : t0bias
# PlayOnLinux : 4.3.4
# Script licence : GPL3
# Program licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="SketchUp 2016"
PREFIX="SketchUp2016"
 
FILE_NAME=""
FILE_MD5=""
DOWNLOAD_URL=""
 
DOWNLOAD_URL_EN="https://www.sketchup3d.de/download/182/version-2016/5841/sketchup-pro-2016-en-x32-f-windows-2.exe"
DOWNLOAD_URL_DE="https://www.sketchup3d.de/download/182/version-2016/5838/sketchup-pro-2016-de-x32-f-windows-2.exe"
FILE_NAME_EN="sketchup-pro-2016-en-x32-f-windows-2.exe"
FILE_NAME_DE="sketchup-pro-2016-de-x32-f-windows-2.exe"
FILE_MD5_EN="2b4ed698059c32bc04824f50a9f72109"
FILE_MD5_DE="dd952d4b236874c001f6f5dc0ec651a1"
 
POL_SetupWindow_Init
POL_Debug_Init 
 
POL_SetupWindow_presentation "$TITLE" "Google/Trimble" "https://www.sketchup.com" "t0bias" "$PREFIX"
   
POL_System_TmpCreate "$PREFIX"
 
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "SketchUp 2016 installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_SetupWindow_menu "In what language would you like to install $TITLE?" "Languages" "EN - English|DE - Deutsch" "|"
        if [ "$APP_ANSWER" = "DE - Deutsch" ]
        then
            FILE_NAME="$FILE_NAME_DE"
            FILE_MD5="$FILE_MD5_DE"
            DOWNLOAD_URL="$DOWNLOAD_URL_DE"
        elif [ "$APP_ANSWER" = "EN - English" ]
            FILE_NAME="$FILE_NAME_EN"
            FILE_MD5="$FILE_MD5_EN"
            DOWNLOAD_URL="$DOWNLOAD_URL_EN"
        else
            FILE_NAME="$FILE_NAME_EN"
            FILE_MD5="$FILE_MD5_EN"
            DOWNLOAD_URL="$DOWNLOAD_URL_EN"
        fi
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOAD_URL" "$FILE_MD5"
    INSTALLER="$POL_System_TmpDir/$FILE_NAME"
fi
 
POL_System_SetArch "x86"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "2.22"
 
POL_SetupWindow_wait "Preparing Installation: corefonts" "$TITLE"
POL_Call POL_Install_corefonts
 
Set_OS "winxp"
 
POL_SetupWindow_wait "Preparing Installation: dotnet40" "$TITLE"
POL_Call POL_Install_dotnet40
  
Set_OS "win7"
 
POL_Wine_reboot
 
POL_SetupWindow_wait "Installation in progress." "$TITLE"
POL_Wine "$INSTALLER"
  
POL_System_TmpDelete
  
POL_Shortcut "SketchUp.exe" "$TITLE" "" "Graphics;3DGraphics"
POL_Shortcut "Style Builder.exe" "Style Builder" "" "Graphics;3DGraphics"
POL_Shortcut "LayOut.exe" "LayOut" "" "Graphics;3DGraphics"
 
POL_SetupWindow_Close
 
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbwpLwAKCRDlMfrJqhPK
RwCHAJ0RmDquykVmNMuJrEB2y5fGO3aHEwCgmKMQ4/AzX+mYTClHz1IWz77B6rw=
=SWG8
-----END PGP SIGNATURE-----
