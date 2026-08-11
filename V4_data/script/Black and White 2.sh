#!/bin/bash
# Date : (2010-08-02)
# Last revision : (2010-08-05)
# Wine version used : 1.2
# Distribution used to test : Ubuntu 10.10
# Author : zedtux
# Licence : Retail

GAMENAME="Black And White 2"
PREFIX="blackwhite2"
NEEDEDWINEVERSION="1.2"
GAME_SETUP="setup.exe"
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3} 

# Verify playonlinux dependencies
[ "$PLAYONLINUX" = "" ] && exit 0 
source "$PLAYONLINUX/lib/sources"

# Initialize the main window
POL_SetupWindow_Init
POL_SetupWindow_presentation "$GAMENAME" "Lionhead" "http://www.lionhead.com/bw2/" "zedtux" "$PREFIX"


select_prefix "$REPERTOIRE/wineprefix/$PREFIX"

# Create Wine environnement before install the game
POL_SetupWindow_prefixcreate

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "$GAME_SETUP"

# Adding CD-ROM as drive d: to winecfg
cd "$WINEPREFIX/dosdevices"
ln -s "$CDROM" d:
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > cdrom.reg
[HKEY_LOCAL_MACHINE\\Software\\Wine\\Drives]
"d:"="cdrom"
EOF
regedit cdrom.reg

# Launching Installation
cd "$CDROM"
wine "$GAME_SETUP"

PATCHING="TRUE"
while [ "$PATCHING" == "TRUE" ] ; do
    POL_SetupWindow_question "Please wait until installation complet !\n\nIt's recommended to patch the game to the version 1.2.\nDo you want to apply a patch?" "$GAMENAME"
    PATCHING=$APP_ANSWER
    if [ "$APP_ANSWER" == "TRUE" ] ; then
        POL_SetupWindow_browse "Select the patch file to install" "Patching $GAMENAME" ""
        if [ "$APP_ANSWER" != "" ] ; then
            POL_SetupWindow_wait_next_signal "Patching $GAMENAME..."
            wine "$APP_ANSWER"
            POL_SetupWindow_detect_exit
            POL_SetupWindow_message "$GAMENAME patched successfully" "$GAMENAME"
        fi
    fi
done

#asking about memory size
POL_SetupWindow_menu_list "How much memory do your graphic card have got?" "$TYTUL" "32-64-128-256-384-512-768-890-1024-2048" "-" "256"
VMS="$APP_ANSWER"

#Configuration de Wine
cd "$WINEPREFIX/drive_c/windows/temp/"
cat << EOF > direct3d.reg
[HKEY_CURRENT_USER\\Software\\Wine\\Direct3D]
"VideoMemorySize"="$VMS"
"Multisampling"="enabled"
"OffscreenRenderingMode"="backbuffer"
EOF
regedit direct3d.reg

# Defining options of the environnement
POL_SetupWindow_install_wine "$NEEDEDWINEVERSION"
Set_WineVersion_Assign "$NEEDEDWINEVERSION" "$GAMENAME"

# Creating shortcut
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Lionhead Studios/Black & White 2/" "white.exe" "" "$GAMENAME" ""

POL_SetupWindow_message "$GAMENAME has been installed successfully" "$GAMENAME"

# Close the main window !
POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF8ACgkQ5TH6yaoTykftpACeOOPvdIolA7466xjOBfd4fYUu
0dYAn0+wCJxcOjiBvmNRbPQyOrwEwZaL
=zg21
-----END PGP SIGNATURE-----
