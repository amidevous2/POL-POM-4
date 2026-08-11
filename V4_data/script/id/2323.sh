#!/bin/bash
# Date : (2014-10-28 14:30)
# Last revision : see changelog
# Wine version used : see changelog
# Distribution used to test : Xubuntu 18.04 64 bits
# Author : Tutul
# License : GNU/GPL v3
 
# CHANGELOG
# [Tutul] (2014-10-28 14:30)
#   Initial script. Wine 1.7.10
# [Tutul] (2014-11-20 16:37)
#   ?. Wine 1.7.29, Fedora 20 - 64 bits
# [Dadu042] (2020-01-15 22:50)
#   Wine 1.7.29 -> 2.22, because outdated.
# [Dadu042] (2020-09-24 16:00)
#   Download feature: MD5 checksum updated.
#   Wine 2.22 -> 3.0.3 (tested: installer).
 
## Beta script ##
# TODO (2014) : correct the crash when loading acount for the second time.
    
[ "$PLAYONLINUX" = "" ] && exit 1
source "$PLAYONLINUX/lib/sources"
    
TITLE="Rift"
PREFIX="Rift"
EDITOR="Trion Worlds"
GAME_URL="http://www.riftgame.com"
AUTHOR="Tutul"
GAME_VMS="256"
STEAM_ID="39120"
    
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2323
    
# Starting debugging API
POL_Debug_Init
    
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
    
# Setting Wine Version
WORKING_WINE_VERSION="3.0.3"
    
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
    
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Create TMP directory
POL_System_TmpCreate "$PREFIX"
    
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
    
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
  
# Install mandatory dependencies
POL_Call POL_Install_d3dx9
POL_Call POL_Install_d3dcompiler_43
POL_Call POL_Install_corefonts # Fix password field font
POL_Call POL_Install_xact
 
# Fix Installer crash
Set_OS "winxp"
    
# Choose between Downloading client or using local one or STEAM version
POL_SetupWindow_InstallMethod "STEAM,DOWNLOAD,LOCAL"
    
# Downloading client or choosing existing one
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    # Downloading client
    cd "$POL_System_TmpDir"
    POL_Download "http://download.dyn.triongames.com/GlyphInstall-0-1.exe" "9e2360e9d48deee6dc08d77175f41565"
    SETUP_EXE="GlyphInstall-0-1.exe"
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
    # Asking for client exe file
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
else
    POL_Call POL_Install_steam
    POL_Call POL_Install_steam_flags "$STEAM_ID"
fi
 
# Fix Glyph launch crash (2014)
POL_Call POL_Function_OverrideDLL native,builtin msvcr110
POL_Call POL_Function_OverrideDLL native msvcr120
 
# Run the install
POL_Wine_WaitBefore "$TITLE"
if [ "$INSTALL_METHOD" == "STEAM" ]; then
    POL_SetupWindow_message "$(eval_gettext 'The launcher can still self update after installation')" "$TITLE"
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
else
    POL_Wine $SETUP_EXE
fi
POL_Wine_WaitExit "$TITLE"
 
# Fix Graphic bugs
POL_Wine_Direct3D "UseGLSL" "enabled"
POL_Wine_Direct3D "DirectDrawRenderer" "opengl"
POL_Wine_Direct3D "OffscreenRenderingMode" "fbo"
POL_Wine_Direct3D "Multisampling" "disabled"
POL_Wine_Direct3D "StrictDrawOrdering" "enabled"
 
# Fix intro bug
POL_Call POL_Function_OverrideDLL builtin,native d3dx9_43
 
# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
    POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID" "Game;"
else
    POL_Shortcut "GlyphClient.exe" "$TITLE" "$TITLE.png" "" "Game;"
fi
    
# Deleting temp files
POL_System_TmpDelete
    
# Closing POL
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX2zMcQAKCRDlMfrJqhPK
R9VBAJ0UvCu6P4xyQtK5LSLFgutzqXBBjQCeMGpitpNUhYD3TdrCoHlZBVXIXHY=
=Ymuz
-----END PGP SIGNATURE-----
