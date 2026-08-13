#!/bin/bash
# date : (2013-01-28 21-00
# Last version : (2013-06-08 18-11)
# Wine version used : 1.4
# Distribution used to test : Ubuntu 12.04 ( xubuntu )
# Author : Flotux

# CHANGELOG
# [SuperPlumus] (2013-06-08 18-11)
#   gettext
#   Fix <[ "$PLAYONLINUX" = "" ] && exit 0> test
#   Call POL_Wine_SetVideoDriver after POL_Wine_SelectPrefix

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#used variables.
TITLE="Divine Divinity"
PREFIX="DivineDiviniy"
AUTHOR="Flotux"
EDITOR="Larian Studio"
WEBSITE="www.larian.com"

POL_SetupWindow_Init
POL_Debug_Init

#presentation.
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$WEBSITE" "$AUTHOR" "$TITLE"

#Selection and creation of the prefix.
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
POL_System_SetArch "auto"

#cdrom verification
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "License_frn.txt"

#installation
POL_Wine start /unix "$CDROM/Setup.exe"
POL_Wine_WaitExit "$TITLE"

#definition of video driver.
POL_Wine_SetVideoDriver

#creation of the laucher
POL_Shortcut "DIV.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGzXlIACgkQ5TH6yaoTykerbQCfRgKyxACcY6nlGu5GveQDvPPa
0/cAni6f1gdxBaWO1UAMpMJzuKPw2d9V
=Ao3q
-----END PGP SIGNATURE-----
