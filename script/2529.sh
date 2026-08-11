#!/bin/bash
# Date : (2015-5-20 5:22 PM)
# Wine version used : 1.6.2
# Distributions used to test : Debian GNU/Linux 8.0 & Linux Mint 17.1
# Author : MTres19
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
PREFIX="Reshade_Enlarger"
TITLE="Reshade Image Enlarger"
WINEVERSION="1.6.2"
  
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"  

POL_SetupWindow_Init
POL_Debug_Init
POL_System_SetArch "x86"
  
POL_SetupWindow_presentation "Reshade Image Enlarger 3.0" "Reshade Ltd." "reshade.com" "MTres19" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
  
POL_Call POL_Install_LunaTheme

POL_SetupWindow_message "$(eval_gettext 'Please download the installer from reshade.com')" "$TITLE"
POL_Browser "http://reshade.com"
  
POL_SetupWindow_InstallMethod "LOCAL"
  
if [ $INSTALL_METHOD = "DOWNLOAD" ]
then
  POL_System_TmpCreate "Reshade"
  cd "$POL_System_TmpDir"
  POL_Download "http://reshade.com/static/reshade-install.exe" "8786327bc7209134e9fad15f581fe0cc"
  POL_Wine "reshade-install.exe"
  POL_System_TmpDelete
elif [ $INSTALL_METHOD = "LOCAL" ]
then
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
  RESHADE_INSTALL="$APP_ANSWER"
  POL_Wine "$RESHADE_INSTALL"
fi
  
POL_Shortcut "reshade.exe" "Reshade"
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlVejwsACgkQ5TH6yaoTykdBcgCfaUdVvPcfwJlMTBVhIYE+6uM3
aG0AnR7jC9mMS1znVXY3scfdmjpwpOvz
=vOQj
-----END PGP SIGNATURE-----
