#!/bin/bash
# Date : (2020-01-30) 
# Last revision : see changelog
# Distribution used to test : MacOS Mojave 10.14
# Author 	: Dao Duy Tung
# PlayOnMac	: 4.3.4
#
# CHANGELOGS
# [Dao Duy Tung] (2020-01-30) 
# Disable method DOWNLOAD
# Removed dotnet30
#
# [Dao Duy Tung] (2020-02-02 19:00)
# Removed: dotnet20, dotnet40, msxml6
# Added: gecko, vcrun2005, vcrun2012, vcrun2013, vcrun2015
# Wine 3.0.3 -> 2.20 
# Windows 10 -> 7
#
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="WarpPLS 7"
PREFIX="TungDaoWarpPLS"
WORKING_WINE_VERSION="2.20"
OSVERSION="win7"

EDITOR="Ned Kock"
WEB_URL="http://www.warppls.com"
# DOWNLOADURL=""
# SETUPFILE=""
SHORTCUTFILENAME="WarpPLS_7_0.exe"
AUTHOR="Dao Duy Tung"
# PERSONALBLOG="https://tungdao.org"

 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$WEB_URL" "$AUTHOR" "$PREFIX"
 

POL_RequiredVersion "2.20" || POL_Debug_Fatal "Sorry, $APPLICATION_TITLE 2.20 is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_System_TmpCreate "$PREFIX"

# Installation
Set_OS "$OSVERSION"

POL_Call POL_Install_gecko
POL_Call POL_Install_corefonts
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_vcrun2012
POL_Call POL_Install_vcrun2013
POL_Call POL_Install_vcrun2015

 
cd "$POL_System_TmpDir"
 
if [ "$POL_SELECTED_FILE" ]; then
    SetupFile="$POL_SELECTED_FILE"
else
# POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
    INSTALL_METHOD="LOCAL"
    
    if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        POL_Download "$DOWNLOADURL" ""
        SetupFile="$POL_System_TmpDir/$SETUPFILE"
    elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SetupFile="$APP_ANSWER"
    fi
fi
 

POL_SetupWindow_wait "Installation in progress." "$TITLE installation"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupFile"
POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete
 
POL_Shortcut "$SHORTCUTFILENAME" "$TITLE"
POL_SetupWindow_message "Your application has been installed successfully." "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjb89QAKCRDlMfrJqhPK
RxCYAJ4xdT+yVPIvTf49t6KACFLoK3WVrgCePIFy/tysX3KsFz50qaCDj8/crdc=
=uxYx
-----END PGP SIGNATURE-----
