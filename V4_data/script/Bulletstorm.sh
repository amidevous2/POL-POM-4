#!/bin/bash
# Date : (2011-04-03 21-00)
# Last revision : see changelog
# Wine version used : 1.3.14, 1.3.15, 1.3.23, 1.3.26-xliveless2, 1.5.3-xliveless2-rawinput3, 3.0.3
# Distribution used to test : Kubuntu 18.04 amd64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
## Begin Note ##
# Used Xliveless2 patch to disable non-working GFWL support - http://appdb.winehq.org/objectManager.php?sClass=version&iId=19065
## End Note ##

# CHANGELOG
# [GNU_Raziel] (2012-05-13)
#   First script. Game don't run.
# [Dadu042] (2019-11-03)
#   Add install from local source.
#   Wine "1.5.3-xliveless2-rawinput3" (anti GFWL) -> 3.0.3
#   To try later: Dotnet35 -> dotnet40
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Bulletstorm"
PREFIX="Bulletstorm"
EDITOR="Epic Games"
GAME_URL="http://www.bulletstorm.com"
AUTHOR="GNU_Raziel"
# WORKING_WINE_VERSION="1.5.3-xliveless2-rawinput3"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/bulletstorm/top.jpg" "http://files.playonlinux.com/resources/setups/bulletstorm/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet/mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
 
# Installing mandatory components
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        STEAM_ID="99810"
fi
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_physx
POL_Call POL_Install_dotnet35
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
## Fix for this game
# Mouse problems fix
POL_Wine_DirectInput "MouseWarpOverride" "force"
 
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
# Pre-install fix - Need to backup dll because game setup install xlive and override it
cd "$WINEPREFIX/drive_c/windows/system32/"
cp xlive.dll xlive2.dll
 
if [ "$INSTALL_METHOD" == "DVD" ]; then
        # Asking for CDROM and checking if it's correct one
        POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Game.msi"
        POL_Wine msiexec /i "$CDROM/Game.msi"
        POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
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
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
fi
 
## Language Fix for DVD install
if [ "$INSTALL_METHOD" == "DVD" ]; then
        cd "$WINEPREFIX/drive_c/windows/temp/"
        if [ "$POL_ARCH" == "amd64" ]; then
                REG_KEY="[HKEY_LOCAL_MACHINE\\Software\\Wow6432Node\\BulletStorm]"
        else
                REG_KEY="[HKEY_LOCAL_MACHINE\\Software\\BulletStorm]"
        fi
        if [ "$POL_LANG" == "de" ]; then
                echo "$REG_KEY" > bullet_lang.reg
                echo "\"Language\"=\"1031\"" >> bullet_lang.reg
                regedit bullet_lang.reg
        fi
        if [ "$POL_LANG" == "es" ]; then
                echo "$REG_KEY" > bullet_lang.reg
                echo "\"Language\"=\"1034\"" >> bullet_lang.reg
                regedit bullet_lang.reg
        fi
        if [ "$POL_LANG" == "fr" ]; then
                echo "$REG_KEY" > bullet_lang.reg
                echo "\"Language\"=\"1036\"" >> bullet_lang.reg
                regedit bullet_lang.reg
        fi
        if [ "$POL_LANG" == "hu" ]; then
                echo "$REG_KEY" > bullet_lang.reg
                echo "\"Language\"=\"1038\"" >> bullet_lang.reg
                regedit bullet_lang.reg
        fi
        if [ "$POL_LANG" == "it" ]; then
                echo "$REG_KEY" > bullet_lang.reg
                echo "\"Language\"=\"1040\"" >> bullet_lang.reg
                regedit bullet_lang.reg
        fi
        if [ "$POL_LANG" == "ja" ]; then
                echo "$REG_KEY" > bullet_lang.reg
                echo "\"Language\"=\"1041\"" >> bullet_lang.reg
                regedit bullet_lang.reg
        fi
        if [ "$POL_LANG" == "ko" ]; then
                echo "$REG_KEY" > bullet_lang.reg
                echo "\"Language\"=\"1042\"" >> bullet_lang.reg
                regedit bullet_lang.reg
        fi
fi
 
# Mandatory to make the game work with wine
POL_Call POL_Remove_gfwl
cd "$WINEPREFIX/drive_c/windows/system32/"
cp xlive2.dll xlive.dll
 
# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
        POL_Shortcut "ShippingPC-StormGame.exe" "$TITLE" "$TITLE.png" ""
fi
 
# Game protection warning
if [ "$INSTALL_METHOD" == "DVD" ]; then
        POL_SetupWindow_message "$(eval_gettext 'You must disable anti-piracy protections of this game\nif you want to play it with wine')" "$TITLE"
fi
 
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcA/UwAKCRDlMfrJqhPK
R3x6AKCPVvfWA79c6ul0GYVmPvp/QEgDgQCgo++8gPMv0QePkALYSkfNz+b2En0=
=BTNY
-----END PGP SIGNATURE-----
