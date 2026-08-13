#!/bin/bash
# Date : August 16, 2014
# Last revision : see changelog
# Wine version used : 2.22, 1.7.22
# Author : miR
# Distribution used to test: Ubuntu 14.04 64
# SoG version tested: Demo 0.56g
#
# CHANGELOG
# [miR] (2014-08-16)
#   Initial script.
# [Dadu042] (2020-01-14 20:30)
#   Wine 1.7.22 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
TITLE="Secrets of Grindea"
POL_System_SetArch "x86"
PREFIX="secretsofgrindea"
WINEVERSION="2.22" 

# Initialization

POL_SetupWindow_Init
POL_Debug_Init

#Create prefix
POL_SetupWindow_presentation "$TITLE" "Pixel Ferrets" "http://www.secretsofgrindea.com" "miR" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Dependencies
POL_Call POL_Install_dotnet40
POL_Call POL_Install_d3dx10
POL_Call POL_Install_corefonts
 
POL_SetupWindow_InstallMethod "LOCAL"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the Secrets of Grindea installer that you have downloaded." "Secrets of Grindea installation"
	cd "$POL_System_TmpDir"
	POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_SetupWindow_wait "Installation in progress." "$TITLE installation"
    POL_Wine_WaitExit "$TITLE"
fi
 
POL_Shortcut "Secrets Of Grindea.exe" "$TITLE" "" "" "Game;"
POL_SetupWindow_Close
 
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDXxgAKCRDlMfrJqhPK
R/g3AJ408OajSipoA52n8OINh2CCHbrf6QCgiLrEmifRmdglKzJEr+Chb1kujRw=
=6dd5
-----END PGP SIGNATURE-----
