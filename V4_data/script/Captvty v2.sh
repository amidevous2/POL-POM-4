#!/usr/bin/env playonlinux-bash
# Date : (2019-05-14 09:08)
# Last revision : See changelog below
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
#
# Playonlinux version used : 4.3.4
#
# Software used to write the script : Captvty v2.8.2 (2019), v2.8.8.1 (2020).
# Software based on : MS VisualBasic, MS DotNet.
#
#
# CHANGELOG
# [Dadu042] (2019-05-14 09:08)
#   First version.
# [Dadu042] (2019-07-14 12:43) 
#   Add GDIplus (useless). 
#   Add more comments.
# [Dadu042] (2019-07-14 14:24)
#   Software started without crashing ("CLR error: 80004005"). Fix is Dotnet461 (instead of Dotnet40), very long to install (30 min?).
# [Dadu042] (2019-07-14 19:07)
#   Translate some parts to french because this software is only for french speakers.
# [Dadu042] (2019-09-20)
#   Wine 4.0.1 -> 4.0.2
#   Fix path name.
#   winxp -> win7.
#   Add warning about Dotnet461 that might never end.
# [Dadu042] (2019-12-30)
#   Add POL_RequiredVersion
#   Wine 4.0.2 -> 4.0.3
# [Dadu042] (2020-03-09 11:57)
#   OK with v2.8.8.1 (2020)
# 
#
# KNOWN ISSUES :
# - "CLR error: 80004005. The program will now terminate.": s'ouvre aussitôt l'appli lancée 
#   (arrive avec Captvty v2.7.13, v2.7.15. Wine v4.0.1, 4.12.1)  OK avec Dotnet461 (+ wine 4.12.1) au liee de Dotnet40.
# - "Ouvrir le dossier l'emplacement du fichier" (via clic droit) plante l'appli ("Erreur inattendue"). Arrive avec Wine 4.0.1 et 4.12.1 sans aucun Vcrun d'installé.
#
#
# IMPROVEMENT IDEAS: 
# - change the Videos output folder to the OS's Videos folder.
# - add a option to upgrade the software (it is provided as a .ZIP).

  
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Captvty"
PREFIX="captvty"
WORKING_WINE_VERSION="4.0.4"
AUTHOR="Dadu042"
EDITOR="Guillaume"
GAME_URL="https://captvty.fr"
APP_ID="2795"
  
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
  
  
# Seem useless
# POL_Call POL_Install_gdiplus
 
POL_SetupWindow_message  "Attention: si l'installation de Dotnet ne se termine jamais, patientez plusieurs minutes (ex: 20) puis fermez la fenêtre.\n\nWarning: If the installation of DotNet never end, wait many minutes (ie: 20) then close the window." "$TITLE"
POL_Call POL_Install_dotnet461
# POL_Call POL_Install_dotnet40
  
# Should be useful for msvcr90.dll, file located inside /tools/
# POL_Call POL_Install_vcrun2005
  
# Should be useful for msvcr100.dll, file located inside /tools/
# POL_Call POL_Install_vcrun2010

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX56m0AAKCRDlMfrJqhPK
RzTJAJsEQbkv7SpFkN879LWGyLV+hbmGOgCghD3B/lMRwv+x4YoOAlSduAVo4cM=
=9TIf
-----END PGP SIGNATURE-----
