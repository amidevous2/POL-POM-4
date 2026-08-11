#!/bin/bash
# Date : (2017-02-15)
# Distribution used to test : Ubuntu 16.04 64 bit
# Author : Lukonin Kirill
# Licence : GPLv3
# PlayOnLinux: 4.2.9
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
PREFIX="Nextion"
WINEVERSION="1.8-staging"
TITLE="Nextion Editor"
EDITOR="ITEAD Studio"
AUTHOR="Lukonin Kirill"
LINK="http://dl.itead.cc/Nextion/nextion-setup-v043.zip"
MD5="97cd776536437a9b59421019092200f0"
#Initialization
POL_SetupWindow_Init
POL_Debug_Init
  
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$AUTHOR" "$PREFIX"
    
POL_SetupWindow_message "$(eval_gettext 'IMPORTANT: This program may work not well on Linux. Be careful.You also need to run command with SUDO. Please follow the instructions. Use middle mouse button to copy-paste terminal text')" "$TITLE"

# Just a solution to install dotnet30 clearly  
POL_Call POL_Function_RootCommand "echo 0|sudo tee /proc/sys/kernel/yama/ptrace_scope; exit"
  
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "win7"
  
# Component_inslallation
POL_Call POL_Install_corefonts
Set_OS "win7"
POL_Call POL_Install_dotnet45
Set_OS "winxp"
POL_Call POL_Install_ie8
  
  
# Installing software
POL_System_TmpCreate "$PREFIX"
mkdir ~/.PlayOnLinux/wineprefix/Nextion/drive_c/Nextion
cd "$POL_System_TmpDir"
POL_Download "$LINK" "$MD5"
unzip nextion-setup-v*.zip
mv -f Nextion\ Editor ~/.PlayOnLinux/wineprefix/Nextion/drive_c/Nextion

# Making USB_Serial to work. 5 adapters ought to be enough for anybody =)))
ln -s /dev/ttyUSB0 ~/.PlayOnLinux/wineprefix/Nextion/dosdevices/com0
ln -s /dev/ttyUSB1 ~/.PlayOnLinux/wineprefix/Nextion/dosdevices/com1
ln -s /dev/ttyUSB2 ~/.PlayOnLinux/wineprefix/Nextion/dosdevices/com2
ln -s /dev/ttyUSB3 ~/.PlayOnLinux/wineprefix/Nextion/dosdevices/com3
ln -s /dev/ttyUSB4 ~/.PlayOnLinux/wineprefix/Nextion/dosdevices/com4

 
# Delete TMP folder
POL_System_TmpDelete
  
# Create Shortcuts
POL_Shortcut "Nextion Editor.exe" "$TITLE"
         
POL_SetupWindow_Close
exit 0 

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNWx+QAKCRDlMfrJqhPK
R0U0AJ0Yz+liq2bs1ivtv2W3BIPokNZvhwCgr0keJva/6RATb3nRPJCDY92/3zw=
=lQcx
-----END PGP SIGNATURE-----
