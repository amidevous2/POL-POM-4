#!/bin/bash
# Date : 2017/01/14 14:30
# Last revision : see changelog
# Wine version used : system
# Distribution used to test : Xubuntu 18.04 x64
# Author : muk04
# Licence : GPLv3
# WineHQ: https://appdb.winehq.org/objectManager.php?sClass=application&iId=15675
#
# CHANGELOG:
# [muk04] (2017-01-14)
#     First version.
# [Dadu042] (2019-08-02)
#   Disable Wine-2.0-rc3, use OS's Wine version.
#   Disable checksum checking.

 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="HEX: Shards of Fate"
PREFIX="HexShardsOfFate"
 
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
  
POL_SetupWindow_Init
 
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Cryptozoic Entertainment" "http://en.hex.gameforge.com/" "muk04" "$PREFIX"
  
POL_System_TmpCreate "$PREFIX"
  
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
  
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    cd "$HOME" || exit
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "Windows Executables (*.exe)|*.exe;*.EXE"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    DOWNLOAD_URL="http://dl.hextcg.com/HexInstaller.exe"
    DOWNLOAD_FILE="$POL_System_TmpDir/$(basename "$DOWNLOAD_URL")"
#    DOWNLOAD_MD5="2625969b2446de0886209a8157e4362c"
 
#    POL_Call POL_Download_retry "$DOWNLOAD_URL" "$DOWNLOAD_FILE" "$DOWNLOAD_MD5" "$TITLE"
    POL_Call POL_Download_retry "$DOWNLOAD_URL" "$DOWNLOAD_FILE" "" "$TITLE"
 
    INSTALLER="$DOWNLOAD_FILE"
fi
  
POL_Wine_SelectPrefix "$PREFIX"

# POL_Wine_PrefixCreate "2.0-rc3"
POL_Wine_PrefixCreate
 
POL_Wine_SetVideoDriver
  
POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
 
POL_Wine "$INSTALLER"
  
POL_System_TmpDelete
 
POL_Shortcut "HexPatch.exe" "$TITLE" "" "" "Game;CardGame;"
  
POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUR44gAKCRDlMfrJqhPK
RwiLAJ4kB6JFgzbhBmD6U/pGdD7LYKt9cACeIAkSMSeKIfgrWBBBQhHeadcAgKs=
=2HSc
-----END PGP SIGNATURE-----
