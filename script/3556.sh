#!/bin/bash
#!/usr/bin/env playonlinux-bash
# Date : (2019-07-04)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested version : CD-ROMs, 2003.
#
# Game based on: DirectDraw 7, SmartSECURE DRM, richedit.
#
#
# CHANGELOG
# [Dadu042] (2019-07-04)
#   Initial writting. I used the retail CD-ROMs (french, 3 CD-ROMS).
#
# KNOWN ISSUES
# - When launching the game: "SmarteSECURE has trapped a windows resource error. Please re-run the application." 
#   ref https://lockergnome.com/2004/04/08/you-receive-a-smartesecure-has-trapped-a-windows-resource-error-error-message-when-you-start-dungeon-siege-legends-of-aranna/      the only workaround I found is to apply a 'NoCD'.

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
     
TITLE="Dungeon Siege: Legends of Aranna"
PREFIX="Dungeon-Siege-Aranna"
WORKING_WINE_VERSION="4.0.1"
AUTHOR="Dadu042"
EDITOR="Microsoft Game Studios"
GAME_URL="https://en.wikipedia.org/wiki/Dungeon_Siege"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE 4.3.4 is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
# POL_Wine_PrefixCreate
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"

# POL_Call POL_Install_mfc42
# POL_Call POL_Install_msxml4

# Useless ?
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3compiler_43

# No 'STEAM' because not available from their shop as of June 2019.
POL_SetupWindow_InstallMethod "LOCAL,CD"
 
# Safety recommendation
POL_SetupWindow_message "Note: at the end of the installation, please do not run the game." "$TITLE"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run (install.exe)')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
             
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/xxxxx
        POL_Wine_WaitBefore "$TITLE"
else
	POL_SetupWindow_message "Warning: the installation from CDs might fail when CD #2 inserted.\n\n Workaround: copy the CDs #2,3 into a folder of your HDD, the last to copy is the #1. Then you will have to make the installation from LOCAL." "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "pidgen.dll"
        POL_Wine start /unix "$CDROM/install.exe"
        POL_Wine_WaitExit "install.exe"
        cd "$POL_System_TmpDir"
fi
  
  
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/xxxxx"
else
        POL_Shortcut "DungeonSiege.exe" "$TITLE - DungeonSiege 1" ""
        POL_Shortcut "DSLOA.exe" "$TITLE" ""
	POL_Shortcut "DSVideoConfig.exe" "$TITLE - VideoConfig" ""
        POL_Shortcut_Document "$TITLE" "readme.rtf"
fi

################
# Patch update #
################
  
POL_SetupWindow_menu "$(eval_gettext 'Install a official patch-update ? (to download by yourself).')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"
  
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the .EXE file to run')" "$TITLE"
        PATCH_EXE="$APP_ANSWER"
        POL_Wine start /unix "$PATCH_EXE"
        POL_Wine_WaitExit "$PATCH_EXE"
fi
  
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXR424AAKCRDlMfrJqhPK
R8iCAJ9v4NBISLKzdcTYap9/SnLBybwk5ACfYW2JY+wcT9xzHvcv9bWT/PEfqEs=
=YCf4
-----END PGP SIGNATURE-----
