#!/bin/bash
# Date : (2009-09-01 10-30)
# Last revision : (2009-09-01 10-30)
# Wine version used : 1.1.28 
# Distribution used to test : N/A
# Author : puk007
# Licence : Open Source

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

####### setup env vars #######
APP_NAME=VSRip
INSTALL_EXE=VSRip*.zip
RUN_EXE=VSRip.exe
PREFIX_NAME=$APP_NAME
WINE_VER=1.1.28
DL_LINK=http://downloads.sourceforge.net/project/guliverkli/VSRip/VSRip%201.0.0.6/VSRip_20030530.zip?use_mirror=surfnet
HOME_LINK=http://sourceforge.net/projects/guliverkli/
#lng stuff
LNG_WAIT_DL="Please wait while downloading..."

####### presentation window #######
POL_SetupWindow_Init "" ""
POL_SetupWindow_presentation "$APP_NAME" "guliverkli project authors" "$HOME_LINK" "puk007" "$APP_NAME"


####### prefix stuff #######
select_prefixe "$REPERTOIRE/wineprefix/$PREFIX_NAME/"
POL_SetupWindow_prefixcreate
 
####### download installer #######
cd $REPERTOIRE/wineprefix/$PREFIX_NAME/drive_c
mkdir $APP_NAME
cd $APP_NAME

# if already there => remove it
rm $INSTALL_EXE
POL_SetupWindow_download "$LNG_WAIT_DL" "Downloading..." "$DL_LINK"

POL_SetupWindow_wait_next_signal "PlayOnLinux is configurating your $APP_NAME installation ..." "Configuration"
Set_OS "winxp"
 
####### setup prefix + wine #######
POL_SetupWindow_detect_exit
POL_SetupWindow_install_wine "$WINE_VER"
 
####### install app #######
POL_SetupWindow_wait_next_signal "PlayOnLinux is installing $APP_NAME" "Installation"
 
unzip $INSTALL_EXE
#cleanup
rm -rf $INSTALL_EXE
 
####### shortcuts #######
POL_SetupWindow_make_shortcut "$APP_NAME" "$APP_NAME" "$RUN_EXE" "" "$APP_NAME"
POL_SetupWindow_message "$APP_NAME has been installed successfully" "$APP_NAME Installation"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFIACgkQ5TH6yaoTykfYTQCgqfweNHSwBxwDJML4scBHZQnH
h2wAn09kbM40UJCKXQf5wMQ+dClwPhJ9
=i7K0
-----END PGP SIGNATURE-----
