#!/bin/bash
# Date : (2014-10-29 11-00)
# Last revision : (2014-10-29 11-00)
# Wine version used : wine-1.6.2
# Distribution used to test : Ubuntu 14.04.1 LTS
# Author : SKAL
# Last Ver : 1.01
# Changelog
# 2.00 implemented dowload part
# 1.02 Some minor changes, thank you Ronin DUSETTE
# 1.01 Set the virtual desktop AUTOMATICALY, started use translation system
#      left the POL_System_TmpCreate part for a future dowload feature
# 1.0 first release
#
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"


# Variables

TITLE="Sonos"
PREFIX="SonosPlayer"
BIN="SonosDesktopController511.exe"
#WINEVERSION=""
 
POL_SetupWindow_Init
 
# enable debug
POL_Debug_Init
 
# presentation program
POL_SetupWindow_presentation "$TITLE" "Sonos Inc." "http://www.sonos.com" "SKAL" "$PREFIX"
 


 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
POL_System_TmpCreate "$PREFIX"

# Virtual Disc configuration

POL_System_SetArch "x86"
Set_OS "winxp"

# Install dotnet40 
POL_Call POL_Install_dotnet40

# Presentation
POL_SetupWindow_message "$(eval_gettext 'At the end of the installation DO NOT EXECUTE THE PROGRAMM AUTOMATICALY!!')" "Sonos installation"

# POL_SetupWindow_message "$(eval_gettext 'You can download the Sonos windows client at the following link \n\nhttp://www.sonos.com/redir/controller_software_pc \n\nAt the end of the installation DO NOT EXECUTE THE PROGRAMM AUTOMATICALY!!')" "Sonos installation"

# Choose Installation type
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "$BIN"
    POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
    POL_Wine "$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    # Download the file
    POL_Download "http://www.sonos.com/redir/controller_software_pc"
    POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
    POL_Wine "$BIN"
fi

# Set display 
Set_Desktop On 1024 768 
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.\nIf you do not like the resolution used, you can change it in the “Graphics” tab of the wine configuration panel after the installation')" "Last Warning"
 
POL_System_TmpDelete

  
POL_Shortcut "Sonos.exe" "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRUvz0ACgkQ5TH6yaoTykesMACgoVs8IklpBXLi8Lizzjnq/Z+m
KeUAnibXFemrJBLQSPLsHjNscG4r5r69
=vLaZ
-----END PGP SIGNATURE-----
