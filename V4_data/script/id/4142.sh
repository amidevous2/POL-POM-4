#!/usr/bin/env playonlinux-bash
# Date : (2020-07-19)
# Last revision : see changelog
# Distribution used to test : Linux Mint 20 Cinnamon
# Author : Yaotl
# Licence : GPLv3
# PlayOnLinux : 4.3.4
#
# BETA Script
#
#
# CHANGELOG
# [Yaotl] (2020-07-19)
#   First script.
# [Dadu042] (2019-04-28 18:11)
#   [CHANGED] Remove POL_SetupWindow_SetID because unused anymore.
#   [CHANGED] 'exit' -> 'exit 0'
#   [FIXED] POL_System_SetArch location.
# [Yaotl] (2020-07-29 15:10)
#   [CHANGED] Added a way for a local installation.
#   [CHANGED] Enable UseGLSL & Enable OpenGL.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Initialization
POL_SetupWindow_Init
POL_Debug_Init

PREFIX="EpicGamesLauncher"
TITLE="Epic Games Launcher"
WINEVERSION="5.11-staging"
DOWNLOAD_URL="https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi"

# Presentation
POL_SetupWindow_presentation "$TITLE" "Epic Games Inc." "https://www.epicgames.com/" "Yaotl" "$PREFIX"

# Checks the required POL/POM version
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

POL_SetupWindow_message "$(eval_gettext '\nWarning: this is a beta script ! (not fully working), and if the launcher does run this does not mean the games will.')" "$TITLE"

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"

# Determine Architecture
POL_System_SetArch "amd64"

POL_Wine_PrefixCreate "$WINEVERSION"

# Dependencies
POL_Call POL_Install_corefonts
POL_Call POL_Install_vcrun2019

# Loading d3d12 can cause problems. Therefore it is deleted.
rm -rf "$WINEPREFIX/drive_c/windows/system32/d3d12.dll"
rm -rf "$WINEPREFIX/drive_c/windows/syswow64/d3d12.dll"

# Asking about memory size of graphic card
POL_SetupWindow_VMS ${GAME_VMS}

POL_Wine_Direct3D "UseGLSL" "enabled"
POL_Wine_Direct3D "DirectDrawRenderer" "opengl"

# Set Graphic Card informations keys for wine
POL_Call POL_Install_VideoDriver

# Configuration
Set_OS "win81"

# Installation
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "Please select the installation file to run." "$TITLE installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOAD_URL"
    INSTALLER="$POL_System_TmpDir/EpicGamesLauncherInstaller.msi"
fi

POL_SetupWindow_wait "Please wait" "$TITLE Installation in progress"
POL_Wine msiexec /i "$INSTALLER" SKIP_AUTOLAUNCH="1"

# Create Shortcut
POL_Shortcut "EpicGamesLauncher.exe" "$TITLE" "" "-SkipBuildPatchPrereq" "Game;Launcher;"

# Cleanup
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXzDnbQAKCRDlMfrJqhPK
R5RZAKCrppNsy7WUI6AYzezJk5NUcPcNYwCgqfri9X/h4cXUWqx5e4SJpEwXvBs=
=DoBN
-----END PGP SIGNATURE-----
