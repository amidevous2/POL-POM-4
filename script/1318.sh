#!/bin/bash

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Internet Explorer 2"
PREFIX="InternetExplorer2"

WORKING_WINE_VERSION="1.7.49"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microsoft Corporation" "http://www.microsoft.com/" "Tinou" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

Set_OS win95
POL_Wine iexplore -unregserver

POL_Wine_OverrideDLL native,builtin advpack iexplore.exe jscript mshtml shdocvw urlmon vbscript wininet

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Internet Explorer/"
rm iexplore.exe

cd "$WINEPREFIX/drive_c/windows/system32" || POL_Debug_Fatal "Unable to switch to system32"

rm advpack.dll,inetcpl.cpl,mshtml.dll,schannel.dll,shdocvw.dll,urlmon.dll,vbscript.dll,wininet.dll


POL_Wine_WaitBefore "$TITLE"

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Internet Explorer"
mkdir -p History
POL_Download "http://files.playonlinux.com/ie/2.0/msie20.exe" "4dba7e95a9afd6ce4283d204f3dd8c43"

cabextract msie20.exe
cabextract iexplore.cab

cat << EOF > ie2.reg
[HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\Main]
"Start Page"="http://www.playonlinux.com/"
EOF
POL_Wine regedit ie2.reg

POL_Shortcut "iexplore.exe" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlXSTrgACgkQ5TH6yaoTykfQwgCePXmFF1QeD8yToS3UskxfZ/1o
MFUAn1Gg0+0XZRiGvcHy8HENhladV4w8
=J/gc
-----END PGP SIGNATURE-----
