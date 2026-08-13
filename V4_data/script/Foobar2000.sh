#!/bin/bash
 
# Date : 2014-04-21 18-00
# Last revision : (2019-04-07 19-00)
# Wine version used : 1.6.2
# Distribution used to test : Debian Jessie, Fedora 29
# Author : Tr4sK, Koblaid, Tarulia
 
# CHANGELOG
# [Tr4sK] (2014-04-21 18-00)
#        Initial release
# [Koblaid] (2014-06-12)
#        Bugfix: setup file must be downloaded manually
# [Tarulia] (2019-04-07)
#        open Browser for downloading setup, removed WINEVERSION since it's unused, minor cleanups

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="foobar2000"
EDITOR="foobar2000"
EDITOR_URL="http://www.foobar2000.org"

SCRIPT_AUTHOR="Tr4sK, Koblaid, Tarulia"
PREFIX="foobar2000"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2011
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "$SCRIPT_AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate
Set_OS "win7"

POL_Browser "https://www.foobar2000.org/download"
POL_SetupWindow_browse "Please download the setup file from the foobar2000 website (opened in your browser) and select it." "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Shortcut "foobar2000.exe" "$TITLE" "" "" "AudioVideo;Audio;Player;"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAly+IcAACgkQ5TH6yaoTykfgjQCaAkRyp5hXRwZPCLSsoYp3NBn0
09oAn1KX9nyy+kzzkrUbd3uLZ5wuplp9
=npV+
-----END PGP SIGNATURE-----
