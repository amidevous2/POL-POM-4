#!/bin/bash
# Date : (2011-30-08 21:00)
# Last revision : see changelog
# Distribution used to test : 
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG:
# [GNU_Raziel] (2011-30-08 21:00)
#   Initial script.
# [GNU_Raziel] (2015-05-30 10-00)
#   Wine version used : 1.3.27, 1.3.37, 1.5.3
#   Linux Mint 11 x64
# [Dadu042] (2020-06-20 14-00)
#   Wine 1.5.3 (outdated) -> 3.0.3
#   Cleanup

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Brink"
PREFIX="brink"
EDITOR="Splash Damage"
GAME_URL="http://www.brinkthegame.com/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="512"

# Starting the script
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/brink/top.jpg" "http://files.playonlinux.com/resources/setups/brink/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # Fix some in-game freeze issues
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
POL_Call POL_Install_steam
STEAM_ID="22350"

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "oss" # Fix sound issue - ONLY work if you REALLY use OSS v4 sound system - No sound at all if you dont.
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Shortcut done before install for DVD/steam version
if [ "$INSTALL_METHOD" != "LOCAL" ]; then
	POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
	POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
fi

if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "Setup.exe"
	POL_Wine "$CDROM/Setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine "Steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

############################
# Some fixes for this game #
############################

# Sound crash fix - this fix will DISABLE sound because the game need "XAudio2_6.dll" but if present, game crash with wine
#mv "$WINEPREFIX/drive_c/windows/system32/XAudio2_6.dll" "$WINEPREFIX/drive_c/windows/system32/XAudio2_6.dll.off"
# Mouse menu fix
POL_Wine_DirectInput "MouseWarpOverride" "force"
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > Fix.reg
[HKEY_CURRENT_USER\\Software\\Wine\\X11 Driver]
"GrabFullscreen"="Y"
EOF
POL_Wine regedit "Fix.reg"

# No sound/No mouse fix
GAME_PATH=`find $WINEPREFIX -name "brink.exe" | sed s/brink.exe/base/g`
cd "$GAME_PATH"
cat << EOF > autoexec.cfg
seta image_filter "GL_LINEAR_MIPMAP_NEAREST"
seta m_rawInput "0"
seta in_XInputSmartConnect "1"
#seta s_driver "dsound"
seta s_driver "OpenAL"
seta s_libOpenAL "c:\windows\system32\openal32.dll"
#seta s_numberOfSpeakers "2"
#seta s_forceNumberOfSpeakers "1"
EOF

# Make shortcut
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
	POL_Shortcut "brink.exe" "$TITLE" "" "" "Game;Shooter;"
fi

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXu4H5gAKCRDlMfrJqhPK
RyvkAJ9oybgPfvbKZ8mviFYrAL0OOgebOQCfeM5Ol6qC09H5JHEJtaOXr+Oxf/4=
=3AW7
-----END PGP SIGNATURE-----
