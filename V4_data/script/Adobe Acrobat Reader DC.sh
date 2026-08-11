#!/usr/bin/env playonlinux-bash
# Date : (2015-11-02)
# Last revision : see changelog
# Wine version used : 1.9.0, 3.0.4, 4.0.3
# Distribution used to test : Kubuntu 18.04 amd64
# Author : Martins Bruvelis
#
# CHANGELOG
# [Martins Bruvelis] (2015-11-02)
#   First script.
# [LinuxScripter] (2018-12-21 11-04)
#   Using the latest sable version of wine at this time, removing the SetOS lines (program works fine on win7), updated the download link.
# [Dadu042] (2019-12-18)
#   Wine 3.0.4 -> 4.0.3
#   POL_RequiredVersion 4.3.4
#   Add shortcut categories.
# [Dadu042] (2020-02-03)
#   Set_OS "winxp" -> win7
#
#
# KNOWN ISSUES:
#
# KNOWN ISSUES with version 2015.010.20056:
#  - Wine x86 3.0.3, 4.0.3, 4.21, 5.0-rc1: no text displayed in Preferences window (menu Edit -> Preferences). Tried: corefonts. Fix: OS win7 -> winxp (hint from: https://appdb.winehq.org/objectManager.php?sClass=version&iId=32266&iTestingId=104412 ).
#  - Wine x86 3.0.3, 4.0.3, 4.21, 5.0-rc1: crash when exit (even if no documents opened).
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Adobe Acrobat Reader DC"
PREFIX="AdobeAcrobatReaderDC"
WINEVERSION="4.0.3"
EDITOR="Adobe Systems Inc."
GAME_URL="https://acrobat.adobe.com/us/en/products/pdf-reader.html"
AUTHOR="Martins Bruvelis"
  
  
# Initialization
POL_SetupWindow_Init
  
POL_Debug_Init
  
# Presentation
# POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_SetupWindow_message "Note: this script will was successfully tested with Reader DC version 2015.010.20056" "$TITLE"    

POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Create Prefix
POL_System_TmpCreate "$PREFIX"
  
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
  
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
    INSTALLER_EXE="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    POL_SetupWindow_message "Note: this script will download version 2015.010" "$TITLE"
    cd "$POL_System_TmpDir"
    POL_Download "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/1501020056/AcroRdrDC1501020056_en_US.exe" "3a28dc6cb03067b0609b6007c16eec4a"
    INSTALLER_EXE="$POL_System_TmpDir/AcroRdrDC1501020056_en_US.exe"
fi
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

Set_OS "win7"
  
# Dependencies
POL_Call POL_Install_mspatcha
POL_Call POL_Install_vcrun2013
POL_Call POL_Install_FontsSmoothRGB
  
# Installation
POL_Wine_WaitBefore "$TITLE"
  
POL_Wine "$INSTALLER_EXE"
  
POL_Wine_WaitExit "$TITLE"
  
# Fix crashes
# Disable and delete update service
POL_Wine --ignore-errors sc stop "AdobeARMservice"
POL_Wine --ignore-errors sc config "AdobeARMservice" start=disabled
POL_Wine --ignore-errors sc delete "AdobeARMservice"
  
# Disable update service executables
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Common Files/Adobe/ARM/1.0" || POL_Debug_Fatal "$(eval_gettext 'Could not find program directory!')"
mv armsvc.exe armsvc.exe_disabled
mv AdobeARM.exe AdobeARM.exe_disabled
mv AdobeARMHelper.exe AdobeARMHelper.exe_disabled
  
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Adobe/Acrobat Reader DC/Reader/AcroCEF" || POL_Debug_Fatal "$(eval_gettext 'Could not find program directory!')"
mv RdrServicesUpdater.exe RdrServicesUpdater.exe_disabled
mv RdrCEF.exe RdrCEF.exe_disabled
  
# Disable update and online services in registry settings
cd "$POL_System_TmpDir"
echo -e 'REGEDIT4
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\AVGeneral]
"bisFirstLaunch"=dword:00000000
"bRHPSticky"=dword:00000001
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\ExitSection]
"bLastExitNormal"=dword:00000000
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\FTEDialog]
"bShowInstallFTE"=dword:00000001
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\Language\\current]
@="acrord32.dll"
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\Language\\next]
@="acrord32.dll"
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\Language\\UseMUI]
"bUseMUI"=dword:00000000
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\Privileged]
"bProtectedMode"=dword:00000000
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\RememberedViews]
"iRememberView"=dword:00000002
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\TrustManager]
"bEnhancedSecurityInBrowser"=dword:00000000
"bEnhancedSecurityStandalone"=dword:00000000
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Acrobat Reader\\DC\\Workflows]
"bNeedSynchronizer"=dword:00000000
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Adobe Synchronizer\\DC]
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Adobe Synchronizer\\DC\\Acrobat.com]
  
[HKEY_CURRENT_USER\\Software\\Adobe\\Adobe Synchronizer\\DC\\Acrobat.com.v2]
  
[HKEY_LOCAL_MACHINE\\Software\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown]
"bAcroSuppressUpsell"=dword:00000001
"bUpdater"=dword:00000000
"bUsageMeasurement"=dword:00000000
"iProtectedView"=dword:00000000
  
[HKEY_LOCAL_MACHINE\\Software\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown\\cIPM]
"bAllowUserToChangeMsgPrefs"=dword:00000000
"bDontShowMsgWhenViewingDoc"=dword:00000000
"bShowMsgAtLaunch"=dword:00000000
  
[HKEY_LOCAL_MACHINE\\Software\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown\\cServices]
"bAdobeSendPluginToggle"=dword:00000000
"bDisableWebmail"=dword:00000001
"bToggleAdobeDocumentServices"=dword:00000001
"bToggleAdobeSign"=dword:00000001
"bTogglePrefsSync"=dword:00000001
"bToggleWebConnectors"=dword:00000001
"bUpdater"=dword:00000000
  
[HKEY_LOCAL_MACHINE\\Software\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown\\cSharePoint]
"bDisableSharePointFeatures"=dword:00000001
  
[HKEY_LOCAL_MACHINE\\Software\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown\\cCloud]
"bNeedSynchronizer"=dword:00000000
"bAdobeSendPluginToggle"=dword:00000000
  
[HKEY_LOCAL_MACHINE\\Software\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown\\cWebmailProfiles]
"bCommercialPDF"=dword:00000001
"bDisableWebmail"=dword:00000001
"bEnableFlash"=dword:00000000
"bFindMoreCustomizationsOnline"=dword:00000000
"bFindMoreWorkflowsOnline"=dword:00000000
"bUpdater"=dword:00000000
  
[HKEY_LOCAL_MACHINE\\Software\\Adobe\\Adobe ARM\\1.0\\ARM]
"iCheckReader"=dword:00000000
  
[HKEY_LOCAL_MACHINE\\Software\\Adobe\\Acrobat Reader\\DC\\Installer\\Optimization]
"Enabled"="NO"
  
[HKEY_LOCAL_MACHINE\\Software\\Adobe\\Acrobat Reader\\DC\\AdobeViewer]
"EULA"=dword:00000001
  
[HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Run]
"Adobe ARM"=-' > disable-online-features.reg
  
POL_Wine regedit disable-online-features.reg
 
POL_Wine_reboot
POL_System_TmpDelete
  
POL_Shortcut "AcroRd32.exe" "$TITLE" "" "" "Office;Viewer;"
POL_Shortcut_QuietDebug "$TITLE"
POL_Shortcut_Document "$TITLE" "ReadMe.htm"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: Online updates and services do not work.')" "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjfekwAKCRDlMfrJqhPK
R/x3AKCaPBbQpAhFE1EIs15nF/s4EyvBBwCgl+J8PpBAnPA1AvINVHEuCRFJFuc=
=cDCs
-----END PGP SIGNATURE-----
