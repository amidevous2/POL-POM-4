#!/bin/bash
# Date : (2009-09-12)
# Last revision : (2010-03-10)
# Wine version used : 1.1.40 
# Distribution used to test : Ubuntu 9.10
# Author : puk007
# Licence : Open Source

if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"

####### setup env vars #######
APP_NAME=ApexDC++
INSTALL_EXE=ApexDC*.7z
RUN_EXE=ApexDC.exe
PREFIX_NAME=$APP_NAME
WINE_VER=1.1.40
DL_LINK=http://downloads.sourceforge.net/project/apexdc/ApexDC%2B%2B/1.3.1/ApexDC%2B%2B_1.3.1_binary-x86.7z?use_mirror=kent
HOME_LINK=http://www.apexdc.net
#lng stuff
LNG_WAIT_DL="Please wait while downloading..."
LNG_WAIT_END="Click on \"Next\" during install."


####### presentation window #######
POL_SetupWindow_Init "" ""
POL_SetupWindow_presentation "$APP_NAME" "guliverkli project authors" "$HOME_LINK" "puk007" "$APP_NAME"

####### checking if p7zip is installed #######
check_one "p7zip" "p7zip"
POL_SetupWindow_missing

####### prefix stuff #######
select_prefix "$REPERTOIRE/wineprefix/$PREFIX_NAME/"
POL_SetupWindow_prefixcreate
 
####### download installer #######
cd "$WINEPREFIX/drive_c"
mkdir $APP_NAME
cd $APP_NAME

# if already there => remove it
rm -rf $INSTALL_EXE
POL_SetupWindow_download "$LNG_WAIT_DL" "Downloading..." "$DL_LINK"

POL_SetupWindow_wait_next_signal "PlayOnLinux is configurating your $APP_NAME installation ..." "Configuration"
Set_OS "winxp"
 
####### setup prefix + wine #######
POL_SetupWindow_detect_exit
POL_SetupWindow_install_wine "$WINE_VER"
 
####### install app #######
POL_SetupWindow_wait_next_signal "PlayOnLinux is installing $APP_NAME" "Installation"

# remove previous install 
rm -rf $RUN_EXE

#unpack	
p7zip -d $INSTALL_EXE
#cleanup
rm -rf $INSTALL_EXE
 
####### shortcuts #######
POL_SetupWindow_make_shortcut "$APP_NAME" "$APP_NAME" "$RUN_EXE" "" "$APP_NAME"
POL_SetupWindow_message "$APP_NAME has been installed successfully" "$APP_NAME Installation"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFIACgkQ5TH6yaoTykdwRgCfdsBl3QdKYF8VMoM9hQMPWKXu
vz0An3u7/KxODFwcfMiu9M3UZ0c4jcaD
=MSuj
-----END PGP SIGNATURE-----
