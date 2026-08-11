#!/bin/bash
# Date : (2019-04-12 11-54)
# Last revision : (2019-04-12 11-54)
# Wine version used : 3.0.5
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4
#
# Tested : CD v1.0 french (Setup\bzone.exe : 4th feburary 2000).
# Game released with DirectX 7.
#
# Does also work with official game patches v1.1 and v1.2 (to install from POL -> Setup -> Misc -> Run a EXE in this virtual disk)
#
# Know issues :
# - Game window sizes are incorrect and hazardous on my laptop (1366x768, Ubuntu 18.04) 
# - Wine 4.0 and 4.5 : main menu impossible to use because of many freezes (mouse cursor, animations).

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Battlezone II: Combat Commander"
PREFIX="battlezone2"
WORKING_WINE_VERSION="3.0.5"
AUTHOR="Dadu042"
EDITOR="Activision"
GAME_URL="https://en.wikipedia.org/wiki/Battlezone_II:_Combat_Commander"

Set_OS "Windows 98"
# Set_OS "win98"

# Set_Desktop On 1024 768

Set_SoundDriver "oss"

POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Minimum version to have access to Wine 3.0.5
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

# Seems useless for this game
POL_Call POL_Install_d3dx9

# Try to avoid multiple micro freezes (without success)
# POL_Call POL_Install_gdiplus

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
        POL_SetupWindow_check_cdrom "BZII.DBD"
        POL_Wine start /unix "$CDROM/setup.exe"
        POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "bzone.exe" "$TITLE" "" 

POL_Shortcut_Document "$TITLE" "INDEX.HTM"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0


# COMMON COMMAND LINE OPTIONS (tricks found in the file render.cfg)
#
#     "/win"                 run in a window
#     "/nointerface"         disable HUD (e.g. during playback)
#     "/trackfps"            display frame rate, polygon count, polygon rate (kps)
#     "/benchmark"           run recorded session using a fixed clock (one tick per frame)
#     "/record [fileName]"   record a session
#     "/playback [fileName]" play back a session
#     "/nointro"             disable intro movie
#     "/resolution [w h]"    force resolution (overrides menu selection)
#     "/depth [bbp]"
#     "/videodriver [n]"     1 to force secondary video card (overrides menu selection)
#     "/nods"                disable sound
#     "/nods3d"              disable 3d-sound
#     "/login [PilotName]"   use PilotName's preferences (e.g. to run benchmark)
#     "/aipLogging"          enable trace of *.AIP file processing (into schedLog[N].txt)

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiDkQAKCRDlMfrJqhPK
R2PPAKCSiPHtpa0TpfHHDi4ctg2eu3qn4wCaAjSI+NgVE9IFjXy6fnFzRaJcbmE=
=UwS7
-----END PGP SIGNATURE-----
