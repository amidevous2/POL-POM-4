#!/bin/bash
# Date : (2014)
# Distribution used to test : Mint 18 LXDE 64-bit
# Author : RoninDusette, taurin
# Licence : GPLv3
# PlayOnLinux: 4.2.10
#
# CHANGELOG
# [Ronin Dusette] (2014)
#   First script.
# [taurin] (2016-11-11)
#   Some improvements, fixes and additional information for better start the program.
# [Dadu042] (2019-11-28)
#   Wine 1.8.5 -> 2.22
#   Force x86 mode.
#   Add app categories.


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
       
PREFIX="Lightroom57"
WINEVERSION="2.22"
TITLE="Adobe Photoshop Lightroom 5"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="RoninDusette, taurin"
       
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
       
POL_Debug_Init
       
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_SetupWindow_message "$(eval_gettext 'IMPORTANT: This program may NOT work well with most Intel graphics. Nvidia and AMD proprietary drivers are REQUIRED in most cases.
\n\n
Needs sRGB color profile for images to be visible. Copy sRGB.icm (comes with some native Linux software, such as GraphicsMagick) to "~/.PlayOnLinux/wineprefix/$PREFIX/drive_c/windows/system32/spool/drivers/color/sRGB Color Space Profile.icm".
\n
Or if you have winetricks installed you can run "env WINEPREFIX=~/.PlayOnLinux/wineprefix/$PREFIX winetricks colorprofile"')" "$TITLE"
 
# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Configuration
Set_OS "win7"

POL_Call POL_Install_atmlib
POL_Call POL_Install_corefonts
POL_Call POL_Install_wintrust
POL_Call POL_Install_msasn1
POL_Call POL_Install_vcrun2008
POL_Download_Resource "https://web.archive.org/web/20061224003406/http://download.microsoft.com/download/5/0/c/50c42d0e-07a8-4a2b-befb-1a403bd0df96/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" "0c0f6e300800e49472e9b2e0890a09c1" "0c0f6e300800e49472e9b2e0890a09c1"
   
cd "$WINEPREFIX/drive_c/windows/temp"
cabextract "$POL_USER_ROOT/ressources/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" -F WINHTTP.DLL
if [ "$POL_ARCH" = "amd64" ]; then
        cp -f WINHTTP.DLL ../syswow64/winhttp.dll
else
        cp -f WINHTTP.DLL ../system32/winhttp.dll
fi
POL_Wine_OverrideDLL "native, builtin" "winhttp"
POL_Download_Resource "https://web.archive.org/web/20061224003406/http://download.microsoft.com/download/5/0/c/50c42d0e-07a8-4a2b-befb-1a403bd0df96/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" "0c0f6e300800e49472e9b2e0890a09c1"
cd "$WINEPREFIX/drive_c/windows/temp"
cabextract "$POL_USER_ROOT/ressources/IE5.01sp4-KB871260-Windows2000sp4-x86-ENU.exe" -F WININET.DLL
if [ "$POL_ARCH" = "amd64" ]; then
        cp -f WININET.DLL ../syswow64/wininet.dll
else
        cp -f WININET.DLL ../system32/wininet.dll
fi
POL_Wine_OverrideDLL "native, builtin" "wininet"

 
# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
 
POL_SetupWindow_message "$(eval_gettext 'PlayOnLinux will now install a few required programs, including IE6. Just click NEXT through IE install, as you usually would.')" "$TITLE"
 
#Dependencies
Set_OS "winxp"
POL_Call POL_Install_ie6
POL_Call POL_Install_wmpcodecs
POL_Call POL_Install_FontsSmoothRGB
Set_OS "win7"
POL_Call POL_Install_gdiplus
 
# Create Shortcuts
POL_Shortcut "lightroom.exe" "$TITLE" "" "" "Graphics;RasterGraphics;"
POL_Shortcut_InsertBeforeWine "$TITLE" "export LC_ALL=C.UTF-8"
      
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXeDtKAAKCRDlMfrJqhPK
R965AJ49/4Vnl4l3vnLDIhK+tyTd2r7R7QCcCy94mHb0c75bbBKq7kbTpWenqDc=
=dAYb
-----END PGP SIGNATURE-----
