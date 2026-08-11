#!/usr/bin/env playonlinux-bash       

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Orwell Dev-C++"
PREFIX="Dev_Cpp"
WORKING_WINE_VERSION="4.0.2"

EDITOR="Orwell Dev-C++"
EDITOR_URL="http://orwelldevcpp.sourceforge.io/"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "Alvarito050506" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$TITLE"

cd "$POL_System_TmpDir"
POL_Download "https://sourceforge.net/projects/orwelldevcpp/files/Setup%20Releases/Dev-Cpp%205.11%20TDM-GCC%204.9.2%20Setup.exe/download"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "Dev-Cpp 5.11 TDM-GCC 4.9.2 Setup.exe"
POL_System_TmpDelete
POL_Shortcut "devcpp.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXeF7QwAKCRDlMfrJqhPK
R3PJAJsE/afms8cZ/P/hdcvuFMSoxzSTaQCfcplF6n5ecDs+jxyE6UTvaxxEvwM=
=zG72
-----END PGP SIGNATURE-----
