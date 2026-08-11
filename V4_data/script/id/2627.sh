#!/bin/bash
# Last revision : see changelog below
# Wine version used : 6.3-staging
# Distribution used to test : Manjaro KDE 2021.03
# Author : nosklo
# Last Editor: Kepsz
# Depend : vkd3d, lib32-vkd3d
#
# CHANGELOG;
# [EdRIn] (2016)
#   Initial writting ?.
# [Nosklo] (2016)
#   ...
# [ThanosApostolou] (2016)
#   Wine "1.9.3-HeroesOfStorm-40083bugfix" -> "1.9.23-staging" because "It seems that it works only with the staging wine builds nowadays".
#   ...
# [Dadu042] (2019-06-03)
#  - Crashed before to reach the "Blizzard Battle.net Login" window ("Blizzard Error. Unknown error, please report to Blizzard ... <Close>". Occurs with Wine 1.9.23-stating and 3.0.5. Fixed with: Wine 4.0.1
#  - Game now need a 64 bits OS.
#  - Remove # POL_Wine_OverrideDLL "" "d3d11"  because launcher says it can find a ".DLL" (D3D11). Games can work with D3D9 (ref: appdb.winehq.org)
#  - Tried to add (for safety): "-force-d3d9", but game still launch with d3d11.
#  - Add support for dual GPU.
  
#  Canceled (to delete):
#  - According Appdb.winehq.org this game can also work with Wine 2.x and 3.x. Since it is currently broken, I remove the Wine version in order to use OS's version.
#
# [Kepsz] (2020-03-17)
# - The game is no longer have a DX9 option, and only supports 64 bit. Also, it can only work with wine-staging.
# - Two of Wine's dll's needs to be replaced with DLL's from the game.
# - Information about vkd3d is added. The (at the time) official vkd3d 1.1 is not enough to play the game. You have to use the GIT version of vkd3d, until they release a new mayor version.

# [Kepsz] (2020-09-27)
# - Script is updated because vkd3d 1.2 is reelased. Wine version is updated to 5.10-staging.

# [Kepsz] (2021-02-26)
# - Script is updated because of bnet launcher changes. Wine version is updated to 6.0-staging. DLL overrieds removed, they do not needed with current wine-staging versions.

# [Kepsz] (2021-03-15)
# - wine-staging version is updated to 6.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Heroes of the Storm"
PREFIX="heroes_of_the_storm"
    
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2627
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "Blizzard" "http://us.battle.net/heroes/en/" "EdRIn" "$PREFIX"
 
#some notification to the user
POL_SetupWindow_message "Since HOTS uses DX12, you will need tho install the vkd3d and lib32-vkd3d packages from the package manager of your operating system. You have to install both of them before you click next, this is important! *note: you may need to hit ENTER on your keyboard to proceed with your login data in the BNet launcher because of the not properly displayed OK button." "$TITLE"
 
POL_SetupWindow_message "At the end of HOTS installation, do not press the 'Play' button. Instead, close the Battle.Net client (choose Exit) and wait for the PlayOnLinux installation wizard window to close, it will take some time. After that, you can then start the game as usual." "$TITLE"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "6.3-staging"
  
# Might be needed if you get crashes
# POL_Wine_OverrideDLL "native,builtin" "dbghelp"
# POL_Wine_OverrideDLL "native,builtin" "winhttp"
# POL_Wine_OverrideDLL "native,builtin" "wininet"
 
# POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-heap-l1-1-0"
# POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-locale-l1-1-0"
# POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-math-l1-1-0"
# POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-runtime-l1-1-0"
# POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-stdio-l1-1-0"
# POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-convert-l1-1-0"
# POL_Wine_OverrideDLL "native,builtin" "msvcp140"
# POL_Wine_OverrideDLL "native,builtin" "ucrtbase"
# POL_Wine_OverrideDLL "native,builtin" "vcruntime140"
# POL_Wine_OverrideDLL "" "d3d11"
   
POL_Call POL_Install_corefonts
POL_Call POL_Install_RegisterFonts
    
# Download & Install the game.
# Multiple Language support. See https://eu.battle.net/account/download/?show=hearthstone&style=hearthstone
POL_SetupWindow_menu "$(eval_gettext 'What language do you want to install?')" "Language Selection" \
    "English|Español (AL)|Português (BR) |Deutsch|Español (EU)|Português (EU)|Français|Russian|Italiano|Polski|Korean|Chinese (Taiwan)|Chinese (China)" "|"
case "$APP_ANSWER" in
    "English")
        EXE_FILE="Heroes-of-the-Storm-Setup-enUS.exe";;
    "Español (AL)")
        EXE_FILE="Heroes-of-the-Storm-Setup-esMX.exe";;
    "Português (BR)")
        EXE_FILE="Heroes-of-the-Storm-Setup-ptBR.exe";;
    "Deutsch")
        EXE_FILE="Heroes-of-the-Storm-Setup-deDE.exe";;
    "Español (EU)")
        EXE_FILE="Heroes-of-the-Storm-Setup-esES.exe";;
    "Português (EU)")
        EXE_FILE="Heroes-of-the-Storm-Setup-ptPT.exe";;
    "Français")
        EXE_FILE="Heroes-of-the-Storm-Setup-frFR.exe";;
    "Russian")
        EXE_FILE="Heroes-of-the-Storm-Setup-ruRU.exe";;
    "Italiano")
        EXE_FILE="Heroes-of-the-Storm-Setup-itIT.exe";;
    "Polski")
        EXE_FILE="Heroes-of-the-Storm-Setup-plPL.exe";;
    "Korean")
        EXE_FILE="Heroes-of-the-Storm-Setup-koKR.exe";;
    "Chinese (Taiwan)")
        EXE_FILE="Heroes-of-the-Storm-Setup-zhTW.exe";;
    "Chinese (China)")
        EXE_FILE="Heroes-of-the-Storm-Setup-zhCN.exe";;
    *)
        exit 1;;
esac
  
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "http://dist.blizzard.com/downloads/storm-installers/7C96DEC684D71DCDD4809F35F5D1E2BE/storm.1/${EXE_FILE}"
    
POL_Wine "$POL_System_TmpDir/${EXE_FILE}"
    
POL_Wine_WaitExit "$TITLE"
 
#######################################
# Setup GPU                           #
####################################### 
   
POL_SetupWindow_VMS "256"
POL_Call POL_Install_VideoDriver
 
#######################################
# Replace Wine's dll files with links #
# to the dll files at storm's folder  #
#######################################
 
mv "/home/$USER/.PlayOnLinux/wineprefix/$PREFIX/drive_c/windows/system32/d3dcompiler_47.dll" "/home/$USER/.PlayOnLinux/wineprefix/$PREFIX/drive_c/windows/system32/d3dcompiler_47.dll.bak"
mv "/home/$USER/.PlayOnLinux/wineprefix/$PREFIX/drive_c/windows/system32/d3dx11_42.dll" "/home/$USER/.PlayOnLinux/wineprefix/$PREFIX/drive_c/windows/system32/d3dx11_42.dll.bak"
 
ln -s "/home/$USER/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program Files (x86)/$TITLE/Support64/d3dcompiler_47.dll" "/home/$USER/.PlayOnLinux/wineprefix/$PREFIX/drive_c/windows/system32/d3dcompiler_47.dll"
ln -s "/home/$USER/.PlayOnLinux/wineprefix/$PREFIX/drive_c/Program Files (x86)/$TITLE/Support64/d3dx11_42.dll" "/home/$USER/.PlayOnLinux/wineprefix/$PREFIX/drive_c/windows/system32/d3dx11_42.dll"
  
POL_System_TmpDelete
POL_Wine_reboot
 
POL_Shortcut "Battle.net Launcher.exe" "$TITLE" "$TITLE.png" "" "Game;StrategyGame;"
POL_SetupWindow_Close
exit 0 

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYJ6sEAAKCRDlMfrJqhPK
R/MYAKCnWlwO3YCZIkMvEMLaEhAZLfGY0QCeNqYqLjJHmHHXuE9oHfM5loVCKa0=
=BTOV
-----END PGP SIGNATURE-----
