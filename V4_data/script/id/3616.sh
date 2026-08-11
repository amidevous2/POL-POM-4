#!/bin/bash
# Date : (2019-09-07)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : XUbuntu 18.04 x64
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED (with success): retail DVD-ROM release (latests files date onto: november 2009).
#
# Middlewares used by this software : DirectX 9, Bink.
#
# CHANGELOG
# [Dadu042] (2019-09-07)
#   First script.
#   Can not save games sessions because of GFWL online.
# [Dadu042] (2020-01-11)
#   Wine 4.0.2 -> 4.0.3
#   arch 64 bits -> 32 bits (this may help when I will try POL_Remove_gfwl).
#   Fix VMS (before videodriver).
#
# KNOWN ISSUES:
# - Wine x86 4.0.2: crash as soon as loading (after black screen), after line '009f:fixme:d3d_shader:shader_sm4_read_instruction_modifier Unhandled modifier 0x00155543.' Tried: <directx forcedx9="true" />, d3dx9_43 + compiler.
# - Wine x86 4.15: same kind of crash symptom as above ('wine: Call from 0x7b45889c to unimplemented function usp10.dll.ScriptBreak, aborting'). usp10.dll = Uniscribe.
#                   Fix: install pol_usp10.
# - Wine x86 4.15: 'Error. SecuLauncher: failed to start application. [26000] <OK>'. Fix: NoCD necessary (I applyed patch v1.1 before the No CD v1.1, because I could not find a NoCD v1.0).
# - Wine x86 4.15: 'Error. SecuLauncher: failed to start application. [26000] <OK>'
# - Wine x86 4.0.2, 4.15: Mouse cursor not visible (perhaps normal).
#
#
# Tricks: https://pcgamingwiki.com/wiki/Colin_McRae:_DiRT_2
#
# Ideas to improve this script: select archive, then decide if extension is RAR or ZIP or 7Z...


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Colin McRae Dirt 2"
PREFIX="Colin_McRae_Dirt_2"
EDITOR="CodeMasters"
GAME_URL="https://en.wikipedia.org/wiki/Colin_McRae:_Dirt_2"
AUTHOR="Dadu042"
STEAM_ID="12840"
WORKING_WINE_VERSION="4.0.3"
GAME_VMS="256"
SHORTCUT_FILENAME="dirt2.exe"

SOFTWARE_CATEGORIES="Game;SportsGame;"
# Ref: http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
   
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

Set_OS "win7"

# POL_Call POL_Install_corefonts

# Uniscribe. To avoid error 'Call from 0x0XXXXXX to unimplemented function usp10.dll.ScriptBreak'
POL_Call POL_Install_usp10


# Installing mandatory dependencies
# POL_Call POL_Install_d3dx11

# Useful for Nvidia GPUs
# POL_Call POL_Install_physx

# POL_Call POL_Install_riched30
# POL_Call POL_Install_vcrun2005

# Seems not necessary with Wine 4.x
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43

# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "LOCAL,DVD,STEAM"

# To test
# # Pre-install fix - Need to backup dll because game setup install xlive and override it
# cd "$WINEPREFIX/drive_c/windows/system32/"
# cp xlive.dll xlive2.dll


# POL_SetupWindow_message "$(eval_gettext '\nWarning: at the end of installation, do not install Ageia Physx nor DirectX.')" "$TITLE"

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
	POL_Call POL_Function_NoCDWarning

        POL_SetupWindow_cdrom

        POL_SetupWindow_check_cdrom "setup.exe"
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
#	POL_Shortcut_Document "$TITLE" "Readme.txt"
         
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


# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Better than virtual desktop ?
POL_Wine_X11Drv "GrabFullScreen" "Y"
# POL_Wine_X11Drv "DXGrab" "Y"
# Ref: https://wiki.winehq.org/Useful_Registry_Keys

# To test (it's about Games For Windows Live)
#
# POL_Call POL_Remove_gfwl
# cd "$WINEPREFIX/drive_c/windows/system32/"
# cp xlive2.dll xlive.dll


################
# Patch update #
################
     
POL_SetupWindow_menu "$(eval_gettext 'Do you want to install a official patch-update ? (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
      
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi


POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhnJSgAKCRDlMfrJqhPK
R99pAJsH15DsfyfMmsTmhvaavlcXeEufzwCeJGojuCh9UECm9jCeLU/zC8C0+0c=
=sKlh
-----END PGP SIGNATURE-----
