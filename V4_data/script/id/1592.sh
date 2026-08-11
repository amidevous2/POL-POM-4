#!/bin/bash
# Date : (2013-02-25)
# Last revision : see changelog
# Distribution used to test : XUbuntu 18.04 x64
# Author : Castler, LinuxScripter, ...
# Licence : GPLv3
# PlayOnLinux: v4.3.4
    
# [Castler] (2017-03-18)
#   Wine changed to 2.6-staging
#   link to system requirements updated
#   POL_Wine reg delete "HKEY_CURRENT_USER\\Software\\Wine\\DllRedirects" /v "wined3d"
#   wine reg add "HKEY_CURRENT_USER\\Software\\Wine\\DllRedirects" /v "wined3d" /t "REG_SZ" /d "wined3d-csmt.dll"
#   POL_Wine --ignore-errors reg add "HKEY_CURRENT_USER\\Software\\Wine\\DllRedirects" /v "wined3d" /t "REG_SZ" /d "wined3d-csmt.dll"
#  torrent issue fixed
# [ZemoGiter] (2019-06-13)
#   Wine version changed to 4.0.1
#   Using old launcher to solve the Failed ::ShellExecuteExW - WinErr=2 error
#   Removal of unused fixes to make the script more readable 
# [Dadu042] (2020-01-09)
#   Wine 4.0.1 -> 4.0.3
#   Add POL_RequiredVersion
#   Improve POL_Shortcut
#   Improve last message about DXVK.
# [Dadu042] (2020-06-15) (not tested, just to save bandwidth)
#   Wine 4.0.3 -> 4.0.4
#   The compatibility seeems break because of the (now required) 'Wargaming.net Game Center' and its 'black window' bug.
# [Dadu042] (2020-06-15 17:11
#   Attempt to run it with Wine 5.0.1. Tried: other shortucts, DXVK_161 and 170.
# [Dadu042] (2020-11-07 19:00
#   Add a argument to force D3D9 (default is D3D11).
#   Wine 5.0.1 -> 5.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="World Of Tanks"
PREFIX="WorldOfTanks"
WORKING_WINE_VERSION="5.0.3"
PUBLISHER="-"
GAME_URL="http://worldoftanks.com/"
AUTHOR="Castler"
    
# Setup
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1592
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE 4.3.4 is required to install $TITLE"
   
#Select which version
POL_SetupWindow_menu "$(eval_gettext 'Which region version of World of Tanks would you like to install? Note: Korea not supported on this installation.')" "$TITLE" "North America~Europe~Russia~Asia" "~"
[ "$APP_ANSWER" = "North America" ] && REGION="na"
[ "$APP_ANSWER" = "Europe" ] && REGION="eu"
[ "$APP_ANSWER" = "Russia" ] && REGION="ru"
[ "$APP_ANSWER" = "Asia" ] && REGION="asia"
    
# Download
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "http://redirect.wargaming.net/WoT/launcher_install_$REGION"
 
POL_SetupWindow_question "Do you want to install this game on a 64 bit wineprefix?" "$TITLE"
if [ "$APP_ANSWER" = "TRUE" ]; then
    POL_System_SetArch "amd64"
else
    POL_System_SetArch "x86"
fi
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
    
# Samba
if [ "$POL_OS" = "Mac" ]; then
    # Samba support
    POL_Call POL_GetTool_samba3
    source "$POL_USER_ROOT/tools/samba3/init"
fi
 
# Components

POL_Call POL_Install_corefonts

#  Seems useless as of 2020-06:
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_vcrun2013

#  Seems useless as of 2020-06:
# POL_Wine_OverrideDLL "builtin,native" "dnsapi"
# POL_Wine_OverrideDLL "builtin,native" "msvcr140"
# POL_Wine_OverrideDLL "builtin,native" "msvcp140"

POL_Wine_OverrideDLL "" "xaudio2_7" # Disabled DLL   
  
# Useless since 2018 or before: 
# Registry modification - enable CSMT from Wine staging
# POL_Wine --ignore-errors reg add "HKEY_CURRENT_USER\\Software\\Wine\\DllRedirects" /v "wined3d" /t "REG_SZ" /d "wined3d-csmt.dll"

#  Seems useless as of 2020-06:
# Disable GLSL for better FPS performance
# POL_Wine_Direct3D "UseGLSL" "disabled"
    
# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$POL_System_TmpDir/launcher_install_$REGION"
   
# After installation, the patcher will be started asynchronously
wineserver -k
   
# Create Shortcut
POL_Shortcut "WoTLauncher.exe" "$TITLE" "" "-clientGraphicsAPI d3d9" "Game;ActionGame;"
    
# Samba
if [ "$POL_OS" = "Mac" ]; then
    POL_Shortcut_InsertBeforeWine "$TITLE" "source \"$POL_USER_ROOT/tools/samba3/init\""
fi
    
POL_System_TmpDelete
 
POL_SetupWindow_message "$(eval_gettext 'You will also have to install DXVK (ie: via winetricks) to play $TITLE')"
    
POL_SetupWindow_Close
    
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX851aAAKCRDlMfrJqhPK
R14qAJ4kGxY29LivjatgolCpu5nHvzH4JACgm8GEuvlBjD03mueoHMVTxbX6Veo=
=eXV6
-----END PGP SIGNATURE-----
