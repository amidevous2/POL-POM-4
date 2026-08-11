#!/bin/bash

# CHANGELOG
# [SuperPlumus] (2013-07-07 19-55)
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Code::Blocks 10.05"
PREFIX="CodeBlocks"
WORKING_WINE_VERSION="1.4"

EDITOR="Codeblocks"
EDITOR_URL="http://www.codeblocks.org/"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$TITLE"

POL_Call POL_Install_LunaTheme

cd "$POL_System_TmpDir"
POL_Download "$SITE/divers/codeblocks-10.05mingw-setup.exe" "cab50ffb133d2362d1a4d76657a7993c"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "codeblocks-10.05mingw-setup.exe"

POL_System_TmpDelete

POL_Shortcut "codeblocks.exe"  "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRhNKAAKCRDlMfrJqhPK
R4S4AJ4jUw4kIh7wdIHJFt1FOTDxAm+9oQCfXrYCvezzUO43cXCajN+vQ7Ypbgg=
=Xfr/
-----END PGP SIGNATURE-----
