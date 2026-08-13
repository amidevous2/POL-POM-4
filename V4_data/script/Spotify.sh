#!/bin/bash
  
# Date : (2009-12-09 ??-??)
# Last revision : see changelog
# Wine version used : 1.3.30
# Distribution used to test : N/A
# Author : Dr Phil
# Depend :

# CHANGELOG
# [SuperPlumus] (2011-12-13 18-58)
#   Convert POLv3 -> POLv4
#   Add winhttp.dll override
# [SuperPlumus] (2011-12-21 09-14)
#   Update md5
# [SuperPlumus] (2012-01-18 07-51)
#   Remove cherk md5 (reason: frequent updates)
# [Dadu042] (2019-11-04 12-51)
#   - Wine 1.7.35 -> 3.0.3 (because POL's GUI is NOK under Ubuntu 18.04)
#   - Replace the download URL (because dead) "http://download.spotify.com/Spotify%20Installer.exe" -> "https://download.scdn.co/SpotifySetup.exe"
#     However it does not install ('Please install Spotify from a user account, not a admin account.'). I tried: Wine 2.22 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
  
TITLE="Spotify"
PREFIX="Spotify"
WORKING_WINE_VERSION="3.0.3"
  
POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/spotify/left.jpg" "Spotify"
POL_SetupWindow_Init
POL_SetupWindow_SetID 386
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Spotify Ltd" "http://www.spotify.com/" "Dr Phil" "$PREFIX"

POL_RequiredVersion "4.2.12" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_System_TmpCreate "$PREFIX"
  
POL_Wine_InstallFonts
  
Set_SoundDriver "alsa"
POL_Wine_DirectSound "HardwareAcceleration" "Emulation"
  
POL_Call POL_Install_winhttp
 
  
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
  
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
  
cd "$POL_System_TmpDir"
POL_Download "https://download.scdn.co/SpotifySetup.exe" ""
POL_Wine_WaitBefore "$TITLE" --allow-kill
POL_Wine "SpotifySetup.exe"
POL_Wine_WaitExit "$TITLE" --allow-kill
  
fi
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
  
cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
 
POL_Wine_WaitBefore "$TITLE" --allow-kill
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE" --allow-kill
  
fi
  
POL_System_TmpDelete
  
POL_Shortcut "spotify.exe" "$TITLE"
POL_Shortcut_QuietDebug "$TITLE"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXcAZgwAKCRDlMfrJqhPK
RwTZAKCh+s/incn7kgNPpF2jTdvhRlvvPACdG2Q94en+juv48lJ8mSgcRxv/2U0=
=aD2/
-----END PGP SIGNATURE-----
