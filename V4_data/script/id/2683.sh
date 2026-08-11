#!/usr/bin/env playonlinux-bash
# Date : (2015-12-07 06-36)
# Last revision : (2015-12-23 04-52)
# Wine version used : 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Gabriel Huber huberg18@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="rollercoaster_tycoon_deluxe"
PREFIX="RollerCoasterTycoon_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - RollerCoaster Tycoon: Deluxe"
SHORTCUT_NAME="RollerCoaster Tycoon: Deluxe"

# Manually set the install location because we're not using the installer
# Has to match with the one in the registry patch for the DRM to work
INSTALL_LOCATION="drive_c/GOG Games/RollerCoaster Tycoon Deluxe/"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2683
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Chris Sawyer Productions / Atari" \
    "http://www.gog.com/game/$GOGID" "Gabriel Huber" "$PREFIX"

# Get setup path
POL_Call POL_GoG_setup "$GOGID" "c6516a80d361a70fd5866fdd18004c46"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

INSTALL_PATH="${WINEPREFIX}/${INSTALL_LOCATION}"

# Extract the game files
POL_Call POL_innoextract "$POL_GoG_location" "$POL_System_TmpDir" "$INSTALL_PATH"

# Apply the registry patch
cat > "$POL_System_TmpDir/rct1.reg" << EOF
REGEDIT4

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group]


[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]


[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"Title"="Roll"

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"Path"="C:\\\\GOG Games\\\\RollerCoaster Tycoon Deluxe"

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"SetupPath"="C:\\\\GOG Games\\\\RollerCoaster Tycoon Deluxe"

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"Executable"="RCT.EXE"

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"FontPointSize"=dword:0000000c

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"Language"=dword:00000000

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"CDKey"=dword:00000000

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"CharSet"=dword:00000000

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"FontFaceName"="MS Sans Serif"

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"OKPrompt"="OK"

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"CancelPrompt"="Cancel"

[HKEY_LOCAL_MACHINE\\SOFTWARE\\Fish Technology Group\\RollerCoaster Tycoon Setup]
"AddOn"=dword:00000001

EOF

POL_Wine regedit "$POL_System_TmpDir/rct1.reg"

POL_System_TmpDelete

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "RCT.EXE" "$SHORTCUT_NAME" "" "" "Game;Simulation;"
POL_Shortcut_Document "$SHORTCUT_NAME" "${INSTALL_PATH}manual.pdf"

POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')" "$TITLE"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYVHIbgAKCRDlMfrJqhPK
R9mDAKCkTMUsnBuHVu8hx+h4rMw88NL4IwCgouHWEaZ2Nlq5lJdYQB9oBFY9cWs=
=p2lc
-----END PGP SIGNATURE-----
