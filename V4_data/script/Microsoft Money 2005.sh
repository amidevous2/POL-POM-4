#!/bin/bash
# Last revision : (2013-06-09 14-38)
# Tested : Debian 6.0, Mac OSX
# Author : Tinou
# Script licence : GPLv3
#
# This script is designed for PlayOnLinux and PlayOnMac.

# CHANGELOG
# [SuperPlumus] (2013-06-09 14-38)
#   gettext

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Microsoft Money 2005"

POL_Debug_Init
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Microsoft" "http://www.microsoft.com/" "Tinou" "Money205"


#Preparation de Wine
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "Money2005"
POL_Wine_PrefixCreate "1.4.1"


POL_SetupWindow_InstallMethod LOCAL,CDROM
if [ "$INSTALL_METHOD" = "CD" ]
then
POL_SetupWindow_cdrom
[ -e "$CDROM/install.exe" ] && cdFile="install.exe" || cdFile="setup.exe"
POL_SetupWindow_check_cdrom "$cdFile"
wFile="$CDROM/$cdFile"
else
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
wFile="$APP_ANSWER"
fi

POL_Call POL_Install_ie6
POL_SetupWindow_wait "Installing $TITLE" "$TITLE"
POL_Wine "$wFile"
POL_Wine_WaitExit

#CREATION LANCEUR
POL_Shortcut "msmoney.exe" "$TITLE"
POL_Shortcut_InsertBeforeWine "$TITLE" "wineserver -k"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlSGOEkACgkQ5TH6yaoTykclZACfaa0NK7b9mP2vVOdK0ZgRXBHZ
bCMAmgMdSRHx9ucVq2GU+WKln0SUUJz/
=mXjN
-----END PGP SIGNATURE-----
