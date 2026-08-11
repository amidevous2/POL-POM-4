#!/bin/bash

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Internet Explorer 4"
PREFIX="InternetExplorer4"

WORKING_WINE_VERSION="1.7.49"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microsoft corporation" "http://www.microsoft.com/" "Tinou" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

POL_Wine iexplore -unregserver

POL_Wine_OverrideDLL native,builtin advpack iexplore.exe jscript mshtml shdocvw urlmon vbscript wininet

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Internet Explorer/"
rm iexplore.exe

cd "$WINEPREFIX/drive_c/windows/system32" || POL_Debug_Fatal "Unable to switch to system32"

rm advpack.dll inetcpl.cpl mshtml.dll schannel.dll shdocvw.dll urlmon.dll vbscript.dll wininet.dll

cd "$WINEPREFIX/drive_c"

POL_Wine_WaitBefore "$TITLE"
POL_System_TmpDelete

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Internet Explorer"
POL_Download "http://files.playonlinux.com/ie/standalone/ie401_nt.zip" "d043238cee0c07a323bd1246bb131c08"

unzip ie401_nt.zip 
mv IE401_NT/* ./
rmdir IE401_NT

POL_Shortcut "iexplore.exe" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlXST4wACgkQ5TH6yaoTykdc2gCdET5IpjNBMuaCSOO6lFSJQ/Tv
JF4An0ZhZs/P+yY87O44YhfxNxPgZoty
=ZIQd
-----END PGP SIGNATURE-----
