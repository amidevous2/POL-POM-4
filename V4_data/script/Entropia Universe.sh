#!/bin/bash
# Date : 2015-11-09
# Last revision : see changelog below
# Wine version used : see below
# Distribution used to test : Xubuntu 18.04 x64
# Author : Hoek (hoek@protonmail.com)  https://github.com/h0ek/POL_EntropiaUniverse
# Licence : GPLv3
# PlayOnLinux: 4.3.4
# 
#
# CHANGELOG
# [Dadu042] (2019-05-25 14:57)
#   Improve d3dx9, videodriver.
# [Dadu042] (2019-05-23)
#   Fix download URL (checksum has changed).
#   Upgrade to Wine 3.21 to fix Irsetup.exe crash (when it start running once loaded).
# [Dadu042] (2019-06-04 17:39)
#   Add POL_Install_gecko (in order to try to fix the errors in the log: 'fixme:mshtml ...')
# [Dadu042] (2020-07-17 17:00)
#   Wine 3.21 -> 5.0.1
#   Remove POL_Install_vcrun2012, POL_Install_gecko, POL_Install_d3dx9_43
#   Fix POL_Shortcut category
#   Add a second Set_OS "win7", because the game detects the OS as 'Windows server 2008 R2'.

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
  
WINEVERSION="5.0.3"
  
TITLE="Entropia Universe"
AUTHOR="Hoek"
PUBLISHER="Mindark PE AB"
PREFIX="EntropiaUniverse"
GAME_URL="http://www.entropiauniverse.com/"
       
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
       
POL_SetupWindow_Init
POL_SetupWindow_SetID 2258
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
       
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        cd "$POL_System_TmpDir"
        POL_Download "http://install2.entropiauniverse.com/entropia_universe_setup.exe"
        INSTALLER="$POL_System_TmpDir/entropia_universe_setup.exe"
fi
 
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "win7"


POL_Call "POL_Install_corefonts"

# Disabled on 2020-07-17 with Wine 5.0.1
# POL_Call "POL_Install_vcrun2012"
# POL_Call "POL_Install_gecko"
# POL_Call "POL_Install_d3dx9_43"
# POL_Call "POL_Install_d3dcompiler_43"
 
# Useful when there is 2 GPU on the same computer (ie: Intel HD + Nvidia).
POL_Call POL_Install_VideoDriver
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
       
POL_System_TmpDelete
 
Set_OS "win7"
POL_Wine_X11Drv "GrabFullScreen" "Y"
POL_Wine_X11Drv "Managed" "Y"
POL_Wine_X11Drv "Decorated" "Y"
POL_Wine_UpdateRegistryWinePair 'DllRedirects' 'wined3d' 'wined3d-csmt.dll'
POL_Shortcut "ClientLoader.exe" "$TITLE" "" "" "Game;RolePlaying;"

POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! ')" "$TITLE"
       
POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYkawuQAKCRDlMfrJqhPK
RwjlAJdadgJfZc0smIIWygrfmqagPbtPAJwPJabVl5MirHxmVdASlpPq1XjhdA==
=6p/n
-----END PGP SIGNATURE-----
