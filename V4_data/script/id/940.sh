#!/bin/bash
# Date : (2012-01-29)
# Last revision : See changelog
# Wine version used : System
# Distribution used to test : XUbuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.3.4

# CHANGELOG:
# [Catskan] 2012 ?
#   First version ?
# [SuperPlumus] (2012-01-29 08-02)
#   Correction syntax error (!)
#   Change prefix name
#   Add $PREFIX var
#   Update gettext message
# [Dadu042] (2019-08-07)
#   Disable Wine 1.3.37, use System's Wine version (usally at least 2x. or 3.0 nowadays).
#   Disable POL_Browser before installing (why opening the website now ?).
# [Dadu042] (2019-12-08)
#   Standardize System wine. 
# [Dadu042] (2019-12-26)
#   Force OS to win7
#   Force x86
#   dotnet20 -> dotnet40
#   Disable IE6
# [Dadu042] (2022-04-10)
#   Wine 1.3.37 -> 4.0.4 (untested, it's because Wine 1.x is unable to run since Ubuntu 18.04)
#   + POL_Install_vcrun2015 (it seeems required according a user report)
#   - POL_Install_wininet (usually useless with current Wine versions)
#
# KNOWN ISSUES:
# - Wine 4.0.1: install work up to 90% then no window -> it's because it is updating.
# - Wine 4.0.1: Can not type in the login box, when the app windowed (OK when full screen).
# - Wine 4.0.1: No web page displayed in the installer, just a white color (however it seems not to block the installation). However I canceled the installation of IE6 before. Tried: gecko install.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Runes Of Magic"
PREFIX="RunesOfMagic"
WORKING_WINE_VERSION="4.0.4"
   
POL_Debug_Init
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Frogster" "http://www.runesofmagic.com/" "Catskan" "$PREFIX"
  
# POL_Browser "http://www.runesofmagic.com/"
   
#Wine preparation
POL_Wine_SelectPrefix "$PREFIX"

POL_System_SetArch "x86"

POL_Wine_PrefixCreate
# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "win7"

# Installing POL_functions

POL_Call POL_Install_dotnet40
POL_Call POL_Install_vcrun2015

# POL_Call POL_Install_wininet
# POL_Call POL_Install_ie6
# POL_Call POL_Install_vcrun2010

Set_OS "win7"
 
cd "$POL_USER_ROOT/tmp"
   
if [ "$POL_SELECTED_FILE" = "" ]
then
POL_SetupWindow_message "$(eval_gettext 'You can download $TITLE install file here:')\n\nhttp://www.runesofmagic.com/" "$TITLE"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
CHEMIN="$APP_ANSWER"
else
CHEMIN="$POL_SELECTED_FILE"
fi
POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
   
Set_Managed Off
POL_Wine "$CHEMIN"
  
   
POL_Shortcut "launcher.exe" "$TITLE Launcher" "" "" "Game;RoleGame;"
POL_Shortcut "Runes Of Magic.exe" "$TITLE" "" "" "Game;RoleGame;"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYlMiJAAKCRDlMfrJqhPK
R6ahAJ9TbfcAB8EbhHM4DfuC9++PmtwnNgCeObP3W50XLhu2YwSBo26D/N4XU/I=
=BvU0
-----END PGP SIGNATURE-----
