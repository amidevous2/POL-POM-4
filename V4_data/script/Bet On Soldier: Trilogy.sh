#!/bin/bash
# Date : (2019-09-05)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED (with success): retail DVD-ROM release (april 2008).
#
# Middlewares used by this software : DirectX 9, Ageia Physx, vcrun2003.
#
# CHANGELOG
# [Dadu042] (2019-09-05)
#   First script.
# [Dadu042] (2020-07-03)
#   Add dxfullsetup
#   Wine 4.0.2 -> 5.0.1
#
# KNOWN ISSUES:
# - Wine x86 4.0.2, 4.15, 5.0.1, 5.11:
#            crash as soon as launched (and disturb the desktop windows), debug log:
#            0009:fixme:d3dcompiler:compile_shader Compilation target "fx_2_0" not yet supported
#            0009:fixme:d3dx:d3dx9_effect_init Failed to parse effect, hr 0x8876086c.
#            What I tried: virtual desktop, d3dx9_43, d3dcompiler_43, vcrun2005. OK with Wine 3.0.3. override vcrun2003 DLLs.
#            The fix is: install 'dxfullsetup'.
#
#
# Ideas to improve this script: select archive, then decide if extension is RAR or ZIP or 7Z...


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Bet On Soldier - Trilogy"
PREFIX="Bet_On_Soldier_Trilogy"
EDITOR="Kylotonn"
GAME_URL="https://en.wikipedia.org/wiki/Bet_On_Soldier:_Blood_Sport"
AUTHOR="Dadu042"
STEAM_ID=""
WORKING_WINE_VERSION="5.0.3"
GAME_VMS="256"
SHORTCUT_FILENAME="useless"
SOFTWARE_CATEGORIES="Game;Shooter;"
   
# Starting the script
POL_SetupWindow_Init
   
# Starting debugging API
POL_Debug_Init
  
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# POL_SetupWindow_message "$(eval_gettext 'WARNING: this software does exist in Linux native version.\n\nThis script only allow to run the Windows version on Linux, please prefer the Linux edition for better 3D speed.')" "$TITLE"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Determine Architecture
POL_System_SetArch "x86"
  
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "winxp"

# POL_Call POL_Install_corefonts

# Installing mandatory dependencies
# POL_Call POL_Install_d3dx11

# Useful for Nvidia GPUs
# POL_Call POL_Install_physx


# POL_Call POL_Install_riched30

POL_Call POL_Install_dxfullsetup

# POL_Call POL_Install_vcrun2005

# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43

# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "LOCAL,STEAM"

POL_SetupWindow_message "$(eval_gettext '\nWarning: at the end of installation, do not install Ageia Physx nor DirectX.')" "$TITLE"

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

# Does only work for Dishonored v1 edition, not for the Game of the year Edition.
#         POL_SetupWindow_check_cdrom "sku.sis"

        POL_SetupWindow_check_cdrom "BetOnSoldierTrilogie_Setup.exe"
        POL_Wine start /unix "$CDROM/BetOnSoldierTrilogie_Setup.exe"
        POL_Wine_WaitExit "BetOnSoldierTrilogie_Setup.exe"
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
        POL_Shortcut "BOS/BoS.exe" "Bet On Soldier - Trilogy" "" "" "$SOFTWARE_CATEGORIES"
	POL_Shortcut_Document "Bet On Soldier - Trilogy" "BOS/BoS_Manual_en.pdf"

        POL_Shortcut "BOS_Sahara/BoS.exe" "Bet On Soldier - Trilogy: Blood Of Sahara" "" "" "$SOFTWARE_CATEGORIES"
	POL_Shortcut_Document "Bet On Soldier - Trilogy: Blood Of Sahara" "BOS_Sahara/Bloodos_Manual.pdf"

        POL_Shortcut "BOS_Saigon/BoS.exe" "Bet On Soldier - Trilogy: Black Out Saigon" "" "" "$SOFTWARE_CATEGORIES"
	POL_Shortcut_Document "Bet On Soldier - Trilogy: Black Out Saigon" "BOS_Saigon/Black_out_Saigon_Manuel_EN.pdf"

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



# Better than virtual desktop ?
# POL_Wine_X11Drv "GrabFullScreen" "Y"
# POL_Wine_X11Drv "DXGrab" "Y"

POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYkb9zgAKCRDlMfrJqhPK
R+qOAJ4zMSQiADDMhyCwT8tFVRO/hakqVwCgpkl4CM53PZzddAgzsBKwVMtNvck=
=YTc4
-----END PGP SIGNATURE-----
