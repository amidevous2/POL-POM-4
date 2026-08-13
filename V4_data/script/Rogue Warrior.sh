#!/bin/bash
# Date : (2019-08-20)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : XUbuntu 18.04
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED (with succcess): Retail DVD-ROM DL (installed in 'offline mode'), 5 languages (Western Europe). Readme.txt (once installed. sept 2009): 'v3'.
#
# Middlewares used by this software : DirectX 9.
#
# CHANGELOG
# [Dadu042] (2019-08-20)
#   First script.
# [Dadu042] (2019-12-28)
#   Wine 3.0.5 -> 3.0.3 (max supported by POL 4.2.12)
# [Dadu042] (2020-04-05)
#   Wine 3.0.3 -> 5.0 (to make a Appdb report).
#   x86 -> amd64
#
#
# KNOWN ISSUES:
# - Wine 4.0.1 amd64: After the intro videos (Bethesda, Rebellion) the screen goes black and the game freeze. This seems related to 'acg3x.exe' (DRM ?).
#                     Same issue with a NoCD file applied. Fix: Wine 4.8/4.11 + NoCD (otherwise it just crash when launching, same crash with 4.12).
# - Wine 4.0.1 amd64: None sounds nor music.
# - Wine 4.0.1 x86: None sounds nor music. Tried: install directmusic, dsound, quartz, amstream, directplay, directx9. Sound is OK with wine 3.0.5
# - Wine amd64 5.0, 5.2: from the stage 3 or 4 (missile factory), the game does crash when switching to a new stage. Workaround: Restarting the game allows to continue the game to the next stage. According the log, the crashes seems related to DirectX 9.
#
# Note: With Wine 3.0.5 there is no sound nor music issues, and the game does run and work without needing a NoCD.
#
# KNOWN ISSUES (FIXED):
#
#
# Ideas to improve this script: error window if unrar missing. Select archive, then decide if extension is RAR or ZIP or 7Z...
 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Rogue Warrior"
PREFIX="Rogue_Warrior"
EDITOR="Bethesda Softworks"
GAME_URL="https://en.wikipedia.org/wiki/Rogue_Warrior_(video_game)"
AUTHOR="Dadu042"
STEAM_ID="22310"
WORKING_WINE_VERSION="3.0.5"
GAME_VMS="512"
SHORTCUT_FILENAME="RW.exe"
SOFTWARE_CATEGORIES="Game;Shooter;"
    
# Starting the script
POL_SetupWindow_Init
    
# Starting debugging API
POL_Debug_Init
   
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"
  
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
   
# Determine Architecture
POL_System_SetArch "amd64"
# POL_System_SetArch "x86"
   
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
Set_OS "vista"
 
# POL_Call POL_Install_corefonts
    
# Installing mandatory dependencies
# POL_Call POL_Install_d3dx11
 
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
   
# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "LOCAL,DVD"
 
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
 
elif [ "$INSTALL_METHOD" == "DVD" ];then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "IS/Rogue Warrior.msi"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
 
elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
        POL_Download "https://www.villagers-and-heroes.com/VHSetup.exe"
        POL_Wine "VHSetup.exe" "/SILENT"
        POL_Wine_WaitBefore "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
  
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"
 
if [ "$APP_ANSWER" == ".EXE" ]; then
        # Asking then installing local files of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
#        POL_Shortcut_Document "$TITLE" "Readme.txt"
          
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
          
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/" || POL_Debug_Fatal "unrar is required to unarchive $TITLE (unrar package is not installed on the OS)."
        POL_Shortcut "$SHORTCUT_FILENAME" "$TITLE" "" "" "$SOFTWARE_CATEGORIES"
fi
fi
  
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
  
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpIMuwAKCRDlMfrJqhPK
R//4AJ9ruTG0c9BKKiLD2xojGBv7MWEugACghUmpZFaaW8jBjpOjG0hUYZWh2u8=
=11gs
-----END PGP SIGNATURE-----
