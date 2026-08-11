#!/usr/bin/env playonlinux-bash
# Date : (2021-02-17)
# Last revision : see changelog
# Wine version used : 6.0 (x86)
# Distribution used to test : Xubuntu 20.04 amd64
# Author : Ricardo Carraretto
#
# CHANGELOG
# [Ricardo Carraretto] (2020-09-11)
#   First script.
# [Ricardo Carraretto] (2021-02-17)
#   Updated to run under wine6.0
#
# KNOWN ISSUES:
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
    
TITLE="IRPFbolsa"
PREFIX="IRPFbolsa"
WINEVERSION="6.0"
EDITOR="IRPFbolsa"
GAME_URL="https://www.irpfbolsa.com.br/"
AUTHOR="Ricardo Carraretto"
       
# Initialization
POL_SetupWindow_Init
 
# Debug
POL_Debug_Init
    
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
POL_SetupWindow_message "Note: this script was successfully tested with IRPFbolsa 5.367.\n\nIRPFbolsa requires the installation of Internet Explorer 6.0, Microsoft Data Access Components 2.8 SP1 and Microsoft Jet 4.0 SP8. These dependencies will be handled by this installer script.\n\nPlease make sure you have unzip installed prior to continuing.\n\n" "$TITLE"  
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
# Download installation files
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
INSTALLER_ZIP="$POL_System_TmpDir/IRPFbolsa.zip"
# Note: MD5 not provided because the vendor updates the installation files frequently
POL_Download "https://irpfbolsa.com.br/IRPFbolsa.zip"
POL_Download "https://irpfbolsa.com.br/setup_IRPFbolsa.exe"
INSTALLER_EXE="$POL_System_TmpDir/setup_IRPFbolsa.exe"  
unzip "$INSTALLER_ZIP" -d "$POL_System_TmpDir"
POL_Download "https://download.microsoft.com/download/4/3/9/4393c9ac-e69e-458d-9f6d-2fe191c51469/Jet40SP8_9xNT.exe" "d1028c0f98b4ffe5ede854327b77fbb9"
INSTALLER_JET40_EXE="$POL_System_TmpDir/Jet40SP8_9xNT.exe"
 
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
   
# Dependencies
Set_OS "win7"
POL_SetupWindow_message "Installing dependency 1/4: Microsoft Internet Explorer 6.0." "$TITLE"  
POL_Call POL_Install_ie6
POL_SetupWindow_message "Installing dependency 2/4: Microsoft Data Access Components 2.8 SP1." "$TITLE" 
POL_Call POL_Install_mdac28
POL_SetupWindow_message "Installing dependency 3/4: Microsoft Jet 4.0 SP8." "$TITLE" 
POL_Wine "$INSTALLER_JET40_EXE"
POL_SetupWindow_message "Installing dependency 4/4: Microsoft MFC42 DLLs." "$TITLE" 
POL_Call POL_Install_mfc42

# DLL Override
POL_Call POL_Function_OverrideDLL native,builtin msado15
    
# Installation
POL_Wine_WaitBefore "$TITLE"
POL_SetupWindow_message "Installing IRPFbolsa." "$TITLE"
Set_OS "win7"
POL_Wine "$INSTALLER_EXE"
# Installer puts files outside of virtual drive. This fix is needed to allow the proper shortcut to be created 
mkdir "$WINEPREFIX/drive_c/$PROGRAMFILES/IRPFbolsa"
cp "$POL_System_TmpDir/IRPFbolsa.exe" "$WINEPREFIX/drive_c/$PROGRAMFILES/IRPFbolsa/IRPFbolsa.exe"  
POL_Wine_WaitExit "$TITLE"
 
# Simulate reboot  
POL_Wine_reboot
 
# Clean up temporary files
POL_System_TmpDelete
 
# Create shortcut
POL_Shortcut "IRPFbolsa.exe" "$TITLE" "" "" "Office;Finance;"
POL_Shortcut_QuietDebug "$TITLE"
 
# Finish install
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYC4cmAAKCRDlMfrJqhPK
R1I/AKCgg9FMIlJl5ZL2XD3gpmlOBju4NQCfbqy9PTnaGziX5U37EL3Pb8EFAHE=
=auAU
-----END PGP SIGNATURE-----
