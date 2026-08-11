#!/usr/bin/env playonlinux-bash
# Date : (2019-05-04 12-07)
# Last revision : (2019-05-04 12-07)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : ?
#
# Playonlinux version used : 4.3.4
#
# -----------------------
#
# Issues known :
# None

  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Tonic Trouble"
PREFIX="Ubisoft"
WORKING_WINE_VERSION="4.0"
AUTHOR="Dadu042"
EDITOR="Ubisoft"
GAME_URL="https://en.wikipedia.org/wiki/Tonic_Trouble"
  
Set_OS "WinXP"
  
POL_SetupWindow_Init
POL_Debug_Init
      
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

# Size of the RAM required for the video card
POL_SetupWindow_VMS "64"

POL_Call POL_Install_VideoDriver
POL_Call POL_Install_dinput
POL_Call POL_Install_mfc42

###############
# Go          #
###############
 
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
        POL_SetupWindow_check_cdrom "setup.exe"
        POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "setup.exe"
        cd "$POL_System_TmpDir"
fi
 
POL_Shortcut "Tonic.exe" "$TITLE" ""
POL_Shortcut_Document "$TITLE" "manual.pdf"
 
Set_WineWindowTitle "$TITLE"


#######################################
# Create a 'virtual desktop' (window) #
#######################################
 
POL_SetupWindow_menu_list "$(eval_gettext "Choose the resolution of the game window.")" "$TITLE" "800x600-1152x864-1024x768-1280x720-1280x800-1280x900-1280x1024-1360x768-1440x900-1400x1050-1600x900-1600x1024-1680x1050-1920x1080" "-" "800x600"

resolution="$APP_ANSWER"
WIDTH="$(echo $resolution | cut -d"x" -f1)"
HEIGHT="$(echo $resolution | cut -d"x" -f2)"
 
Set_Desktop "On" "$WIDTH" "$HEIGHT"

    
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUNYTAAKCRDlMfrJqhPK
RxKWAJ4k64JcySl9d6BO4lrq1djZsRa02wCeJbXw99+63XG4J+iq7hMNIg9NGZ0=
=4MWQ
-----END PGP SIGNATURE-----
