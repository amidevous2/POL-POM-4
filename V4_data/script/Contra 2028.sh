#!/bin/bash
# Date : (2019-08-12)
# Last revision : see Changelog
# Wine version used : see Changelog
# Distribution used to test : KUbuntu 18.04
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED (with succcess): ContraReboot.exe	2017-12-24
#
# Game based on : Unreal Engine 4 ?, DirectX 11.
#
# CHANGELOG
# [Dadu042] (2019-08-12)
#   First script.
#
# KNOWN ISSUES
# Wine 3.0.3 : crash when loading ('LowLevelFatalError')
#              002b:fixme:d3d:wined3d_buffer_create Ignoring access flags (pool).
#              0031:fixme:dbghelp:elf_search_auxv can't find symbol in module
#              0029:fixme:kernelbase:AppPolicyGetProcessTerminationMethod 0xfffffffffffffffa, 0x60fd20
#
# Wine 4.0.1 : crash when loading ('LowLevelFatalError'). Fix: d3d11
#              007b:fixme:d3d_shader:shader_sm4_read_instruction_modifier Unhandled modifier 0x00155543.
#              0068:fixme:dbghelp:interpret_function_table_entry PUSH_MACHFRAME 9
#              0068:fixme:dbghelp:interpret_function_table_entry PUSH_MACHFRAME 8
#              0068:fixme:dbghelp:interpret_function_table_entry PUSH_MACHFRAME 7
#              0068:fixme:dbghelp:interpret_function_table_entry PUSH_MACHFRAME 6
#              AL lib: (EE) ReleaseThreadCtx: Context 0x7d450700 current for thread being destroyed, possible leak!
#              0065:fixme:kernelbase:AppPolicyGetProcessTerminationMethod 0xfffffffffffffffa, 0x60fd20
#
# Wine 4.0.1 : Cliks sounds on main menu over the music.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Contra 2028"
PREFIX="Contra_2028"
EDITOR="Contragon"
GAME_URL="https://contragon.itch.io/"
AUTHOR="Dadu042"
STEAM_ID="242920"
WORKING_WINE_VERSION="4.0.1"
GAME_VMS="512"
  
# Starting the script
POL_SetupWindow_Init
  
# Starting debugging API
POL_Debug_Init
 
# Open dialogue box 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Determine Architecture
POL_System_SetArch "amd64"
 
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Installing mandatory dependencies
POL_Call POL_Install_d3dx11
# POL_Call POL_Install_physx

# POL_Call POL_Install_xact

# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "LOCAL,STEAM"

# Disable Steam In Game Overlay
# POL_Wine_OverrideDLL "" "gameoverlayrenderer" # To disable the DLL
  
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Call POL_Install_steam
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" == "DOWNLOAD" ];then
        POL_Download "https://www.villagers-and-heroes.com/VHSetup.exe"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine "VHSetup.exe" "/SILENT"

        POL_Shortcut "ContraReboot.exe" "$TITLE" "$TITLE.png" "" "Game;Shooter"
                
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
 
        POL_SetupWindow_menu "$(eval_gettext 'What is the type of the file?.')" "$TITLE" "$(eval_gettext '.EXE')~$(eval_gettext '.ZIP')~$(eval_gettext '.RAR')" "~"

if [ "$APP_ANSWER" == ".EXE" ]; then

        # Asking then installing local copy of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"

        POL_Shortcut "ContraReboot.exe" "$TITLE" "$TITLE.png" "" "Game;Shooter"
        
elif [ "$APP_ANSWER" == "$(eval_gettext '.ZIP')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .ZIP file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
 
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/"
        
        POL_Shortcut "ContraReboot.exe" "$TITLE" "$TITLE.png" "" "Game;Shooter"
        
elif [ "$APP_ANSWER" == "$(eval_gettext '.RAR')" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .RAR file')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        cd "$POL_System_TmpDir"
 
        POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
        POL_System_unrar x "$APP_ANSWER" "$WINEPREFIX/drive_c/"
        
        POL_Shortcut "ContraReboot.exe" "$TITLE" "$TITLE.png" "" "Game;Shooter"
fi
fi

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXVWdQgAKCRDlMfrJqhPK
R8rLAKCMwptcinyRWFEiwaxsBmYKGeWBZQCgk0wmJop813o/w4nwSmIs3gbmrkc=
=zVTT
-----END PGP SIGNATURE-----
