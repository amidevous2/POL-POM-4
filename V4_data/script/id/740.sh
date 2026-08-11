#!/bin/bash
# Date: (2010-11-15 05-00)
# Last revision: (2010-11-17 07-50)
# Wine version used: 1.3.5
# Distribution used to test: Ubuntu 10.10 x64
# Author: Benj
# Licence: Retail
 
[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="EverQuest II Sentinel's Fate"
WORKING_WINE="1.3.5"
PREFIX="eq2"
COMPANY="Sony Online Entertainment"
COMPANY_SITE="http://everquest2.com/"
DOWNLOAD_SITE="http://download.station.sony.com/patch/download/eq2/eq2-us.zip"

#starting the script
cd $REPERTOIRE/tmp
rm *.jpg
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/eq2-sf/top.jpg" "http://files.playonlinux.com/resources/setups/eq2-sf/left.jpg" "$TITLE"
POL_SetupWindow_InitWithImages

POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$SITE" "Benj" "$PREFIX"

#Install correct version of Wine
POL_SetupWindow_install_wine "$WORKING_WINE"
Use_WineVersion "$WORKING_WINE"

#set the prefix
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

#set the Program Files variable
POL_LoadVar_PROGRAMFILES

#installer shortcuts will point to system wine, not POL version.
POL_SetupWindow_message "Please note that this game requires a subscription.\nThis script will only install EverQuest II,\n it will not give you a paid subscription.\n\nDo not install shortcuts with the installer.\nThose shortcuts will break EverQuest II\nand correct ones will be setup later." "Note about subscriptions/shortcuts" "$PLAYONLINUX/themes/tango/warning.png"

#download the installer
cd $REPERTOIRE/tmp
POL_SetupWindow_download "Please wait while EverQuest II is downloading" "Downloading" "$DOWNLOAD_SITE"

#extract and run the installer
POL_SetupWindow_pulsebar "Installing EverQuest II" "Installing"
POL_SetupWindow_set_text "Extracting installer"
unzip eq2-us.zip
POL_SetupWindow_pulse 50
POL_SetupWindow_set_text "Installing EverQuest II"
wine ./EQ2.exe
POL_SetupWindow_detect_exit
POL_SetupWindow_pulse 100

#check that installation was successful
POL_SetupWindow_message "Press forward only when installation is fully complete." "Confirmation of Installation"

#PlayOnMac Configuration
if [ "$PLAYONMAC" = "" ]; then
echo "r_font_ft 0" >> "$REPERTOIRE/wineprefix/$PREFIX/drive_c/$PROGRAMFILES/Sony/EverQuest II/eq2.ini"
fi
[ "$PLAYONMAC" == "" ] || Set_Managed "Off"

#Create shortcut
POL_SetupWindow_auto_shortcut "$PREFIX" "EQ2.exe" "$TITLE" "$TITLE.png" ""

#assign the correct version of wine
Set_WineVersion_Assign "$WORKING_WINE" "$TITLE"

#remove installation files
clean_tmp

#Success message
POL_SetupWindow_Message "EverQuest II Sentinel's Fate has successfully installed.\nClick forward to close the window." "Installation Successful"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEMACgkQ5TH6yaoTykcongCgrTRghNbjvw27jWaHER3Ls3gr
v7kAn1Em526nqAKQibwGk2j/oQJfqszD
=27m0
-----END PGP SIGNATURE-----
