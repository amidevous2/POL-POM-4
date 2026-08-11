#!/bin/bash
# Date : (2018-05-02)
# Distribution used to test : Ubuntu 16.04 64 bit
# Author : Lukonin Kirill
# Authors email: klukonin@gmail.com
# Licence : GPLv3
# PlayOnLinux: 4.2.10
   
# CHANGELOG
# [Lukonin Kirill] (2018-05-02)
#   First script, for v0.43.
# [...]
#    ...
# [Dadu042] (2019-11-02)
#   - Disable feature 'install from download' (because the file get many updates).
#   - Add feature 'install from local'.
#   - Add POL_RequiredVersion
# [Dadu042] (2019-11-02 11:35)
#   - Forgot something.
# [Lukonin Kirill] (2020-03-14)
#   - Switched to the latest LTS version
# [Lukonin Kirill] (2020-03-14)
#   - Fix link error
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
PREFIX="Nextion"
WINEVERSION="3.2-staging"
TITLE="Nextion Editor LTS"
EDITOR="ITEAD Studio"
AUTHOR="Lukonin Kirill"
# LINK="http://nextion.tech/download/nextion-setup-vLTS.zip"
# MD5="40310249637429eea821b28db614a2be"
   
#Initialization
POL_SetupWindow_Init
POL_Debug_Init
    
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$AUTHOR" "$PREFIX"
   
POL_SetupWindow_message "$(eval_gettext 'IMPORTANT: This program may work not well on Linux. Be careful.\nThis script is tested with Nextion v0.53')" "$TITLE"
   
# Note: POL 4.2.12 support Wine up to 3.0.3 max (as of 2019-11)
POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
    
# Just a solution to install dotnet30 clearly
POL_SetupWindow_question \
"Nextion software is based on dotnet platform and requires Dotnet4.5 to be \
installed. However, Dotnet4.5 installation is possible only after Dotnet3.0 \
and because of the issue with Dotnet3.0 installer on Linux, we need to play \
with ptrace_scope kernel parameter and make it through SUDO command \
'echo 0|sudo tee /proc/sys/kernel/yama/ptrace_scope'. This parameter willl be \
changed to default after reboot so it is recommended to reboot your PC after \
installation. If you don't know about this issue, plesae click 'YES' and \
follow the instructions. If you know about this issue or did it already or you \
want to do this yourself, please click 'NO'" "Ptrace tuning for debian/ubuntu"
if [ "$APP_ANSWER" == "TRUE" ]
        then
                POL_Call POL_Function_RootCommand "echo 0|sudo tee /proc/sys/kernel/yama/ptrace_scope; exit"
fi
    
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "win7"
    
# Component_inslallation
POL_Call POL_Install_corefonts
POL_Call POL_Install_dotnet45
Set_OS "winxp"
POL_Call POL_Install_ie8
    
# Installing software
POL_System_TmpCreate "$PREFIX"
mkdir ~/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Nextion
   
cd "$POL_System_TmpDir"
   
# POL_Download "$LINK" "$MD5"
# unzip nextion-setup-v*.zip -d NextionEditor
# mv -f NextionEditor ~/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Nextion
   
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file (.EXE) to run')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
  
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
    
# You need to add you current user to appropriate groups for normal work with USB serial adapters
POL_SetupWindow_question \
"It is necessary to give access rights and add your current user to the \
dialout/serial group for proper USB serial adapter work. If this is your first \
installation or you have no information about your user rights, please click \
'YES' and reboot your PC after installation. If you did this already or you \
want to do it yourself with 'sudo usermod -aG dialout,serial $(whoami)' \
command, please click 'NO'" "USB serial adapter tuning"
if [ "$APP_ANSWER" == "TRUE" ]
        then
                POL_Call POL_Function_RootCommand "sudo usermod -aG dialout,serial $(whoami); exit"
fi
    
POL_SetupWindow_message \
"You can see current 'COM' links by running \
'ls -al ~/.PlayOnLinux/wineprefix/Nextion/dosdevices/com*' in the \
command-line. If you want change existing configuration you can do it as \
described here: 'https://wiki.winehq.org/index.php?title=Wine_User%27s_Guide&oldid=2519#Serial_and_Parallel_Ports'" \
"USB serial adapter tunung"
   
# Create Shortcuts
POL_Shortcut "NextionEditor.exe" "$TITLE"
   
# Delete TMP folder
POL_System_TmpDelete
   
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYE4NDQAKCRDlMfrJqhPK
R41PAKCdkKWo4fnOqikYWfFYlyywBbRfagCY1cBqQdgc8yd1esoLj89hNyujcg==
=a2WC
-----END PGP SIGNATURE-----
