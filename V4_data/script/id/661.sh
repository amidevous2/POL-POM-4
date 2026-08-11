#!/bin/bash
# Date : (2018-02-02 12:48)
# Last revision : (2018-12-09 23:24)
# Wine version used : 3.19-staging
# Distribution used to test : Ubuntu 18.04 x64
# Author : LinuxScripter
# Licence : Retail
    
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="StarCraft II"
EDITOR="Blizzard"
AUTHOR="LinuxScripter"
GAME_URL="http://eu.battle.net/sc2/en/"
PREFIX="StarCraft2"
WORKING_WINE_VERSION="3.19-staging"
    
# Starting the script
    
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/starcraft2_wol/top.jpg" "http://files.playonlinux.com/resources/setups/starcraft2_wol/left.jpg" "$TITLE"
   
POL_SetupWindow_Init
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
    
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
    
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Needed for Battle.net
POL_Call POL_Install_corefonts
POL_Call POL_Install_vcrun2015

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
  
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
  
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
   
POL_SetupWindow_message "$(eval_gettext 'If you choose to install the DVD version you have to exit the installer after the instalation is done. The old patcher app does not work at all in wine. The script will terminate any .exe proceses in case you forgot. Then a patch will be downloaded. You will continue the update process through Blizzard App rather than build-in patcher./nYou will also have to use DNSProxy or else your profile will not load and all ""Play"" buttons will be unclickable/grayed out. Either that or remove the content of ""$WINEPREFIX/drive_c/ProgramData/Blizzard\ Entertainment/Battle.net/Cache/"" and kill Agent.exe/nSetting your graphics above medium might result in a crash when loading a level.')"
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,LOCAL"
    
if [ "$INSTALL_METHOD" == "DVD" ]; then
    # Asking for CDROM and checking if it's correct one
    POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
    POL_SetupWindow_cdrom
    POL_Call POL_Sudo_UnhideCdrom
    POL_SetupWindow_check_cdrom "Starcraft II Installer.app/Contents/Info.plist"
    POL_Wine start /unix "$CDROM/Installer.exe"
    POL_Wine_WaitExit "$CDROM/Installer.exe"
    [$(ps aux | grep -c *.exe) -lt 2] || killall *.exe
    cd "$POL_System_TmpDir"
    POL_Download "https://megagames2.online/downloads.php?file=sc2-1.4.2-enUS.exe&646965504532567d5954262e5a=1"
    POL_Wine start /unix "sc2-1.4.2-enUS.exe"
    POL_Wine_WaitExit "sc2-1.4.2-enUS.exe"
else
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
    POL_Wine start /unix "$SETUP_EXE"
    POL_Wine_WaitExit "$TITLE"
fi
 
# Making shortcut
POL_Shortcut "$WINEPREFIX/drive_c/Program Files/Battle.net/Battle.net.exe" "Battle.net($TITLE)" "" ""
    
if [ "$INSTALL_METHOD" = "DVD" ]; then
        POL_Call POL_Sudo_RehideCdrom
fi
    
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlxexToACgkQ5TH6yaoTykeSwgCfaceSdORaZG4jLu92I4q6N7m/
te4An3SThOLUIvMx5lD6iYiDnHVwOnNO
=ZotI
-----END PGP SIGNATURE-----
