#!/usr/bin/env playonlinux-bash
# Date : (2015-09-30 20-05)
# Last revision : see changelog
# Distribution used to test : Arch Linux x86_64 5.5.8-arch1-1
# Author : MangaD
# LF2 depend: vcrun2005, wmp9, quartz, devenum
# LF2 Lobby depend: vb6run

# Changelog
# (2015-10-01) 22:50 - MangaD
#        - Removed d3dx9 from dependencies
# (2015-10-03) 17-05 - MangaD
#        - Added MD5 digest to POL_Download
# (2015-11-18) 01-25 - MangaD
#        - Added minimum VRAM required
# (2018-01-17) - MangaD
#        - Changed '&&&&' to '&&' in the VENDOR due to changes in POL.
#        - Optionally download LF2 Lobby, LF2 MultiServer and LF2 Dashboard
#        - Optionally download Hero Fighter
#        - Don't use specific wine version
#        - Replace WMP9 with WMP10, for some reason WMP9 installation was failing for me
# (2018-01-19) - MangaD
#        - Added $WINEPREFIX in rm commands
#        - Added POL_SetupWindow_wait before unzip/untar
# (2018-09-13) - MangaD
#        - Replace WMP10 with WMP9, the reason WMP9 installation was failing is because POL was having issues
# (2019-03-10) - MangaD
#        - Change url of herofighter-empire.com to hf-empire.com
#        - Use specific wine version because of 32-bit
# (2020-03-01) - MangaD
#        - Fix bugs and update Hero Fighter link
# (2020-03-03) - Dadu042
#        - Fix POL_Shortcut failing by using POL_Wine_WaitExit before, instead of POL_Wine_WaitBefore .
#        - Wine OS version -> 3.20 (latest available for POL < v4.3 users).
#        - Add POL_Shortcut_Document
# (2020-03-12) - MangaD
#        - Added warning to install mono, mpg123, gstreamer base plugins and gstreamer libav
#        - Added warning to select VMS no less than 384
#        - Added warning about LF2 buggy control settings
# (2021-12-11) - MangaD
#        - Use system wine
#        - Update Hero Fighter
#        - Set OS to winxp sp3
#
#
# KNOWN ISSUES: (NOT FIXED)
#  - Wine x86 3.0.3, 3.20 (+ game v2.0a): error window 'Could not create a filter graph for this file!' (however the games does continue). Fix: Wine 5.2
#
# KNOWN ISSUES (FIXED):
#  - Wine x86 3.0.3, 3.20, 4.21, 5.2 (+ game v2.0a): game does freeze after clicking 'game start' (Now Loading ... data\henry_wind.dat ). This seems related to 'wmvcore:WMReader_QueryInterface'. Fix: installing with Wine 3.20 (instead of 4.0.2) or installing Mono.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# POL
#WINEVERSION="3.20"
PREFIX="LittleFighter2_v20a"
MAINTAINER="MangaD"
GAME_VMS="384"

# Info
TITLE="Little Fighter 2 v2.0a"
VENDOR="Marti Wong && Starsky Wong"
WEBSITE="http://www.lf2.net/"

FILENAME_EMPIRE="lf2_v20a_Setup.exe"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups/$PREFIX/left.png" "$TITLE"

# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$VENDOR" "$WEBSITE" "$MAINTAINER" "$PREFIX"

POL_RequiredVersion "4.1.4" || POL_Debug_Fatal "$(eval_gettext '$APPLICATION_TITLE equal or superior to 4.1.4 is required to install $TITLE')"

POL_SetupWindow_message "$(eval_gettext 'Warning: Before running this script, make sure that you have the commands '\''unzip'\'' and '\''unrar'\'' installed.')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'Warning: You also need to install '\''mono'\'' so that the game doesn'\''t freeze at loading.')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'Warning: For the background music to work, you also need to install the 32-bit version of GStreamer libav. Just in case, also install 32-bit version of mpg123 and 32-bit version of GStreamer Base Plugins.')" "$TITLE"

# Let the user choose between downloading the installer or using an already existing one.
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"
	FULL_INSTALLER="$APP_ANSWER"
else # DOWNLOAD
	POL_System_TmpCreate "$PREFIX"

	# There are two different installers available from two different sources. They both contain the same program.
	POL_SetupWindow_menu "$(eval_gettext 'Select installer to download:')" "$TITLE" "Little Fighter 2 - Official Website~Little Fighter - EMPIRE" "~"
	case "$APP_ANSWER" in
		"Little Fighter 2 - Official Website")
			DOWNLOAD_URL="http://lf2.net/__conduit/0131/LF2_v20a_Install.exe"
			DOWNLOAD_MD5="afd060f4f43601350486947d6d0838f9"
			;;
		"Little Fighter - EMPIRE")
			DOWNLOAD_URL="https://www.lf-empire.de/downloads/offversions/LF2_v2.0a.zip"
			DOWNLOAD_MD5="61062f685d3fb2227e354f2d74a1a638"
			;;
	esac

	cd "$POL_System_TmpDir"

	POL_Download "$DOWNLOAD_URL" "$DOWNLOAD_MD5"
	DOWNLOAD_FILE="$(basename "$DOWNLOAD_URL")"

	case "$APP_ANSWER" in
		"Little Fighter - EMPIRE")
			POL_SetupWindow_wait "$(eval_gettext 'Unzipping archive.')" "$TITLE"
			POL_System_unzip -o "$DOWNLOAD_FILE"
			DOWNLOAD_FILE=$FILENAME_EMPIRE
		;;
	esac

	FULL_INSTALLER="$POL_System_TmpDir/$DOWNLOAD_FILE"
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Determine Architecture, must be x86 because of wmp9
POL_System_SetArch "x86"

POL_Wine_PrefixCreate #"$WINEVERSION"

POL_SetupWindow_message "$(eval_gettext 'At installation phase, sometimes after clicking '\''Next'\'' nothing appears on the window. Just click '\''Back'\'' and '\''Next'\'' again to fix.')" "$TITLE"


################
#      GPU     #
################

# Asking about memory size of graphic card
POL_SetupWindow_message "$(eval_gettext 'Warning: In the next question answer "$GAME_VMS" or above if you don'\''t know.')" "$TITLE"
POL_SetupWindow_VMS "$GAME_VMS"

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver


#######################################
#  Installing mandatory dependencies  #
#######################################

Set_OS "winxp" "sp3"

POL_Call POL_Install_vcrun2005
# wmp9, quartz and devenum are necessary for the background music to work
POL_Call POL_Install_wmp9
POL_Call POL_Install_quartz
POL_Call POL_Install_devenum

Set_OS "winxp" "sp3"

##################
#  Install game  #
##################

POL_Wine "$FULL_INSTALLER"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "lf2.exe" "$TITLE" "" "" "Game;"

POL_Shortcut_Document "$TITLE" "readme.txt"

POL_SetupWindow_question "$(eval_gettext 'Would you also like to download and install LF2 Lobby, LF2 Multiserver 2.0 and LF2 Dashboard?')" "$(eval_gettext 'Download LF2 extras?')"
if [ "$APP_ANSWER" = "TRUE" ]; then

	if [ "$(basename "$FULL_INSTALLER")" = "LF2_v20a_Install.exe" ]
	then
			DIRECTORY="LittleFighter"
	else
			DIRECTORY="LittleFighter2/LF2_v2.0a"
	fi

	# Download LF2 Lobby
	cd "$WINEPREFIX"
	DOWNLOAD_URL="http://www.lf2lobby.com/downloads/LF2Lobby0.1.4.rar"
	DOWNLOAD_MD5="3d1faf8321c4143dc161e026ee7379ab"
	DOWNLOAD_FILE="LF2Lobby0.1.4.rar"
	EXE_FILE="LF2Lobby0.1.4.exe"
	POL_Download "$DOWNLOAD_URL" "$DOWNLOAD_MD5"
	POL_SetupWindow_wait "$(eval_gettext 'Decompressing archive.')" "$TITLE"
	POL_System_unrar x -o+ "$DOWNLOAD_FILE"
	rm -f "$WINEPREFIX/$DOWNLOAD_FILE"
	mv "$WINEPREFIX/$EXE_FILE" "$WINEPREFIX/drive_c/Program Files/$DIRECTORY"
	POL_Shortcut "$EXE_FILE" "$(basename "$EXE_FILE" .exe)" "" "" "Game;"
	# vbrun6 is necessary for LF2 Lobby to work
	POL_Call POL_Install_vbrun6

	# Download LF2 MultiServer
	cd "$WINEPREFIX"
	DOWNLOAD_URL="http://lf2.co.il/downloads/LF2MultiServer_v2.0.rar"
	DOWNLOAD_MD5="0eb8a92dbbdf5c8c2590612713d9d54b"
	DOWNLOAD_FILE="LF2MultiServer_v2.0.rar"
	EXE_FILE="LF2 Multi Server v2.0.exe"
	DLL_FILE="MultiPlugin/ddraw.dll"
	POL_Download "$DOWNLOAD_URL" "$DOWNLOAD_MD5"
	POL_SetupWindow_wait "$(eval_gettext 'Decompressing archive.')" "$TITLE"
	POL_System_unrar x -o+ "$DOWNLOAD_FILE"
	mv "$WINEPREFIX/$EXE_FILE" "$WINEPREFIX/drive_c/Program Files/$DIRECTORY"
	mv "$WINEPREFIX/$DLL_FILE" "$WINEPREFIX/drive_c/Program Files/$DIRECTORY"
	rm -rf "$WINEPREFIX/$DOWNLOAD_FILE" "$WINEPREFIX/MultiPlugin" "$WINEPREFIX/Readme.txt"
	POL_Shortcut "$EXE_FILE" "$(basename "$EXE_FILE" .exe)" "" "" "Game;"
	# ddraw is necessary for LF2 MultiServer and AI addons
	POL_Wine_OverrideDLL "native,builtin" "ddraw"

	# Download LF2 Dashboard
	cd "$WINEPREFIX"
	DOWNLOAD_URL="https://hf-empire.com/downloads/LF2Linux/LF2Dashboard.exe"
	DOWNLOAD_MD5="2ab48968c17e1fbcdbb664ae8a900207"
	EXE_FILE="LF2Dashboard.exe"
	POL_Download "$DOWNLOAD_URL" "$DOWNLOAD_MD5"
	mv "$WINEPREFIX/$EXE_FILE" "$WINEPREFIX/drive_c/Program Files/$DIRECTORY"
	POL_Shortcut "$EXE_FILE" "$(basename "$EXE_FILE" .exe)" "" "" "Game;"
fi

POL_SetupWindow_question "$(eval_gettext 'Would you also like to download and install Hero Fighter?')" "$(eval_gettext 'Download Hero Fighter?')"
if [ "$APP_ANSWER" = "TRUE" ]; then
	# Download HF
	cd "$WINEPREFIX"
	DOWNLOAD_URL="https://hf-empire.com/downloads/LF2Linux/HFv0.7_mod.zip"
	DOWNLOAD_MD5="0b70102bde8599f9cd7395cabc083e13"
	DOWNLOAD_FILE="HFv0.7_mod.zip"
	EXE_FILE="HFv0.7+.exe"
	POL_Download "$DOWNLOAD_URL" "$DOWNLOAD_MD5"
	POL_SetupWindow_wait "$(eval_gettext 'Unzipping archive.')" "$TITLE"
	POL_System_unzip -o "$DOWNLOAD_FILE"
	rm -f "$WINEPREFIX/$DOWNLOAD_FILE"
	mkdir "$WINEPREFIX/drive_c/Program Files/HeroFighter"
	mv "$WINEPREFIX/$EXE_FILE" "$WINEPREFIX/drive_c/Program Files/HeroFighter"
	mv "$WINEPREFIX/RoomServer.exe" "$WINEPREFIX/drive_c/Program Files/HeroFighter"
	POL_Shortcut "$EXE_FILE" "Hero Fighter v0.7+" "" "" "Game;"
fi

POL_SetupWindow_message "$(eval_gettext 'The LF2 control settings screen doesn'\''t show the Ok and Cancel buttons, but if you hover over them they will appear.')" "$TITLE"

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
	# Free some disk space
	POL_System_TmpDelete
fi

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYbYkqAAKCRDlMfrJqhPK
R4q+AJ4nnE2o92sw0FXYy17YybDHwP5GRACfXN9GkrvSenfNHVCwxfO+ZR+fxrI=
=VmCA
-----END PGP SIGNATURE-----
