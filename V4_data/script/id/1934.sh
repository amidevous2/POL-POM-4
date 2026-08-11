#!/bin/bash
# Date : (2014-02-05 20-47)
# Wine version used : 1.7.11 x86
# Distribution used to test : Ubuntu 13.10 x86_64
# PlayOnLinux : 4.2.2
# Author : Joseph Hersey
  
# CHANGELOG
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="Wizard101"
TITLE="Wizard 101"
EDITOR="KingsIsle Entertainment, Inc."
GAME_URL="https://www.wizard101.com"
AUTHOR="Joseph Hersey"
  
# Initialization
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1934
POL_Debug_Init
  
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
# Create Prefix
POL_System_SetArch "x86" # Game crashes if installed with x86_64
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
 
# Installation - Determine if user wants to download or use a local copy.
 
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD" # Choose method of installation
 if [ "$INSTALL_METHOD" = "LOCAL" ]
    then
     POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE" # Browse for File
  
     POL_Wine_WaitBefore "$TITLE"
     POL_Wine "$APP_ANSWER" # Install Application
  
 elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
    then
     POL_System_TmpCreate "$PREFIX" # Create temp folder
     cd "$POL_System_TmpDir"
     POL_Download "https://www.wizard101.com/downloadGame/OtherDownload" # Download the installer
     mv OtherDownload InstallWizard101.exe # Sometimes you get a feature transfer error if you do not rename this file to an .exe
 
     POL_Wine_WaitBefore "$TITLE"
     POL_Wine "InstallWizard101.exe" # Install Application

     POL_System_TmpDelete # Delete Temp Directory
fi
  
# Create Shortcuts
POL_Shortcut "Wizard101.exe" "$TITLE" "" "" "Game;RolePlaying;"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMJUdUACgkQ5TH6yaoTykdVIwCfQSmIpo6N6SFs3jdd/rzhKill
RjsAoKKVGjcI8fori9flMkIJmqnze0ml
=c5Uk
-----END PGP SIGNATURE-----
