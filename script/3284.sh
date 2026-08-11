#!/usr/bin/env playonlinux-bash
# Date : 2017-11-26
# Last revision : see changelog
# Wine version used : system
# Distribution used to test : Ubuntu 18.04
# Author : rlarjsdn122
# Script licence : GPLv3
# Program licence : AlternativaPlatform

# CHANGELOG
# [rlarjsdn122] (2017-11-26)
#   Initial script.
# [Dadu042] (2019-05-15 09-49)
#   Set category.
# [Dadu042] (2020-01-05 20-48)
#   Fix typo.
#   Fix category.
# [Dadu042] (2020-06-15 20-48)
#   Add POL_Wine_WaitExit
#   VMS: 512 -> 256


# Depend :
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Tanki Online"
PREFIX="tanki"
  
POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "AlternativaPlatform" "http://tankionline.com/" "rlarjsdn122" "$PREFIX"

POL_SetupWindow_Init

POL_SetupWindow_message "Hello, Tanker! Welcome to installation of Tanki Online client for Linux.\nYou can connect to Tanki with web-browser.\nInstall this, if you do not want to play Tanki with web browser." "Welcome"

POL_System_TmpCreate "tankitmp"

POL_Wine_SelectPrefix "$PREFIX"

cd "$POL_System_TmpDir"

POL_Download "http://s.eu.tankionline.com/resources/client/1/tankionline-eu.exe" "00eea89dd08a5c134f3f26cf6818344d"

INSTALLER="$POL_System_TmpDir/tankionline-eu.exe"

POL_Wine_PrefixCreate
POL_SetupWindow_VMS "256"

POL_Call POL_Install_corefonts
POL_Call POL_Install_d3dx9
POL_Call POL_Install_d3dcompiler_43
POL_Call POL_Install_flashplayer
POL_Call POL_Install_AdobeAir

POL_SetupWindow_wait "Please wait" "Installation in progress"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"
  
POL_System_TmpDelete
  
POL_Shortcut "Tanki Online.exe" "Tanki Online" "" "" "Game;ActionGame;"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXueDpgAKCRDlMfrJqhPK
RzldAJ96lBw2k2pn1yga30kFQPSgkyRcRwCeNz79Lylr+ocAtwBG00VW52NLlwU=
=WBde
-----END PGP SIGNATURE-----
