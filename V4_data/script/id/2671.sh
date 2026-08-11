#!/bin/bash
# Date : (2015-12-09)
# Distribution used to test : Duzeru GNU/Linux 64-bit
# Author : chocoelho
# Licence : GPLv3
# PlayOnLinux: 4.2.9

# CHANGELOG
# [chocoelho] (2015)
#   First script.
# [Dadu042] (2019-11-08)
#   Wine 1.7.46-staging -> 2.22 (because of the 'mini windows' install issue).
#   Add POL_RequiredVersion "4.2.12"
# [Dadu042] (2020-04-05) ADE v4.5.11.187212
#   Wine 2.22 -> 5.0
#   Dotnet40 -> Dotnet461
# [Dadu042] (2020-04-28)
#   Dotnet40 -> Dotnet461 (fix forget)


# KNOWN ISSUES:
#  - Wine 2.22, 3.0.3 : ADE installation does crash (never end v4.5.11, error is: 'ADE is already running'). Workaround: Wine 5.0
#  - Wine 5.0: Fix: dotnet40. Crash 'CLR Error: 80004005'. Fix: dotnet461.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="AdobeDigitalEditions45"
WINEVERSION="5.0"
TITLE="Adobe Digital Editions 4.5"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com/solutions/ebook/digital-editions.html"
AUTHOR="chocoelho"
 
#Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 2316
 
POL_Debug_Init
 
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

if [ "$POL_OS" = "Linux" ]; then
        wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE"
fi

# Let the user choose between downloading the installer or using an already existing one.
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"
        FULL_INSTALLER="$APP_ANSWER"
else # DOWNLOAD
        POL_System_TmpCreate "$PREFIX"
 
        DOWNLOAD_URL="http://download.adobe.com/pub/adobe/digitaleditions/ADE_4.5_Installer.exe"
 
        cd "$POL_System_TmpDir"
 
        POL_Download "$DOWNLOAD_URL"
        DOWNLOAD_FILE="$(basename "$DOWNLOAD_URL")"
 
        FULL_INSTALLER="$POL_System_TmpDir/$DOWNLOAD_FILE"
fi
 
# Setting up the prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Configuration
Set_OS "win7"
 
# Dependencies
POL_Call POL_Install_corefonts
POL_Call POL_Install_dotnet461

# Configuration
Set_OS "win7"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$FULL_INSTALLER"
 
POL_Shortcut "DigitalEditions.exe" "$TITLE" "" "" "Office;"
 
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    # Free some disk space
    POL_System_TmpDelete
fi
 
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqiOgQAKCRDlMfrJqhPK
R2oWAJ0Whq31Qn+DnAcv0dUtBUwimwh6VACeONk1NcPXMs2nanhb+zgYOfCyAmk=
=8A7a
-----END PGP SIGNATURE-----
