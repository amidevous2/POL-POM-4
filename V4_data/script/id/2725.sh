#!/usr/bin/env playonlinux-bash
# Date : (2016-01-27 20:00)
# Last revision : (2016-01-30 12:00)
# Wine version used : 1.6.2
# Distribution used to test : Debian Jessie 64 bits
# Author : Gouchi

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#LibreOffice
TITLE="LibreOffice 4"
PREFIX="LibreOffice4"

#Current LibreOffice Still Version
LO_STILL_VER="4.4.7"
MD5_LO_STILL="8239967f4181dffff11bfd5631e6e219"

#LibreOffice Still URL
URL_LO_STILL="http://download.documentfoundation.org/libreoffice/stable/$LO_STILL_VER/win/x86/LibreOffice_""$LO_STILL_VER""_Win_x86.msi"

#Prevent for asking to install mono
WINEDLLOVERRIDES="mscoree=d;$WINEDLLOVERRIDES"
export WINEDLLOVERRIDES

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2725

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
         
    POL_Download "$URL_LO_STILL" "$MD5_LO_STILL"
     
    INSTALLER="$POL_System_TmpDir/$(basename "$URL_LO_STILL")"
fi

#Installation LibreOffice
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
POL_Wine_WaitBefore "$TITLE"
POL_Wine msiexec /i "$INSTALLER"

#Fix for wine: Call from 0x7b8396ec to unimplemented function msvcr110.dll.?_GetConcurrency@details@Concurrency@@YAIXZ, aborting
POL_Call POL_Install_vcrun2012

#Delete temp directory
POL_System_TmpDelete

#Create shortcut
POL_Shortcut "soffice.exe" "$TITLE" "$TITLE.png"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlay8IsACgkQ5TH6yaoTykdq1ACdEvNez9WEVeS9A9b6VIzAb5po
2nAAn1X4b0CQInf8/D1tB4ughv8EpLCe
=7USP
-----END PGP SIGNATURE-----
