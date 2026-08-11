#!/usr/bin/env playonlinux-bash
# Date : (2015-02-04 15-30)
# Last revision : (2015-05-20 00-23)
# Wine version used : 1.5.0
# Distribution used to test : Ubuntu 14.10
# Author : Trucosuso

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="RaidCall"
PREFIX="raidcall"

# Get the images fot the presentation window
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 2420
# Enable debugging
POL_Debug_Init

# Presentation of the program
POL_SetupWindow_presentation "$TITLE" "RaidCall" "http://www.raidcall.com/" "Trucosuso" "$PREFIX"

# Selection of a prefix for wine and creation
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.5.0"

# Create the temp directory
POL_System_TmpCreate "$PREFIX"

# Download installer to the temp directory
cd "$POL_System_TmpDir"
POL_Download "http://update.raidcall.com/download/raidcall_v7.3.6.exe" "d09a3e9d8cb3a83797fa63b644c6f9bd"

# Running the instalation file from the temp directory
POL_SetupWindow_message "$(eval_gettext 'When installing, be sure not to let RaidCall launch automatically, so the POL setup can complete.')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$POL_System_TmpDir/raidcall_v7.3.6.exe"

# Waiting for the installer to finish
POL_Wine_WaitExit "$TITLE"

# Delete temp directory
POL_System_TmpDelete

# Create a launcher
POL_Shortcut "raidcall.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlVcDzoACgkQ5TH6yaoTyke0VQCfYTWrHsaq79FrEeworWI/xU+j
pVYAmwcz7qyGqt6YGdpSFAFQII2lE+vM
=ZGS0
-----END PGP SIGNATURE-----
