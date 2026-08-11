#!/bin/bash
# 
# Changelog:
# (2014-07-06 21:35) - create s3videofix.reg file and run it
#                      with regedit.exe, add OS checker for
#                      taskset -c 0 command
# (2014-07-06 23:11) - change echo to cat with EOT syntax,
#                      delete repeated code, create a common
#                      part of code for every type installation
# (2014-07-06 23:55) - add screen resolution mode selector
#                      add S3 configuration
# (2014-07-10 21:47) - change wine version to 1.5.0 - it helps to:
#                      fix video in campains (no more freezing)
#                      fix xrandr command in 1024x768 resolution
# (2014-07-10 22:10) - change taskset -c 0 to taskset -pc 0 $$
#                      lag fix works correctly
#                      
#
# ToDo:
# - add a multiplayer app - aLobby (java failed in now :( )
#
# App: The Settlers III Gold Edition
# Category: Games
# Wine rating: Platinum
# Date : (2014-07-11 00-48)
# Last revision : (2014-07-10 22-10)
# Wine version used : 1.5.0
# Distribution used to test : Linux Mint 17 "Qiana" x64
# Author : OdzioM
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="The Settlers III Gold Edition"
PREFIX="TheSettlers3"
WORKING_WINE_VERSION="1.5.0"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Blue Byte Software" "" "OdzioM" "$PREFIX"

POL_System_TmpCreate "s3tmp"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
Set_OS "win2000"
POL_Call POL_Install_iv50
POL_Call POL_Install_directplay

# Choose installation mode:
POL_SetupWindow_menu_num "$(eval_gettext 'Select a version of installation disc:')" "$TITLE" "$(eval_gettext 'Retail CD')~$(eval_gettext 'Version from CD-Action Polish magazine - 01.2006 - number 121')~$(eval_gettext 'Other destination or other CD/DVD')" "~"

if [ "$APP_ANSWER" == "0" ]; then
	# Version from retail CD
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disc drive.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	SETUP_EXE="$CDROM/setup.exe"
elif [ "$APP_ANSWER" == "1" ]; then
	# Version from CD-Action magazine - January 2006 (number 121)
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disc drive.')" "$TITLE"
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Full/Settlers III/setup.exe"
        SETUP_EXE="$CDROM/Full/Settlers III/setup.exe"
elif [ "$APP_ANSWER" == "2" ]; then
	# Other file localization
	cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
fi

POL_Wine "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
POL_Shortcut "S3.EXE" "$TITLE"
if [ "$POL_OS" == "Linux" ]; then
        # Lag Fix
	POL_Shortcut_InsertBeforeWine "$TITLE" "taskset -pc 0 $$"
fi
POL_Shortcut "SETUPS3.EXE" "$TITLE $(eval_gettext 'Configuration')"

cd "$POL_System_TmpDir"

# Choose screen resolution:
POL_SetupWindow_menu_num "$(eval_gettext 'Select a screen resolution:')" "$TITLE" "$(eval_gettext '1024x768')~$(eval_gettext '800x600')~$(eval_gettext '640x480')" "~"
if [ "$APP_ANSWER" == "0" ]; then
	# 1024x768

cat << EOF > resolution.reg
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\BlueByte\Siedler3\1.0\General]
"Resolution"=dword:00000002
EOF

elif [ "$APP_ANSWER" == "1" ]; then
	# 800x600

cat << EOF > resolution.reg
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\BlueByte\Siedler3\1.0\General]
"Resolution"=dword:00000001
EOF

elif [ "$APP_ANSWER" == "2" ]; then
	# 640x480

cat << EOF > resolution.reg
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\BlueByte\Siedler3\1.0\General]
"Resolution"=dword:00000000
EOF

fi

POL_Wine regedit.exe resolution.reg
POL_Wine_WaitExit "$(eval_gettext 'resolution fix')"

# Fix crash video - registry edit with system.reg file
cat << EOF > s3videofix.reg
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\BlueByte\Siedler3\1.0\General]
"Intro"=dword:00000000
EOF
POL_Wine regedit.exe s3videofix.reg
POL_Wine_WaitExit "$(eval_gettext 'video fix')"

# Complete message
POL_SetupWindow_message "$(eval_gettext 'Installation complete!\nTo run $TITLE please select $TITLE icon from your desktop.\n\nThank you for using this installation script! :)')" "$TITLE"

POL_System_TmpDelete
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO/G98ACgkQ5TH6yaoTykdX6ACgrbi9FY/Ja+63W//iVx71O85y
OgcAoI0m2mKgkpGq7a0fYxoueu8XplK+
=Ayxp
-----END PGP SIGNATURE-----
