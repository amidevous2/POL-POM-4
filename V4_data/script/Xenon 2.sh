#!/usr/bin/env playonlinux-bash
# Date : (2019-05-29 13-16)
# Last revision : See changelog
# Wine version used : see below
# Distribution used to test : XUbuntu 19.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux version used : 4.3.4
#
# Software version used to write this script: 
# Software based on: ?
#
# CHANGELOG
# [Dadu042] (2019-05-29 13-16)
#   Script refresh.
# [Tinou] (2010 ?)
#   Initial writting.
#
# Known issues:
# - Don't work on xubuntu 19.04 (missing files).

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Xenon 2"
PREFIX="xenon2"
WORKING_WINE_VERSION="1.6.2-dos_support_0.6"
AUTHOR="Tinou"
EDITOR="Image Works"
GAME_URL="https://en.wikipedia.org/wiki/Xenon_2_Megablast"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"

cd "$WINEPREFIX/drive_c"
POL_Download "$SITE/divers/oldware/Xenon2.zip" "c2dfbe1f48cd9e806f1dc812cdfb8fe5"
unzip Xenon2.zip

POL_Shortcut "XENON2.EXE" "Xenon 2"

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXO6HkQAKCRDlMfrJqhPK
RzEKAJ0QJf511RZKLa04bDlAp+uy219N3gCeMTIpksfbBhH4Th6H5jKwYWNv+3A=
=hE2V
-----END PGP SIGNATURE-----
