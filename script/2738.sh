#!/usr/bin/env playonlinux-bash
# Date : (2016-02-18 15-00)
# Last revision : see changelog
# Wine version used : see script
# Distribution used to test : Xubuntu 18.04.4 amd64
# Author : DoctorJohn
#
#
# TESTED Editions: release 221 II (2019-08) according the launcher, but 'release234_7 32bits' appear at the bottom left of the main menu.
#
# Middlewares used by this software : Direct X 9, fmod, QT v4, dotnet40, dotnet20.
#
#
# CHANGELOG
# [DoctorJohn] (2016-02-18 15-00)
#   First script (I have Wine 4.0.3).
# [Dadu042] (2020-01-02)
#   Wine 1.7.39 (outdated) -> 3.0.3
# [Dadu042] (2020-05-30 16-00)
#   Wine 3.0.3 -> system (it's 5.0 currently)
#   Fix "$PREFIX" (missing ")
#   Replace POL_Wine_VMS (outdated).
#   Repair download link.
# [Dadu042] (2020-05-31 16-00)
#   Disable Nvidia Physx (for test about mouse cursor).
# [Dadu042] (2020-06-04 16-00)
#   Add loading argument: -d3d9
#
#
# KNOWN ISSUES :
#  - Wine x86 3.20, 4.0.4, 4.12.1, 4.14-staging, 4.14, 4.21, 5.0, 5.7: the mouse cursor of the game does not move (however mouse does work). Tried: set 'classic cursor' in the game's options, arguments: -windowed -noborder -d3d9. Tried: d3dx9_43 + compiler, vcrun2010, dotnet20.
#
#
# KNOWN ISSUES (FIXED):
#  - Wine x86 4.0.4, 5.0: X


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Drakensang Online"
PREFIX="DrakensangOnline"
GAME_VMS="256"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Bigpoint" "http://www.drakensang.com/" "DoctorJohn" "DrakensangOnline"
 
POL_RequiredVersion "4.1.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_System_TmpCreate "$PREFIX"
 
 
#
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
 
# Fetching PROGRAMFILES environmental variable
POL_LoadVar_PROGRAMFILES
 
# Set system architecture to 32bit 
POL_System_SetArch "x86"
 
# Set windows version to windows 7
Set_OS "win7"

# Useless (2020-05, Wine > v3)
# Set_Desktop "On" "1024" "768"
# POL_SetupWindow_message "You may have to resize the virtual desktops size under your wine/graphics settings.\nBy default we set it to 1024x768." "$TITLE"


#######################################
#  Installing mandatory components    #
#######################################

POL_Call POL_Install_d3dx9_43
POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_d3dx9
 
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma

              
################
#      GPU     #
################
          
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
           
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
            
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx

#######################################
#  Main part of this script           #
#######################################

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

POL_SetupWindow_message "IMPORTANT:\n#1 At the end of the installation, unselect 'Run Drankensang Online'.\n#2 You will probably see the error 'Certificate import failed: Unable to add certificate to certificate store', just ignore it." "$TITLE"


if [ "$INSTALL_METHOD" = "LOCAL" ]
then
        POL_SetupWindow_browse "Please select: dro_setup.exe" "$TITLE"
        INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        cd "$POL_System_TmpDir"
        POL_Download "https://drasaonline-481-dwl.bpsecure.com/applet/dro_setup.exe"
        INSTALLER="$POL_System_TmpDir/dro_setup.exe"
fi
POL_SetupWindow_wait "Installation in progress." "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitBefore "$TITLE"
 
#
POL_Shortcut "thinclient.exe" "$TITLE" "" "-d3d9" "Game;RolePlaying;"
POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXuOZ0QAKCRDlMfrJqhPK
R9ciAKCDvXQ5t6OK2519ZRFZzWTGg7ChNgCdGgQy/GBrCz4JVepyvfHdKF37hbY=
=fCMK
-----END PGP SIGNATURE-----
