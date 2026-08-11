#!/usr/bin/env playonlinux-bash
# Date : (2015-03-28 19-49)
# Last revision : (2015-04-11 15-23)
# Wine version used : 1.7.40
# Distribution used to test : Linux Mint 17.1 LTS
# Author : wrigh347
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Free edition VB to C++ Converter"
PREFIX="freeVB2CPP"

WINEVERSION="1.7.40"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2486
 
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Tangible Software Solutions Inc." "http://www.tangiblesoftwaresolutions.com" "wrigh347" "$PREFIX"
 
# Create a 32bit virtual drive
POL_System_SetArch "x86"
 
POL_System_TmpCreate "VBtoCPP"
 
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
 
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the installation file to run.')" "$TITLE installation"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://www.tangiblesoftwaresolutions.com/Free_Edition_Downloads/VB%20to%20C++%20Converter%20(Free%20Edition)%20Setup.exe"
    INSTALLER="$POL_System_TmpDir/VB%20to%20C++%20Converter%20(Free%20Edition)%20Setup.exe"
fi
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_dotnet40
POL_Call POL_Install_riched30
POL_Call POL_Install_corefonts
 
POL_Wine_WaitExit "$TITLE"
POL_Wine "$INSTALLER"
 
POL_System_TmpDelete
 
POL_Shortcut "Free Edition VB to C++ Converter.exe" "$TITLE"
  
POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlUphU0ACgkQ5TH6yaoTykfzwQCeIKAADvMVqvpm7DyxuBvxqbF7
aXwAn3k2UMYQZUqgIfSGjMKX0t88zldl
=NT8x
-----END PGP SIGNATURE-----
