#!/bin/bash
# Date : (2013-07-08 11-01)
# Last revision : see changelog
# Distribution used to test : Xubuntu 18.04 x64
# Script licence : GPL3
# Author : Quentin PÂRIS
# Program licence : ?
# PlayOnLinux : 4.3.4
 
# CHANGELOG
# [Quentin PÂRIS] (2014)
#    - First script wrote ?
# [Yaotl] (2019-03-18)
#    - Upgrade wine to 4.3
#    - swtor_fix.exe re-inserted (without it does not start properly)
#    - launcher-settings different changes and add language selection
#    - Add Set_Desktop (to avoid display problems in the system and game)
#    - Add client_settings.ini modification (for a quick first start, without it can take up to 1 hour)
# [Dadu042] (2019-05-23)
#    - Add POL_RequiredVersion (mainly because of Wine 4.3)
#    - Standardize script (top infos).
# [Yaotl] (2019-07-08)
#    - Upgrade wine 4.3 to 4.12.1 (many bug fixes)
#    - Small script changes
# [Dadu042] (2019-09-06) - Tested on POL, not POM.
#    - Wine 4.12.1 -> 4.11 (because 4.12.1 not available on POM yet)
#    - d3dx9 update to d3dx9_43 + d3dcompiler_43
#    - Add winhttp because several reports in Appdb.winehq.org recommend it.
#    - Standardize GAME_VMS.
#    - Add GPU Selection (if there are 2).
#    - Add riched30 (because errors found in the POL's installation log, Wine 4.11)
#    - Add msls31 (because riched30 added a crash because msls missing).
# [Dadu042] (2020-03-19)
#    - Wine 4.11 (outdated) -> 4.21
# [Yaotl] (2020-07-16)
#    - Update Wine 4.21 -> 5.12
#    - Language selection revised.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Star Wars: The Old Republic"
PREFIX="SWTOR"
WINEVERSION="5.12"
GAME_VMS="256" # Minimum MB of VRAM required on the GPU (according the 'readme.txt' after installation).
DOWNLOAD_URL="https://swtor-a.akamaihd.net/installer/SWTOR_setup.exe"
MD5_CHECKSUM="e706b4b4b9618b0eee5e1917da6fcf4e"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2135
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "LucasArts & Bioware" "https://www.swtor.com/" "Quentin PÂRIS" "$PREFIX"
 
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."
 
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#######################################
# Setup GPU                           #
####################################### 
  
# Set Graphic Card (useful if laptop with dual GPU)
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

#######################################
# Misc.                               #
####################################### 

# Dependencies
POL_Call POL_Install_corefonts
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_d3dx9_43
POL_Call POL_Install_d3dcompiler_43
POL_Call POL_Install_winhttp
POL_Call POL_Install_riched30
POL_Call POL_Install_msls31
 
# Configuration
Set_OS "win10"
 
#################################################
# Set window the resolution to use for the game #
#################################################
 
Set_Desktop "On" "1024" "768"
 
########################################################
# Push window resolution into the game's settings file #
########################################################
 
mkdir -p "$WINEPREFIX/drive_c/users/$USER/Local Settings/Application Data/SWTOR/swtor/settings"
cd "$WINEPREFIX/drive_c/users/$USER/Local Settings/Application Data/SWTOR/swtor/settings"
cat << EOF > "client_settings.ini"
[Renderer]
NativeWidth = 1024
NativeHeight = 768
Width = 1024
Height = 768
EOF
 
######################
# Language selection #
######################
 
if [ "$POL_LANG" = "fr" ]; then
    lang="fr-fr"
elif [ "$POL_LANG" = "de" ]; then
    lang="de-de"
else
    lang="en-us"
fi
 
######################
# Install Method     #
######################

POL_System_TmpCreate "$PREFIX"
 
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    # Downloading client
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOAD_URL" "$MD5_CHECKSUM"
    SETUP_EXE="$PWD/SWTOR_setup.exe"
else
    # Asking for client exe
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
fi
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "$SETUP_EXE" "/q"
POL_Wine_WaitExit "$TITLE"
 
############################################
# Set customized settings for the Launcher #
############################################
 
cd "$WINEPREFIX/drive_c"
cat << EOF > "$(find ./ -iname launcher.settings)"
{ "Login": ""
, "LastProduct": ""
, "downloadRate": "0"
, "language": "$lang"
, "TestServerAccess": "No"
, "SpecHash": ""
, "AutoClose": "NONE"
, "KillKillProc": "false"
, "LastMode": "PROD"
, "PatchingMode": "{ \"swtor\": \"SSN\" }"
, "bitraider_download_complete": { }
, "log_levels": "INFO,SSNFO,ERROR"
, "bitraider_disable": true
, "DevLogin": ""
, "EnableAutoEnvironment": "false"
, "LastEnvironment": ""
, "loglevels": "INFO,SSNFO,ERROR"
, "P2PEnabled": "false"
, "enableRateLimit": "false"
, "uploadRate": "0"
, "InternalLaunchpad": "null"
, "InternalGamepad": "null"
, "ExternalLaunchpad": "null"
, "ExternalGamepad": "null"
, "HardPatcherMode": "PROD"
, "PickedEnvironments": "swtor"
}
EOF
 
POL_Shortcut "launcher.exe" "$TITLE" "" "" "Game;"
 
######################
#  Fix installation  #
######################
# https://github.com/aljen/swtor_fix
 
cd "$WINEPREFIX/drive_c/"
POL_Download "https://repository.playonlinux.com/divers/swtor_fix.exe" "b3b1edcbee4e130760ebd2e1139cc764"
mv swtor_fix.exe "$(dirname "$(find ./ -iname launcher.exe)")"
POL_Shortcut_InsertBeforeWine "$TITLE" "POL_Wine start /unix swtor_fix.exe \"\$@\""
 
POL_Call POL_Message_OSXFlicker

POL_SetupWindow_message "$(eval_gettext '\nInstallation is finished ! :)')" "$TITLE"

# Cleanup
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXxCopAAKCRDlMfrJqhPK
R3NWAJ9VyQvZVGzJyatSErCm0uIEE/o5BwCgkBVZDaiENtVMGJA5CrDNLmqZuwQ=
=OU3M
-----END PGP SIGNATURE-----
