#!/usr/bin/env playonlinux-bash
# Date : (2017-01-14)
#  Battle.Net Patch 1.6.0 - pass
#  World of Warcraft - installs but video is messed up
#  Diablo 3 Patch 2.4.3 (32-bit client) - pass
#  Diablo 3 Patch 2.4.3 (64-bit client) - fails D3D error
#  StarCart II - not tested
#  HearthStone 7.0.0 - pass
#  Heroes of the Strom 22.7.49495 (32-bit client) - pass
#  Heroes of the Strom 22.7.49495 (64-bit client) - pass, slow video
#  Overwatch - not tested
# Wine version used : 2.0-rc3-staging
# Distribution used to test : Ubuntu 16.04 LTS
# NVIDIA binary driver v375.26
# NVidia GeForce GTX 960/PCIe/SSE2
# AMD FX(tm)-6300 Six-Core Processor × 6 
  
# CHANGELOG
# [Dadu042] (2020-03-23 00-08)
#   Wine "2.0-rc3-staging" (outdated) -> 3.0.3
# [RavonTUS] (14-JAN-2017)
#  added testing of other games
# [RavonTUS] (12-JAN-2017)
#  added addition tips menu for better Diabo performance
#  tested other Blizzard games
# [RavonTUS] (06-JAN-2017)
#  added Dependencies to improve the install
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
  
TITLE="Battle.net 64-Bit"
WORKING_WINE_VERSION="3.0.3"
EDITOR="Blizzard Entertainment Inc."
EDITOR_URL="http://www.blizzard.com"
PREFIX="Battlenet64Bit"
AUTHOR="RavonTUS, SomeGuy42 and the POL Community, Moroth from us.battle.net forum"
  
POL_GetSetupImages "http://media.blizzard.com/d3/media/artwork/artwork-templar-large.jpg" "https://2.bp.blogspot.com/-c8MeJxIShqQ/WHkheS9i48I/AAAAAAAAAF0/pka7KSf-OA4yBePsdz6sSSHFkh2fi3PfACLcB/s1600/BN.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2599
POL_Debug_Init
  
POL_Debug_Message "Starting Install -----------------------------"
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "$AUTHOR" "$PREFIX"
  
# POL_System_SetArch "x86"
POL_System_SetArch "amd64"
POL_System_TmpCreate "$PREFIX"
  
POL_SetupWindow_message "$(eval_gettext 'NOTICE: This will install the Battle.net application first and configure the settings for Diablo 3.')\n\n$(eval_gettext 'The Battle.net install may take longer than expected to complete, but it usually works. For example if it appears not to continue at the Installation Location window, wait a couple minutes and try clicking the Continue button again.')"

# I was hoping this would help, because the default POL had hash error, but it really doesn't (13-Jan-2017)
POL_Debug_Message "Downloading wintrust.dll wintrust -------------"
POL_Download_Resource "http://files.playonlinux.com/wintrust_dll.zip" 
# Installing DLL
POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installing wintrust DLL...')" "$TITLE"
cd "$WINEPREFIX/drive_c/windows/temp"
unzip "$POL_USER_ROOT/ressources/wintrust_dll.zip"
if [ "$POL_ARCH" == "amd64" ]; then
        cp -f wintrust.dll ../syswow64/
else
        cp -f wintrust.dll ../system32/
fi
 
POL_Wine regsvr32 wintrust.dll

#I was hoping this would help, because the default POL had hash error, but it really doesn't (13-Jan-2017)
POL_Debug_Message "Downloading wintrust.dll wininet -------------"
#POL_Download_Resource "http://web.archive.org/web/*/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe"
POL_Download_Resource  "http://x3270.bgp.nu/download/specials/W2KSP4_EN.EXE"
cd "$WINEPREFIX/drive_c/windows/temp"
cabextract "$POL_USER_ROOT/ressources/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" -F WININET.DLL
 
if [ "$POL_ARCH" = "amd64" ]; then
        cp -f WININET.DLL ../syswow64/wininet.dll
else
        cp -f WININET.DLL ../system32/wininet.dll
fi

#I was hoping this would help, because the default POL had hash error, but it really doesn't (13-Jan-2017)
POL_Debug_Message "Downloading wintrust.dll winhttp -------------"
POL_Download_Resource "http://web.archive.org/web/20160129053851/http://download.microsoft.com/download/E/6/A/E6A04295-D2A8-40D0-A0C5-241BFECD095E/W2KSP4_EN.EXE"    
cd "$WINEPREFIX/drive_c/windows/temp"
cabextract "$POL_USER_ROOT/ressources/W2KSP4_EN.EXE" -F i386/new/winhttp.dl_
if [ "$POL_ARCH" = "amd64" ]; then
        cp -f i386/new/winhttp.dl_ ../syswow64/winhttp.dll
else
        cp -f i386/new/winhttp.dl_ ../system32/winhttp.dll
fi  
  
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
# win7 has better D3 performance but issues with battle.net-need to turn browser hardware acceleration off in B.net
Set_OS "win10"

POL_Wine_OverrideDLL "native,builtin" "msvcp100"
POL_Wine_OverrideDLL "native,builtin" "msvcp140"
POL_Wine_OverrideDLL "native,builtin" "vcruntime140"
POL_Wine_OverrideDLL "native,builtin" "ucrtbase"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-runtime-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-stdio-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-heap-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-locale-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-math-l1-1-0"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-convert-l1-1-0"

#Not sure these are really needed (04-JAN-2017)
POL_Wine_OverrideDLL "native,builtin" "d3dcompiler_43" "d3dcompiler_42"
POL_Wine_OverrideDLL "native,builtin" "winhttp" "wininet" "winitrust"
POL_Wine_OverrideDLL "native,builtin" "dnsapi"
 
# Dependencies (04-JAN-2017)
POL_Call POL_Install_corefonts
POL_Call POL_Install_RegisterFonts
POL_Call POL_install_tahoma
POL_Call POL_install_tahoma2
POL_Call POL_install_gdiplus
POL_Call POL_install_gecko
POL_Call POL_Install_riched20
POL_Call POL_Install_riched30
POL_Call POL_install_dxfullsetup
POL_Call POL_Install_d3dx11
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_vcrun2013
POL_Call POL_Install_Physx
#The following fails to install (Cannot verify hash) as of 04-JAN-2017, I think it would have help remove some errors at the start of the client, but runs ok without it
#POL_Call POL_Install_winhttp	#bug 5221 2016-03-07
#POL_Call POL_Install_wininet	#bug 5414 2016-12-05
#POL_Call POL_Install_wintrust  fails to veriy hash too
  
POL_Debug_Message "Running Install File -------------------------"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupIs"
  
POL_SetupWindow_VMS "1024"
POL_System_TmpDelete
  
POL_Debug_Message "Creating Shortcut ----------------------------"
POL_Shortcut "Battle.net Launcher.exe"  "$TITLE" "" "" "Game"
  
POL_Debug_Message "Install Completed ----------------------------"
  
POL_SetupWindow_message "$(eval_gettext 'Battle.net Installation Complete')\n\n$(eval_gettext 'IMPORTANT: Please start the application and disable -Use browser hardware acceleration- under Settings (gear icon upper right) ->Advanced and restart the app. THEN login to Battle.net and download/locate the $TITLE game files.')\n\n$(eval_gettext 'TIP: In the Battle.net application you may need to move the mouse into the content of the drop menus for them to show.')"

POL_SetupWindow_message "$(eval_gettext 'After Diablo III Installation Complete')\n\n$(eval_gettext 'BETA: The 64-bit may or may not work with yet. (I currently get Unable to initialize D3D).  If it fails, switch to the 32-bit client.')\n\n$(eval_gettext 'IMPORTANT: Please change to the 32-bit client by starting Battle.net. Click the Options (gear icon below logo). You may need to click and move the mouse down, in order for the menu to appear. Click Game Settings, then put a check mark in the Launch 32-bit client (instead of 64-bit).  Then click Done.')"

POL_SetupWindow_message "$(eval_gettext 'Improve performance after the install, Go to Configure, Select that version under Wine Version, Right click on Diablo II for Configure Wine, Click on Staging Tab, Check Enable_CSMT for better graphic performance, then OK')"
   
POL_SetupWindow_Close
POL_Wine_reboot
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnfwKgAKCRDlMfrJqhPK
R/a0AJ4t39KsbtECJjFr0PjTW0Jl4Sna/QCgnri6BNJ32Yr9G7bEBM50rzs/xtw=
=U1rW
-----END PGP SIGNATURE-----
