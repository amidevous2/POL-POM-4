#!/bin/bash
# Date : (2014-02-02 00-45)
# Last revision : (2014-02-07 01-45)
# Wine version used : 1.7.11
# Distribution used to test : Ubuntu 13.10 Saucy Salamander
# Author : monban
# Script licence : Public Domain
# Program licence : Commercial
# Depend :

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="I Miss the Sunrise"
PREFIX="imissthesunrise"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1939
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Tilde-One" "http://www.tilde-one.com/IMTS/" "monban" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
 
POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
  cd $POL_System_TmpDir
  POL_Download "http://rpgmaker.net/content/games/2732/downloads/IMTS_Setup_24.exe" "7025979eb03e9a226e2dd742f0a02db6"
else
  POL_SetupWindow_browse "Please select the IMTS setup file" "$TITLE" "IMTS_Setup_24.exe"
  cp "$APP_ANSWER" "$POL_System_TmpDir/IMTS_Setup_24.exe"
fi
 
POL_Call POL_Install_directx9
POL_Call POL_Install_dotnet20
 
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$POL_System_TmpDir/IMTS_Setup_24.exe"
POL_Wine_reboot
 
POL_Shortcut "Game.exe" "$TITLE"
POL_System_TmpDelete
POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlL2QOoACgkQ5TH6yaoTykcEBACgqrKpNb6gLJL47PsTqvQe2ins
NmgAnidz0FNV7pr45zzF+kCqyxG4Kl8t
=02r2
-----END PGP SIGNATURE-----
