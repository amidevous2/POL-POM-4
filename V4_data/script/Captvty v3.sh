#!/usr/bin/env playonlinux-bash
# Date : (2020-03-03)
# Last revision : See changelog below
# Wine version used : see below
# Distribution used to test : Ubuntu 18.10 amd64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Software used to write the script : Captvty  3.0.0.65022 (2020-02)
# Software based on : MS VisualBasic, MS DotNet.
#
#
# CHANGELOG
# [Dadu042] (2020-03-03)
#   First version, from script for v3.
# [Dadu042] (2020-09-10)
#   Provide choice between different versions of DotNet.
#   Wine 4.0.3 -> 4.0.4
# 
#
# KNOWN ISSUES :
# - x
#
#
# IMPROVEMENT IDEAS: 
# - change the Videos output folder to the OS's Videos folder.
# - add a option to upgrade the software (it is provided as a .ZIP).
 
   
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="Captvty v3"
PREFIX="captvty_v3"
WORKING_WINE_VERSION="4.0.4"
AUTHOR="Dadu042"
EDITOR="Guillaume"
GAME_URL="https://captvty.fr"
   
POL_SetupWindow_Init
POL_Debug_Init
      
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
  
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
   
Set_OS "win7"
   
# POL_SetupWindow_message  "Please note: once installed the program does not run.\n" "$TITLE"
   
###############
# Go          #
###############
   
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup ZIP file to extract.')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
   
cd "$POL_System_TmpDir"
TARGET_DIR="$WINEPREFIX/drive_c/CapTvTy"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"
   
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Extracting the archive...')" "$TITLE"
   
POL_System_unzip "$APP_ANSWER" -d "$WINEPREFIX/drive_c/CapTvTy/"
   
POL_Shortcut "Captvty.exe" "$TITLE" "" "" "AudioVideo;"



##################
# Install DotNet #
################## 

POL_SetupWindow_menu "$(eval_gettext 'Quelle version de DotNet installer ? (la première étant recommandée)')" "$TITLE" "$(eval_gettext 'v4.6.1')~$(eval_gettext 'v4.5.0')~$(eval_gettext 'v4.8.0')" "~"

POL_SetupWindow_message  "Attention: si l'installation de Dotnet ne se termine jamais (plus 30 minutes), fermez la fenêtre.\n\nWarning: If the installation of DotNet does never end (> 30 minutes), do close the window." "$TITLE"

if [ "$APP_ANSWER" == "v4.6.1" ]; then
	POL_Call POL_Install_dotnet461

elif [ "$APP_ANSWER" == "$(eval_gettext 'v4.5.0')" ]; then
	POL_Call POL_Install_dotnet45

elif [ "$APP_ANSWER" == "$(eval_gettext 'v4.8.0')" ]; then
	POL_Call POL_Install_dotnet480
fi



#######################################
#  Installing mandatory dependencies  #
#######################################

# Seem useless
# POL_Call POL_Install_gdiplus
   
# Should be useful for msvcr90.dll, file located inside /tools/
# POL_Call POL_Install_vcrun2005
   
# Should be useful for msvcr100.dll, file located inside /tools/
# POL_Call POL_Install_vcrun2010

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX1pWpwAKCRDlMfrJqhPK
R3MjAJ9O1gUhdW/NV6qFYBgANf/2swLWuACghbmHXA3LrUAo7yKZCbE8w7q2b2w=
=3yaF
-----END PGP SIGNATURE-----
