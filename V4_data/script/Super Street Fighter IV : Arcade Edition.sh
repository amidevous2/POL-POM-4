#!/bin/bash
# Date : (2011-27-07 21-00)
# Last revision : (2012-05-15 21:00)
# Wine version used : 1.3.23, 1.5.3-xliveless2-rawinput3, 1.5.4-xliveless3-rawinput3
# Distribution used to test : Linux Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail

## Begin Note ##
# Used Xliveless3 patch to disable non-working GFWL support - http://appdb.winehq.org/objectManager.php?sClass=version&iId=19065
## End Note ##

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Super Street Fighter IV : Arcade Edition"
PREFIX="SSF4AE"
WORKING_WINE_VERSION="1.5.4-xliveless3-rawinput3"
EDITOR="Capcom"
GAME_URL="http://www.streetfighter.com"
AUTHOR="GNU_Raziel"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ssf4ae/top.jpg" "http://files.playonlinux.com/resources/setups/ssf4ae/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet/mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD, Steam and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

#Installing mandatory dependencies
POL_Call POL_Install_vcrun2010
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
	STEAM_ID="21660"
fi
POL_Call POL_Install_dxfullsetup

# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Fix brightness
POL_Wine_Direct3D "UseGLSL" "disabled"

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Pre-install fix - Need to backup dll because game setup install xlive and override it
cd "$WINEPREFIX/drive_c/windows/system32/"
cp xlive.dll xlive2.dll

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "autorun.ico"
	POL_Wine msiexec /i "$CDROM/Game.msi"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"
	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
	POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
	# Steam install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Mandatory to make the game work with wine
POL_Call POL_Remove_gfwl
cd "$WINEPREFIX/drive_c/windows/system32/"
cp xlive2.dll xlive.dll

## Fix for this game
# Language Fix for this game
if [ "$INSTALL_METHOD" == "DVD" ]; then
	if [ "$POL_ARCH" == "amd64" ]; then
		REG_KEY="[HKEY_LOCAL_MACHINE\\Software\\Wow6432Node\\Capcom\\Super Street Fighter IV]"
	else
		REG_KEY="[HKEY_LOCAL_MACHINE\\Software\\Capcom\\Super Street Fighter IV]"
	fi
	cd "$WINEPREFIX/drive_c/windows/temp/"
	if [ "$POL_LANG" == "de" ]; then
		echo "$REG_KEY" > ssf4_lang.reg
		echo "\"Language\"=\"1031\"" >> ssf4_lang.reg
		regedit ssf4_lang.reg
	fi
	if [ "$POL_LANG" == "es" ]; then
		echo "$REG_KEY" > ssf4_lang.reg
		echo "\"Language\"=\"1034\"" >> ssf4_lang.reg
		regedit ssf4_lang.reg
	fi
	if [ "$POL_LANG" == "fr" ]; then
		echo "$REG_KEY" > ssf4_lang.reg
		echo "\"Language\"=\"1036\"" >> ssf4_lang.reg
		regedit ssf4_lang.reg
	fi
	if [ "$POL_LANG" == "hu" ]; then
		echo "$REG_KEY" > ssf4_lang.reg
		echo "\"Language\"=\"1038\"" >> ssf4_lang.reg
		regedit ssf4_lang.reg
	fi
	if [ "$POL_LANG" == "it" ]; then
		echo "$REG_KEY" > ssf4_lang.reg
		echo "\"Language\"=\"1040\"" >> ssf4_lang.reg
		regedit ssf4_lang.reg
	fi
	if [ "$POL_LANG" == "ja" ]; then
		echo "$REG_KEY" > ssf4_lang.reg
		echo "\"Language\"=\"1041\"" >> ssf4_lang.reg
		regedit ssf4_lang.reg
	fi
	if [ "$POL_LANG" == "ko" ]; then
		echo "$REG_KEY" > ssf4_lang.reg
		echo "\"Language\"=\"1042\"" >> ssf4_lang.reg
		regedit ssf4_lang.reg
	fi
fi

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "SSFIV.exe" "$TITLE" "$TITLE.png" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+yk8kACgkQ5TH6yaoTykctcQCgnr+lZ5/EVFCn+qLnA5Ifz43m
ueoAn3iq4nrwfWCDv9XaqCeZUulAeUOs
=jvjs
-----END PGP SIGNATURE-----
