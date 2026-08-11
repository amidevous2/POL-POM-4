#!/bin/bash
# Date : (2017-09-05 00-59)
# Last revision : (2017-10-05 09-51)
# Wine version used : 2.7 Staging
# Distribution used to test : Ubuntu 14.04.02 LTS
# Author : NoyTheBiche
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
TITLE="WiiUSBHelper"
PREFIX="wiiusbhelper"
WINEVERSION="2.6-staging"
EDITOR="Hikari06"
GAME_URL="http://www.wiiusbhelper.com"
AUTHOR="NoyTheBiche"
   
# Download images for installation script
POL_GetSetupImages "http://img4.imagetitan.com/img4/small/14/14_logo_wii_uusb_herper.png" "http://img4.imagetitan.com/img4/small/14/14_logo_wii_uusb_herper.png" "$TITLE"
   
# Initialize the script, debugging
POL_SetupWindow_Init
POL_SetupWindow_SetID 1858
POL_Debug_Init
   
# Setup presentation window
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
   
# Begin setting up the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
   
# Install .NET Framework 4.5 and others stuffs.
POL_Call POL_Install_msxml3
POL_Call POL_Install_dotnet30
POL_Call POL_Install_dotnet30sp1
POL_Call POL_Install_dotnet45
   
# Create and select the required directory for the updater
mkdir "$WINEPREFIX/drive_c/$PROGRAMFILES/wiiusbhelper"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/wiiusbhelper"
   
# Download the updater
POL_Download "http://application.wiiuusbhelper.com/Updater.exe"
   
# Run the updater
POL_SetupWindow_message "$(eval_gettext 'Now, the program will start, just configure your Region and then, close the app! don't use the app!')" "$TITLE"
   
POL_Wine Updater.exe
   
# Wait for the updater to finish in order to create a shortcut of the executable
POL_Wine_WaitExit "$TITLE"
   
POL_Shortcut "Updater.exe" "WiiUSBHelper" "logo2T.png.ico"
   
# Download the fonts required for Japanese characters support
POL_SetupWindow_question "Install additional fonts for Japanese characters support?" "$TITLE"
   
if [ "$APP_ANSWER" = "TRUE" ]
then
    cd "$WINEPREFIX/drive_c/windows/Fonts"
    POL_Download "http://www.boaty.org/POL/msgothic.ttc" "1f162793323e204a0d598a9aa4241443"
    POL_Download "http://www.boaty.org/POL/msmincho.ttc" "ea3f8835f67b492a0740ac34e1e807f8"
fi
  
# Send a congratulations message
POL_SetupWindow_message "$(eval_gettext 'You can now use WiiUSBHelper!')" "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNVjJQAKCRDlMfrJqhPK
R5WyAJ4ln5cpBkUec3z7QTt7VpVSyWfSyACgsvKw2eriC53QAlJeNzOAn54qFWU=
=L+AR
-----END PGP SIGNATURE-----
