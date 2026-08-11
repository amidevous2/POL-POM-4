#!/bin/bash
# Date : (2020-05-24)
# Last Revision : see changelog
# Wine Version used : see changelog
# Distribution used to test : Ubuntu 20.04
# Author: Dadu042
# Script license : GPL v2
# Programm license : Retail
# Depend :
#
# CHANGELOG
# [Dadu042] (2020-05-24) with GOG release v1.0.6.5
#   Initial script.
#
# KNOWN ISSUES :
#
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64: X 

 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="do_not_feed_the_monkeys"
PREFIX="Do_Not_Feed_the_Monkeys"
WORKING_WINE_VERSION="4.0.4"
TITLE="Do Not Feed the Monkeys"
GAME_VMS="256"
 
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Piranha Bytes" "http://www.gog.com/game/$GOGID" "Hoshpak" "$PREFIX"

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Call POL_GoG_setup "$GOGID"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "amd64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "win7"


 
POL_Call POL_GoG_install

 
# Configure the shortcut
GOGPATH="$GOGROOT/Do_not_feed_the_monkeys"
POL_Shortcut "dnftm.exe" "Do Not Feed the Monkeys" "" "" "Game;"
# POL_Shortcut_Document "" "$GOGPATH/ - Manual.pdf"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXsrcvwAKCRDlMfrJqhPK
R4WBAKCf/CAitFKHvWt6ablEs+mc1rIh5wCgoIDdhQRi7SNleiw9qDbvt/hA2/M=
=iIrr
-----END PGP SIGNATURE-----
