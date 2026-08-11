#!/bin/bash
# Date : (2020-01-25 22-29)
# Last revision : see changelog
# Distribution used to test : Ubuntu 18.04 bionic
# Author : TheBallOfAeolus
# Licence : GPLv3
# PlayOnLinux: 4.3.4
#
# CHANGELOG
# [TheBallOfAeolus] (2019-11-11 15-30)
#   Initial script.
# [TheBallOfAeolus] (2019-11-16 21-44)
#   I have modified the script and added mp10, riched20 and wmpcodecs, I was having issues with some notifications
#   and by adding those, everything is fine.
#   I am not sure which one is the one that actually fixed it, but now everything is working :P
# [Dadu042] (2020-01-21 09:50)
#   Wine 4.19 -> 4.21 (latest and perhaps final).
# [TheBallOfAeolus] (2020-01-25 22-29)
#   The latest version of KakaoTalk is not supporting Windows 2008 anymore, updating the configs to Windows 10
# [Dadu042] (2020-02-10 16:20)
#   Add POL_RequiredVersion.
#   Add category to POL_Shortcut.
# [kladess] (2020-09-02 01:15)
#  Wine 4.21 -> 5.0.2 (stable)
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
PREFIX="KakaoTalk"
WINEVERSION="5.0.2"
TITLE="Kakao Talk"
EDITOR="Kakao Corp."
GAME_URL="https://www.kakaocorp.com/"
AUTHOR="TheBallOfAeolus"
DOWNLOADURL="http://app.pc.kakao.com/talk/win32/KakaoTalk_Setup.exe"
OSVERSION="win10"
SHORTCUTFILENAME="KakaoTalk.exe"
DOWNLOADEDSETUPFILE="KakaoTalk_Setup.exe"
   
# Initialization
POL_SetupWindow_Init
   
POL_Debug_Init
   
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
   
# Create Prefix
POL_System_TmpCreate "$PREFIX"
   
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "$TITLE installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOADURL"
    INSTALLER="$POL_System_TmpDir/$DOWNLOADEDSETUPFILE"
fi
   
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"
   
# Configuration
Set_OS "$OSVERSION"
   
#Dependencies
POL_Call POL_Install_gdiplus
#POL_Call POL_Install_msxml6
#POL_Call POL_Install_riched20
#POL_Call POL_Install_riched30
#POL_Call POL_Install_wmp9
#POL_Call POL_install_wmp10
#POL_Call POL_install_wmpcodecs
POL_Call POL_Install_mono28
POL_Call POL_Install_gecko
POL_Call POL_Install_winhttp
   
# Installation
Set_OS "$OSVERSION"
   
POL_SetupWindow_message "The installer for $TITLE will now appear.nDo not allow the installer to launch the game.nUncheck the box to launch the game at the end of the installation.nnIf the game is launched from the installer, the apllication will not be installed and you have to start the process again.n" "Uncheck the Launch Game checkbox!"
POL_SetupWindow_wait "Installation in progress." "$TITLE installation"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Wine_WaitExit "$TITLE"
   
# Create Shortcuts
POL_Shortcut "$SHORTCUTFILENAME" "$TITLE" "" "" "Network;"
POL_Shortcut_InsertBeforeWine "$TITLE" "LANG=ko_KR.UTF-8"
   
# Cleanup
POL_System_TmpDelete
   
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX1NAqgAKCRDlMfrJqhPK
R91jAJ9ge3KXeg+LqigoDlX/h1vg+xyZ7ACeIOhjYwpQrxa0Byfd7eKLZnkWhWg=
=sNkA
-----END PGP SIGNATURE-----
