#!/bin/bash
# Date : (2014-08-19 19:41)
# Last Revision : see changelog
# Wine Version used : see changelog
# Distribution used to test : Void Linux
# Author: Hoshpak
# Script license : GPL v2
# Programm license : Retail
# Depend :
#
# CHANGELOG
# [Hoshpak] (2014-08-19 19:41)
#   Initial script, for the GOG release.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.8.4 -> 2.22
#   Add POL_System_SetArch "x86"
# [Dadu042] (2020-05-23) with setup_risen_2.0.0.6.exe
#   Wine 2.22 -> 4.0.4
#
# KNOWN ISSUES :
#  - Wine x86 2.22, 3.0.3, 4.0.4, 5.0: no intro videos displayed.
#
#
# KNOWN ISSUES (FIXED):
#  - Wine x86 2.22, 3.0.3, 4.0.4, 5.0: game fail to start (nothing appears, or only a black screen). Ubuntu 20.04.
#    Debug log: 
#    0009:fixme:d3dcompiler:compile_shader Compilation target "fx_2_0" not yet supported
#    0009:fixme:d3dx:d3dx9_effect_init Failed to parse effect, hr 0x8876086c.
#    Fix: d3dx9_29.

 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="risen"
PREFIX="Risen_gog"
WORKING_WINE_VERSION="4.0.4"
TITLE="GOG.com - Risen"
GAME_VMS="256"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Piranha Bytes" "http://www.gog.com/game/$GOGID" "Hoshpak" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Call POL_GoG_setup "$GOGID"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "winxp"

################
#      GPU     #
################
         
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
          
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
           
# Useful for Nvidia GPUs
POL_Call POL_Install_physx

 
#######################################
#  Installing mandatory dependencies  #
#######################################

# To avoid the issue 'can not run, black screen as soon as launched'.
POL_Call POL_Install_d3dx9_29

# Seems useless
# POL_Call POL_Install_d3dcompiler_43

#######################################
#  Main part                          #
#######################################
 
POL_Call POL_GoG_install

 
# Configure the shortcut
GOGPATH="$GOGROOT/Risen"
POL_Shortcut "Risen.exe" "Risen" "" "" "Game;RolePlaying;"
POL_Shortcut_Document "Risen" "$GOGPATH/Risen - Manual.pdf"



POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXszRmgAKCRDlMfrJqhPK
R+K0AJ41gVuq0gNJpTtu7jgtiSSoxmTZbQCfZkL3rDZs08BjQXygBkGfyEzMNV4=
=dMz7
-----END PGP SIGNATURE-----
