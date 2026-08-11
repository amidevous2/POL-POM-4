#!/usr/bin/env playonlinux-bash
# Date : (2016-01-27 20:00)
# Last revision : (2016-01-30 12:00)
# Wine version used : 1.6.2
# Distribution used to test : Debian Jessie 64 bits
# Author : Gouchi

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#LibreOffice
TITLE="LibreOffice 5"
PREFIX="LibreOffice5"

#Current LibreOffice Fresh Version
LO_FRESH_VER="5.1.0"
MD5_LO_FRESH="2fe9e24065de1ff2baa41c50cd6827a9"

#LibreOffice Fresh URL
URL_LO_FRESH="http://download.documentfoundation.org/libreoffice/stable/$LO_FRESH_VER/win/x86/LibreOffice_""$LO_FRESH_VER""_Win_x86.msi"

#Prevent for asking to install mono
WINEDLLOVERRIDES="mscoree=d;$WINEDLLOVERRIDES"
export WINEDLLOVERRIDES

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2726
#Enable debug
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$TITLE" "http://www.libreoffice.org" "gouchi" "$TITLE"

POL_System_TmpCreate "$TITLE"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME"
     
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Msi (*.msi)|*.msi;*.MSI"
     
    INSTALLER="$APP_ANSWER"
    
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
         
    POL_Download "$URL_LO_FRESH" "$MD5_LO_FRESH"
     
    INSTALLER="$POL_System_TmpDir/$(basename "$URL_LO_FRESH")"
fi

#Installation LibreOffice
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
POL_Wine_WaitBefore "$TITLE"
POL_Wine msiexec /i "$INSTALLER"

#Delete temp directory
POL_System_TmpDelete

#Create shortcut
POL_Shortcut "soffice.exe" "$TITLE" "$TITLE.png"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAla7l/oACgkQ5TH6yaoTykcPRwCfQBrwhm4zHbWNKbr5CK5u9LmQ
6WoAniHJ168gvO2yJbSn3DdDtNeLyvzp
=1F5l
-----END PGP SIGNATURE-----
