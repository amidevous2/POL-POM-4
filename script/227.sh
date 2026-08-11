#!/bin/bash
# Last revision : see changelog
# Tested : Debian 6.0, Mac OSX , Kubuntu 18.04 amd64
# Author : Tinou
# Script licence : GPLv3
# 
# This script is designed for PlayOnLinux and PlayOnMac. 
#
# CHANGELOG
# [Quentin P] (2011)
#   Initial writting.
# [Quentin P] (2011-08-20 13-00) 
#   Update for POL/POM 4 
# [Dadu042] (2019-11-15 12-55)
#   Cleanup.
# [Dadu042] (2019-11-30 22-15)
#   Fix audio.
#   Try to understand the 'no keyboard' issue (set sound before the installer ? one of the two .EXE ?).
# [Dadu042] (2019-12-01 14-00)
#   Wine 4.0.2 -> 3.0.3 (to let more POL users to play the game because Wine 4.0.2 requires POL 4.3.4).
#   Game version used: v2.11.26 (it's displayed on the launcher window, top bar).

# KNOWN ISSUES:
#  - Wine amd64 4.0.2: No sound nor music. Fix: force Alsa.
#  - Wine amd64 2.22, 3.0.3, 3.21, 4.0.2 english/french, 4.0.3: keyboard does not work (so the game is not keyboard playable). https://bugs.winehq.org/show_bug.cgi?id=13705
#  - Wine amd64 4.0.2: the debug log shows errors about missing POL_Install_riched30, once installed it crash until POL_Install_msls31 is installed. But then, the game crash to load...
#  - Wine amd64 3.0.3, 4.0.2, 4.0.3: Game installer does end, but POL (v4.3.4) does not notice it.. Workaround: create the shortcuts manually. Tried: 'POL_Wine start /unix'.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Trackmania Nations Forever"
WORKING_WINE_VERSION="3.0.3"

POL_GetSetupImages "$SITE/setups/tmnf/top.jpg" "$SITE/setups/tmnf/left.jpg" "tmnf"
POL_Debug_Init
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Focus Home Interactive" "http://www.trackmaniaunited.com/" "Tinou" "TMNations"
 
POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"


POL_Wine_SelectPrefix "TMNations"

# Determine Architecture
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"


if [ "$POL_SELECTED_FILE" = "" ]
then
    cd "$HOME"
    # POL_SetupWindow_message "$TITLE setup file is needed before to continue....\n\nDownload it here:\n\nhttp://www.trackmaniaunited.com/" "$TITLE"
    POL_SetupWindow_browse "Where is the installation file of $TITLE?" "$TITLE"
    CHEMIN="$APP_ANSWER"
else
    CHEMIN="$POL_SELECTED_FILE"
fi


POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
Set_OS "vista"

# POL_Call POL_Install_riched30
# POL_Call POL_Install_msls31


if [ "$PLAYONMAC" = "" ]
then
    # PlayonLinux

# Was useful before 2019:
# Setting default path for installers
#POL_LoadVar_PROGRAMFILES
#    Set_SoundDriver "oss"
#    cd "$REPERTOIRE/wineprefix/TMNations/drive_c/$PROGRAMFILES/TmNationsForever/"
#    POL_SetupWindow_download "Downloading wrap_oal.dll" "$TITLE" "$SITE/dlls/wrap_oal.dll"
    
    # Sound problem fix - pulseaudio related.
    [ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
    [ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
    # End Fix
fi

cd "$REPERTOIRE/tmp"
 
POL_SetupWindow_wait "Installing $TITLE" "$TITLE"
 
Set_Managed Off

# /silent makes the installation a bit faster (no questions).
POL_Wine "$CHEMIN" "/silent"


if [ "$PLAYONMAC" = "" ]
then
    # It's PlayonLinux.
    
    # If the content of this 'if' is empty, this seems to block POL 4.3.4.
    POL_SetupWindow_message "$(eval_gettext 'Debug: PlayonLinux is running this script.')" "$TITLE"

else
    # It's PlayonMac.

    # Setting default path for installers
    POL_LoadVar_PROGRAMFILES
    cd "$REPERTOIRE/wineprefix/TMNations/drive_c/$PROGRAMFILES/TmNationsForever/"
    POL_SetupWindow_download "Fixing sound issue..." "$TITLE" "$SITE/divers/tmnf.zip"
    unzip tmnf.zip
    POL_Call POL_Function_OverrideDLL native,builtin openal32 wrap_oa
fi

POL_Shortcut "TmForever.exe" "$TITLE" "" "" "Game;SportsGame;" 
POL_Shortcut "TmForeverLauncher.exe" "$TITLE - Launcher" "" "" "Game;SportsGame;" 

# POL_SetupWindow_message "$TITLE has been successfully installed." "Track Mania Nation For Ever"

POL_SetupWindow_message "$(eval_gettext 'WARNING: to avoid to have huge log file, you should type \ninto Debug flags : fixme-all')" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXeQgkwAKCRDlMfrJqhPK
RyNrAJwK7nVwwqdUmU3pyWmacH5IvGsLfQCdEnIoKXi6zjU4J1bcg2xEvU4X84Y=
=h/UN
-----END PGP SIGNATURE-----
