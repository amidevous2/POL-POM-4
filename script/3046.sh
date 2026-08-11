#!/usr/bin/env playonlinux-bash
# Date : (2016-09-27 17-29)
# Wine version used : 1.9.19
# Distribution used to test : Ubuntu 16.04 LTS 64 bit and 32 bit prefix used
# Firefox Version used to test : 2.6
# Author : andykimpe
#
# CHANGELOG
# [andykimpe] (2016-09-27 17-29)
#   First script.
# [Dadu042] (2019-12-30)
#   Wine 1.9.19 -> 3.0.3
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="AllFrTV"
PREFIX="AllFrTV"
WORKING_WINE_VERSION="3.0.3"

#POL_GetSetupImages "$SITE/setups/firefox/top.jpg" "$SITE/setups/firefox/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Racacax" "http://forum-racacax.ga/viewforum.php?f=69" "andykimpe" "$PREFIX"
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
INSTALLER="$APP_ANSWER"
POL_Download "http://ftp.free.org/mirrors/videolan/vlc/2.2.4/win32/vlc-2.2.4-win32.exe"
VLC="$POL_System_TmpDir/vlc-2.2.4-win32.exe"
  
   
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
   
POL_Call POL_Install_dotnet40
POL_Call POL_Install_gdiplus
   
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER" /VERYSILENT /NORESTART
POL_Wine "$VLC" /S /NCRC
   
POL_System_TmpDelete
   
POL_Shortcut "AllFrTV.exe" "$TITLE" "" "" "Video;"
   
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgtL8QAKCRDlMfrJqhPK
R/0oAJ9V4AQY7uXXbgEy/GhhIzGfw8M0gwCfe9DjoBVbcMmGJOswx8kF9leByh4=
=+1cB
-----END PGP SIGNATURE-----
