#!/bin/bash

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Internet Explorer 5"
PREFIX="InternetExplorer5"

WORKING_WINE_VERSION="1.7.49"
POL_GetSetupImages "" "http://files.playonlinux.com/resources/setups/ie6/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microsoft corporation" "http://www.microsoft.com/" "Tinou" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

POL_Wine iexplore -unregserver
Set_OS win98

POL_Wine_OverrideDLL native,builtin advpack browseui iexplore.exe inetcpl.cpl jscript mshtml shdoclc shdocvw shlwapi urlmon wininet

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Internet Explorer/"
rm iexplore.exe

cd "$WINEPREFIX/drive_c/windows/system32" || POL_Debug_Fatal "Unable to switch to system32"

rm advpack.dll browseui.dll comctl32.dll inetcpl.cpl jscript.dll mshtml.dll shdoclc.dll shdocvw.dll shell32.dll shlwapi.dll urlmon.dll wininet.dll
touch "WINDOWS.HLP"

cd "$WINEPREFIX/drive_c"

POL_Download "http://files.playonlinux.com/ie/5.01-sp2/ie501sp2.exe" "c9e395c26bce21ee21230437e5574846"

POL_Wine_WaitBefore "$TITLE"

# Preparing setup
POL_Wine ie501sp2.exe
cd "IE 5.01 SP2 Full"
cabextract IE4SHL95.CAB
cp shell32.dll "$WINEPREFIX/drive_c/windows/system32"

POL_Wine --ignore-errors IE5SETUP.EXE
POL_Wine_WaitExit "$TITLE"

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Internet Explorer/Connection Wizard"
mv icwconn1.exe icwconn1.bkp

POL_Wine_InstallFonts
POL_Shortcut "iexplore.exe" "$TITLE"
cd "$TMPDIR"
rm -rf "IE 5.01 SP2 Full"
POL_System_TmpDelete



POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlXSTmcACgkQ5TH6yaoTykf5IwCfW0xLR0xPbniUDmmCFU+EAy0T
84QAn1/2nZBjr2R4y6NesuGv2mGyQIJ0
=RuyM
-----END PGP SIGNATURE-----
