#!/bin/bash

# Date : 2014-03-28 20-00
# Last revision : (2014-03-28 20-00)
# Wine version used : 1.6.2
# Distribution used to test : Debian Jessie
# Author : Tr4sK

# CHANGELOG
# [Tr4sK] (2014-03-28 21-51)
#	Removed Version numbor from POL_Wine_PrefixCreate. Not needed
#	Removed POL_Wine_WaitBefore. Not needed
#	Fixing POL_GetSetupImages. Forgot to add the second argument :/
# [Tr4sK] (2014-03-28 21-00)
#	Initial release

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"


TITLE="Azuon"
WINEVERSION="1.6.2"
EDITOR="Azuon"
EDITOR_URL="http://azuon.com"
PREFIX="Azuon"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1981
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "Tr4sK" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate

POL_Call POL_Install_LunaTheme

POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"

# Some dependencies
POL_Call POL_Install_dotnet20
POL_Call POL_Install_gdiplus
POL_Call POL_Install_vcrun2008

POL_Download "http://azuon.com/downloads/Azuon.msi"
POL_Wine start /unix "Azuon.msi"
POL_Wine_WaitExit "$TITLE"

POL_System_TmpDelete



POL_Shortcut "Azuon.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlM16y4ACgkQ5TH6yaoTykdpCQCdE30VZxIGLpugPWlsqWWPqJWS
HqoAn1GL33CZnwyfmXDWmCSj1OuUHukm
=Y5ez
-----END PGP SIGNATURE-----
