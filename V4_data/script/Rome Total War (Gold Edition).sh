#!/bin/bash
# Date : (2011-19-11 16-09)
# Last revision : (2011-19-11 23-52)
# Wine version used : 1.3.18, 1.3.25, 1.3.26, 1.3.27, 1.3.28, 1.3.29, 1.3.30, 1.3.31, 1.3.32, 1.3.33
# Distribution used to test : Ubuntu 11.10 x64
# Author : Ulrick(No)
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
# Setting the variables
TITLE="Rome Total War"
PREFIX="RTW"
WORKING_WINE_VERSION="1.3.31"
GAME_VMS="512"
DEVELOPER="Creative assembly"
SCRIPTCREATOR="Ulrick(No)"
COMPANYSITE="http://www.creative-assembly.co.uk/"

# Starting the script
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$DEVELOPER" "$COMPANYSITE" "$SCRIPTCREATOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
Set_Arch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,LOCAL"

# Installing mandatory dependencies
POL_Call POL_Install_dxfullsetup # To fix game crash
POL_Call POL_Install_devenum # To fix sound interruption
POL_Call POL_Install_dsound # To fix sound interruption
POL_Call POL_Install_vcrun6 # To fix game crash

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
# Asking for CDROM and checking if it's correct one
POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
POL_SetupWindow_cdrom
POL_Wine start /unix "$CDROM/setup.exe"
POL_Wine_WaitExit "$TITLE"
else
# Asking then installing DDV of the game
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
fi

## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##

# Making shortcut
POL_Shortcut "RomeTW.exe" "$TITLE" "" ""
POL_Shortcut "RomeTW-BI.exe" "Rome Total War-Barbarian Invasion" "" ""
POL_Shortcut "RomeTW-ALX.exe" "Rome Total War-Alexander" "" ""

# Final note
POL_SetupWindow_message "$(eval_gettext '$TITLE is installed!\n\nNote!\n1)Reboot wine\n2)Set correct output device in wine audio settings\n3)Have fun!')" "$TITLE"
 
# Exiting the  POL window
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk7Jcv8ACgkQ5TH6yaoTykc8zwCeOpreJ2wFcPoEpt6GYRkCxAHZ
3wgAoJlayrwk2ajxwAOPmkBBXkThM8PU
=c1NE
-----END PGP SIGNATURE-----
