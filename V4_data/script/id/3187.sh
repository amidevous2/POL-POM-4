#!/bin/bash
# Date conv:yy-mm-dd
# Date : (2017-06-04)
# Last revision : (2017-07-18)
# Wine version used : 2.12-staging
# Distribution used to test : -
# Author : ImperatorS79
# Licence : Retail
# Only For : http://www.playonlinux.com

#
# CHANGELOG:
# [ImperatorS79] (2017-06-04)
#   First script.
#   # Begin Note ##
#   see https://www.youtube.com/watch?v=SOSbKWvF1iM and https://appdb.winehq.org/objectManager.php?sClass=version&iId=32974
#   Not from me, but inspired this script, it's a kind of test...
#   Script inspired from AC2 script
#   # End Note ##
#
# [ImperatorS79] (2017-07-18)
#   ?
# [Dadu042] (2019-12-24)
#   Wine 2.12-staging -> 2.22


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="The Witcher 3 : Wild Hunt"
PREFIX="WItcher3"
EDITOR="CD Projekt Red"
GAME_URL="http://thewitcher.com/en/witcher3"
AUTOR="ImperatorS79"
WORKING_WINE_VERSION="2.22"
GAME_VMS="1536"
    
# Starting the script
#POL_GetSetupImages "undefined" "undefine" "$TITLE"
POL_SetupWindow_Init
   
POL_SetupWindow_message "$(eval_gettext 'DirectX11 is still partially supported by Wine, \n
so a lot of graphical glitches can occur during the use of this software !\n (Note: Disable Nvidia Hairworks  Alpha Script -> D3D11 ). ')" "$TITLE"

# Starting debugging API
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTOR" "$PREFIX"
    
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
    
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
    
#DVD maybe later
POL_SetupWindow_InstallMethod "STEAM"
    
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        STEAM_ID="292030"
fi
   
#Not sure if it's needed
#POL_Call POL_Install_physx
   
POL_SetupWindow_VMS "$GAME_VMS"
  
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver
   
# Begin game installation
   
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
        POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
fi
   
POL_SetupWindow_message "From appdb wine site : \n\n
   
To avoid having low framerate, make sure you have buffer pool patch from Wine staging, and you don't have colliding CSMT and threaded dispatch.\n\n
   
For Nvidia blob:
   
you'd probably need to set:
__GL_THREADED_OPTIMIZATIONS=0\n\n
   
For Mesa:
   
threaded dispatch is off by default.\n\n
   
Check your GPU against minimal requirements : Low framerate can be simply caused by having an older GPU. Official Nvidia minimum requirement if GTX 660." "Low Framerate Problem"
   
   
POL_SetupWindow_message  "From appdb wine site : \n\n
Setting in registry, to enable OpenGL 4.5 for DirectX 11 detection\n\n
   
REGEDIT4\n
[HKEY_CURRENT_USER\Software\Wine\Direct3D] \n
DirectDrawRenderer=opengl\n
UseGLSL=enabled\n
MaxVersionGL=dword:00040005" "Enabling OpenGL 4.5 for DirectX 11 detection"
     
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgHivQAKCRDlMfrJqhPK
R39GAJ9ISmbrC4NffSPSwk2gm4ilunpEbACgq2lDHAL1isP7xVLjt675Z8FKz3s=
=Vw9I
-----END PGP SIGNATURE-----
