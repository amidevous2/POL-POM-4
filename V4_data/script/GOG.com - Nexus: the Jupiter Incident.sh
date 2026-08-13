#!/bin/bash
# Date : (2012-12-15 12-40)
# Last revision : (2013-12-10 22-28)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="nexus_the_jupiter_incident"
PREFIX="NexusTheJupiterIncident_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Nexus: the Jupiter Incident"
SHORTCUT_NAME="Nexus: the Jupiter Incident"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1513
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Mithis Entertainment / HD Publishing" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "02e94bbd65f549039402444842800c45"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "nexus.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Nexus - The Jupiter Incident/Manual.pdf"
# C:\GOG Games\Nexus - The Jupiter Incident\ReadMe.rtf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKnlY8ACgkQ5TH6yaoTykfd4wCgpW9esRFCdf7iFj96uMCZXjSo
55MAn1FyeVTr6Mh5Qz4Tr276ADCuyjo9
=lx2g
-----END PGP SIGNATURE-----
