#!/usr/bin/env playonlinux-bash
# Date : (2017-04-07)
# Last revision : see the changelog below
# Wine version used : 3.20
# Distribution used to test : Ubuntu 16.04 LTS
# NVidia GeForce GTX 960/PCIe/SSE2
# AMD FX(tm)-6300 Six-Core Processor × 6
   
# CHANGELOG
# [Dadu042] (2020-01-16 00:10)
#   Wine 2.5-staging -> 3.20.
#   Add POL_RequiredVersion
# [SomeGuy42] (09-APR-2017)
#  Wine 2.0-rc3-staging => 2.5-staging
#   2.5 has many preinstalled components and should make the install simpler/more stable
#  Blizzard app v1.8.0.8600  (formerly Battle.net)
#  Diablo 3 Patch 2.5.0.44247
# [RavonTUS] (06-JAN-2017)
#  added Dependencies to improve the install
#  Wine 1.7.15 => 2.0-rc3-staging
#  Battle.Net Patch 1.5.2.8180
#  Diablo 3 Patch 2.4.3 (64-bit Client)
#  NVidia GeForce GTX 960/PCIe/SSE2
#  AMD FX(tm)-6300 Six-Core Processor × 6
# [SomeGuy42] (2016-11-22)
#   Wine 1.7.15 => 1.9.23
#   Battle.net Patch 1.5.2 Build 8142
#   Diablo 3  v2.4.2.41394
#   Notes: install tweaked for D3 performance
# [petch] (2014-03-24)
#   Wine 1.5.5-DiabloIII_v3 => 1.7.15 (DarkNekros)
# [SuperPlumus] (2013-06-08 17-14)
#   gettext + clean
   
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Diablo III"
WORKING_WINE_VERSION="3.20"
EDITOR="Blizzard Entertainment Inc."
EDITOR_URL="http://www.blizzard.com"
PREFIX="DiabloIII_32"
AUTHOR="RavonTUS, SomeGuy42 and the POL Community"
   
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1195
POL_Debug_Init
   
POL_Debug_Message "Starting Install -----------------------------"
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_System_SetArch "x86"
#POL_System_SetArch "amd64"
POL_System_TmpCreate "$PREFIX"
   
POL_SetupWindow_message "$(eval_gettext 'NOTICE: This will install the Blizzard application first and configure the settings for Diablo 3.')\n\n$(eval_gettext 'The Blizzard app install may take longer than expected to continue to the next window, but it works in most cases. For example if it appears not to continue at the Installation Location window, wait a couple minutes and try clicking the Continue button again.')"
   
POL_Debug_Message "Downloading Install File -------------"
cd "$POL_System_TmpDir"
# Battle.net now has a universal installer with language selection at start
POL_Download "https://www.battle.net/download/getInstallerForGame?os=win&version=LIVE&gameProgram=BATTLENET_APP/Battle.net-Setup.exe"
SetupIs="$POL_System_TmpDir/Battle.net-Setup.exe"
   
# Removed the DVD option as it has a really old installer and game files and isn't worth using IMHO
   
POL_Debug_Message "Creating Wine Install ------------------------"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
   
POL_Debug_Message "Setting Wine Variables -----------------------"
Set_OS "win10"
# Updated Overrides, many of wine's dlls are up to spec now and diablo has even removed some of their own. 
POL_Wine_OverrideDLL "native,builtin" "vcruntime140"
POL_Wine_OverrideDLL "native,builtin" "msvcp140"
POL_Wine_OverrideDLL "native,builtin" "ucrtbase" 

  
# Updated dependancies, Most no longer needed due to wine 2.0 (07-APR-2017)
POL_Call POL_Install_corefonts
POL_Call POL_Install_Physx
 
   
POL_Debug_Message "Running Install File -------------------------"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupIs"
   
POL_SetupWindow_VMS "1024"
POL_System_TmpDelete
   
POL_Debug_Message "Creating Shortcut ----------------------------"
POL_Shortcut "Battle.net Launcher.exe"  "$TITLE" "" "" "Game;"
   
POL_Debug_Message "Install Completed ----------------------------"
   
POL_SetupWindow_message "$(eval_gettext 'Blizzard application Installation Complete')\n\n$(eval_gettext 'IMPORTANT: Login to the Blizzard app by using the email and password entries near the bottom of the login window, not the nice looking ones near the top. You may also want to check the box for Keep Me Always Loged In. Then login to Blizzard and install the Diablo III game files. IMPORTANT: You may have to go to settings and disable browser acceleration, this often fixes display issues.')"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXh+c9wAKCRDlMfrJqhPK
R6trAJ4rKoZ3H2qtnA/AbTnipPES9hdgSQCfdJadEhARucPjpTn+gvBSWb3aNmY=
=2n4c
-----END PGP SIGNATURE-----
