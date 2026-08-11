#!/bin/bash
# Date: (7/3/2012)
# Wine version used: 1.3.12
# Distribution used to test : Linux Ubuntu 12.04 x64
# Author: Tory Gaurnier
# Licence: OpenSource
 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Command And Conquer : Red Alert"
PREFIX="RedAlert"
DDRAWURL="http://hifi.iki.fi/cnc-ddraw/ddraw.dll"
PATCHURL="http://nyerguds.arsaneus-design.com/cncstuff/ra303patch.exe"
 
# Starting the script
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Westwood Studios Inc." "www.commandandconquer.com" "Tory Gaurnier" "$PREFIX"

POL_SetupWindow_message "$(eval_gettext 'NOTE: This installer requires you to use a CD, if you downloaded the freeware ISO images released by EA, please burn them to a CD or DVD using something like Brasero, and insert into your CD drive. Mounting the ISO images may work with certain software, however I know that Mounty does not work for this.')" "$TITLE"

# Create temp folder and download needed files
POL_System_TmpCreate "RedAlert"
cd $POL_System_TmpDir
POL_Download "$PATCHURL"
POL_Download "$DDRAWURL"

# Create and setup wine prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "1.3.12"
POL_Wine_OverrideDLL "native,builtin" "ddraw"
Set_OS "win98"

# Install game
POL_SetupWindow_cdrom
SETUP_EXE=$CDROM/SETUP.EXE
ln -s $CDROM/ $WINEPREFIX/dosdevices/d\:
#POL_SetupWindow_message "$(eval_gettext 'Next, mount the Soviet disk or iso image, and choose its mount location')" "$TITLE"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"

# Set back to winxp and install update patch
Set_OS "winxp"
POL_Wine start /unix "$POL_System_TmpDir/ra303patch.exe"
POL_Wine_WaitExit "$TITLE"

# Move ddraw.dll to game directory (fixes most bugs under Windows XP and Wine)
mv "$POL_System_TmpDir/ddraw.dll" "$WINEPREFIX/drive_c/WESTWOOD/REDALERT/ddraw.dll"

POL_System_TmpDelete
POL_Shortcut "RA95.exe" "$TITLE" "redalert.png"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlADClEACgkQ5TH6yaoTykc4wQCeJt2NZFBBp5Q+7F9dfeycsF8Z
NnIAnA2QsSiHbJYOIp1A+KMjthXTYlCv
=VESn
-----END PGP SIGNATURE-----
