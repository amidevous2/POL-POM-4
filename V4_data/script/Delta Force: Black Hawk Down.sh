#!/usr/bin/env playonlinux-bash
# Date : (2019-06-01 16-10)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Media used: CD-ROM V1.2.2.4 (see file VERSION.TXT once installed). May 2003 (in /DFBHD/).
#
# CHANGELOG:
# [Dadu042] (2019-06-01 16-10)
#   Initial script.
# [Dadu042] (2019-12-30)
#   Wine 3.21 -> 3.20 (max available on POL v4.2.12)
#   Add POL_RequiredVersion (v4.0.0)
#   Fix a POL_Shortcut
#
# KNOWN ISSUES:
# None.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Delta Force: Black Hawk Down"
PREFIX="delta_force_BHD"
WORKING_WINE_VERSION="3.20"
AUTHOR="Dadu042"
EDITOR="NovaLogic"
GAME_URL="https://en.wikipedia.org/wiki/Delta_Force:_Black_Hawk_Down"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

Set_OS "winxp"

################
# GPU settings #
################

# Really indispensable ? (Dadu042)
POL_SetupWindow_VMS "32"

POL_Call POL_Install_VideoDriver

# Useless ?
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3compiler_43

# Useless because On by default (Set if the window manager will be allowed to manage Wine windows.)
# Set_Managed "On"

# POL_Wine_X11Drv "DXGrab" "Y"
# Was used in 2009:
# Set_DXGrab "On"

###############
# Go          #
###############

POL_SetupWindow_InstallMethod "LOCAL,CD"

POL_SetupWindow_message "Note: at the end of the installation, DO NOT install DirectX when asked."


if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
else

        POL_SetupWindow_cdrom
      #  POL_SetupWindow_check_cdrom "$CDROM/DFBHD/DFBHDLC.EXE"
        POL_SetupWindow_check_cdrom "AUTOPLAY.BAT"
        POL_Wine start /unix "$CDROM/DFBHD/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi

POL_Shortcut "dfbhd.exe" "$TITLE" "" "" "Game;"
POL_Shortcut_Document "$TITLE" "DFBHDMAN.PDF"

POL_Shortcut "dfbhdlc.exe" "$TITLE - LAN only" "" "" "Game;"

POL_Shortcut "dfbhdmed.exe" "$TITLE - Mission editor" "" "" "Game;"

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgqWcgAKCRDlMfrJqhPK
R0fmAJ40ACLo34u5BVDZDG39Jo43n74FjQCeNHKPYEU7E7G+F8QXCqpsphcFOMg=
=CI1x
-----END PGP SIGNATURE-----
