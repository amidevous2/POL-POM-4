#!/bin/bash
# Date : (2019-04-13 14-33)
# Last revision : (2019-04-13 14-33)
# Wine version used : 4.0
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested : CD-ROM v1.0 french provided with a magazine edited by Future Press (PC Jeux/PC Gamer).
#          Latest file: Install.Exe (2003).
#
# Game released with DirectX 8.
#
# Know issue :
# - Patch v1.1 (called 'Upgrade v1.1') when installed prevent the game to start.
#   (Error message: 'Unimplemented function Util.dll.?AddLibrary@LuaLibMan' ...)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Impossible Creatures"
PREFIX="impossible-creatures"
WORKING_WINE_VERSION="4.0"
AUTHOR="Dadu042"
EDITOR="Microsoft"
GAME_URL="https://en.wikipedia.org/wiki/Impossible_Creatures"

Set_OS "Windows XP"

POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Minimum version to have access to Wine 4.x
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

# This seems useless for this game (Wine 4.0)
# POL_Call POL_Install_d3dx9

# Without this, ICCONFIG.EXE crash when launched.
POL_Call POL_Install_mfc42

POL_SetupWindow_InstallMethod "LOCAL,CD"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "game/IC.EXE"
        POL_Wine start /unix "$CDROM/Install.Exe"
        POL_Wine_WaitExit "Install.Exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "IC.exe" "$TITLE" "" 
POL_Shortcut "ICConfig.exe" "$TITLE - Config" "" 
POL_Shortcut "MissionEditor.exe" "$TITLE - Mission Editor" "" 

POL_Shortcut_Document "$TITLE" "IC Control.rtf"
# The user guide stays on the CD-ROM (filename: ImpossibleCreatures_Manual.pdf )

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiDWwAKCRDlMfrJqhPK
R9paAJ0fcagna1JhCdu/q/VLrUC+us6oXQCbBPoTtOlHjGRUS62DL9tjapg5LLQ=
=Lf2S
-----END PGP SIGNATURE-----
