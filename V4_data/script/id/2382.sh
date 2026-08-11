#!/bin/bash
# Date: 2015-01-05
# Distribution used to test : Debian Wheezy, Gnome DE, Xubuntu 18.04
# Author: zenforic
# Licence: GPLv3

# TESTED Editions: ? (2020-09)
#
# Middlewares used by this software : DirectX 9 and 11.

# CHANGELOG
# [zenforic] (2015-01-06)
#   Initial script (Wine 1.7.33).
# [Dadu042] (2020-04-21 19-50)
#   Some changes according what I have read (on POL page and on Appdb.winehq.org), not tested.
#   Add POL_Install_vcrun2015
#   Add POL_Install_msxml6
#   Remove the download MD5 checksum
# [Dadu042] (2020-04-21 22-00)
#   Force architecture 64 bits (the game now requires it).
# [Dadu042] (2020-06-13 10-00)
#   Wine 5.0 -> 5.0.1
#   Running the .MSI installer just does open the Warframe's 'An Error Has Occured' window.
#   Disable installation from Download because the script does not work.
# [Dadu042] (2020-09-22 10-00)
#   Make messages easier to read.
#   Ceate automatically the 'Warframe' folder.
#
# KNOWN ISSUES:
#   Wine amd64 5.0.2, 5.16: after adding POL_Install_corefonts, now the installer fail to run with this error message 'An error has occured'. Removing it does fix the issue...
#   Wine amd64 5.16 (without D3D11): license agreement window appears (text is mssing), after clicking Approve two times, the installer does crash ('An error has occured'). Tried: POL_Install_riched30, POL_Install_gecko, DXVK_171 (worse, installer does crash before to start).
#
# KNOWN ISSUES (FIXED):
#   Wine amd64 5.0.2: many of those lines 'err:d3dcompiler:compile_shader HLSL shader parsing failed'. Tried: POL_Install_d3dx11. Fix: disabling D3D11
#   Wine amd64 5.0.2, 5.16: the installer does appear, but the main part is black, the options menu does work.  Tried: POL_Install_d3dx9_43 + POL_Install_d3dcompiler_43. Fix: disabling D3D11


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
     
TITLE="Warframe"
PREFIX="Warframe"
WORKING_WINE_VERSION="5.16"
PUBLISHER="Digital Extremes Ltd."
GAME_URL="http://warframe.com/"
AUTHOR="zenforic"
GAME_VMS="256" # https://warframe.com/faq (2015)
MSI_MD5="caba697d217b437818906da155fb758e"
     
# Setup
POL_SetupWindow_Init
POL_Debug_Init
     
POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_Wine_SelectPrefix "$PREFIX"
 
# Determine Architecture
POL_System_SetArch "amd64"
# POL_System_SetArch "x86"
 
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
Set_OS "win7"
    
# Samba
if [ "$POL_OS" = "Mac" ]; then
    # Samba support
    POL_Call POL_GetTool_samba3
    source "$POL_USER_ROOT/tools/samba3/init"
fi
    
#######################################
#  Installing mandatory dependencies  #
#######################################
 
# I (Dadu042, 2020) think that the following command does replace it:
# POL_Wine_InstallFonts
POL_Call POL_Internal_InstallFonts

POL_Call POL_Install_corefonts

# Disable DirectX 11
POL_Wine_OverrideDLL "" "d3d11"

# Test Dadu042 2020-09
# POL_Call POL_Install_gecko
# POL_Call POL_Install_d3dx9_43
# POL_Call POL_Install_d3dcompiler_43
# POL_Call POL_Install_d3dx11

# Test Dadu042 2020-06
# POL_Call POL_Install_d3dx9
# POL_Call POL_Install_xact
# POL_Call POL_Install_vcrun2015  # Req 32 bits arch
# POL_Call POL_Install_msxml6     # Req 32 bits arch

################
#      GPU     #
################
           
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
            
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
             
# Useful for Nvidia GPUs
# POL_Call POL_Install_physx
               

#######################################
#  Download the installer             #
#######################################
     
# cd "$WINEPREFIX/drive_c"

# Disabled because checksum does change often.
# POL_Download "http://content.warframe.com/dl/Warframe.msi" "$MSI_MD5"

# POL_Download "http://content.warframe.com/dl/Warframe.msi"

#######################################
#  Main part of this script           #
#######################################

cd "$WINEPREFIX/drive_c"

mkdir "$WINEPREFIX/drive_c/Program Files/Warframe"

POL_SetupWindow_message "$(eval_gettext 'Please note that this script will not work for everyone, I have tried it on my computer and on a friends computer, my lower end computer got the launcher then got stuck after it downloaded updates, while on my friends higher end computer it ran fine, I recommend though running the game in full screen and turning down some of the fancy graphics, it will significantly increase FPS.')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext '(There will be 2 words to the following note that need an apostrophe but I cant seem to escape the apostrophe character so please forgive that).\n FIRST NOTE: when the installer runs, it will simply ask for a directory to install, navigate to My Computer, C:, Program Files, Warframe, then click ok (MUST BE INSTALLED THERE).')" "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'Attention: After installation is complete, the launcher will run, when it does, go into the launcher settings and DISABLE 64-bit mode if it is enabled. If this is not done then the launcher will get stuck on a download point and possibly crash. You can run "$TITLE" when setup is done. Also delete the Warframe.lnk file that may appear on your desktop. Also, an error will show when the installer asks for the folder, this is intentional as the normal waitexit function does not work for this. Click NEXT on the playonlinux error window AFTER the launcher has pops up.')" "$TITLE"


# Installation from the Downloaded file
# POL_Wine start /unix "$WINEPREFIX/drive_c/Warframe.msi"  #  Does fail to execute MSI files (2019)
# POL_Wine msiexec /i  "$WINEPREFIX/drive_c/Warframe.msi"
# POL_Wine_WaitExit "$TITLE"

# Installation from a .EXE local file
POL_SetupWindow_browse "$(eval_gettext 'Please select the installation file')" "$TITLE"
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"


# Create Shortcuts
POL_Shortcut "$WINEPREFIX/drive_c/Program Files/Warframe.exe" "$TITLE" "" "" "Game;Shooter;"
     
# Samba
if [ "$POL_OS" = "Mac" ]; then
    POL_Shortcut_InsertBeforeWine "$TITLE" "source \"$POL_USER_ROOT/tools/samba3/init\""
fi
    
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX2obYwAKCRDlMfrJqhPK
R4y/AJ49PQEQr+EIDAkmnj7NY8hmHWowWACggKKRixUUt//yXgK941GOLasXwdg=
=wCV/
-----END PGP SIGNATURE-----
