#!/usr/bin/env playonlinux-bash
: '
Date: See changelog.
Last revision: See changelog.
Wine version used: See changelog.
Distribution used to test: See changelog.
Author: GuerreroAzul
License: Retail

CHANGELOG
[GuerrreroAzul] (2024-02-06 14:00 GMT-6) Wine 6.17 x64 / Linux Mint 21.3 x86_64
  Creation of the script

REFERENCE
GuerreroAzul: Documentation POL. - https://wiki.playonlinux.com/
GuerreroAzul: Link Download. - https://nachogames.itch.io/thats-not-my-neighbor
'
       
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Setting
TITLE="That's not my Neighbor"
PREFIX="TNMN"
CATEGORY="Games;"
WINEVERSION="6.17"
ARQUITECTURE="x64"
OSVERSION="win7"
EDITHOR="GuerreroAzul"
COMPANY="Nacho Sama"
HOMEPAGE="https://nachogames.itch.io/thats-not-my-neighbor"
LOGO="https://i.imgur.com/aiFn2eg.png"
BANNER="https://i.imgur.com/Di6W76j.png"

#Setup Image
POL_GetSetupImages "$LOGO" "$BANNER" "$TITLE"

# Starting the script
POL_SetupWindow_Init

# Welcome message
POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$HOMEPAGE" "$EDITHOR" "$PREFIX"

# PlayOnLinux Version Check
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$(eval_gettext 'TITLE wont work with $APPLICATION_TITLE $VERSION\nPlease update!')"

# Check winbind library is installed.
if [ "$POL_OS" = "Linux" ]; then
  wbinfo -V || POL_Debug_Fatal "$(eval_gettext 'Please install winbind before installing.')" "$TITLE!"
fi

# Prepare resources for installation!
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "$ARQUITECTURE"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "$OSVERSION"

# Script start
cd "$HOME"

POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
INSTALLER="$APP_ANSWER"

# Install Program
LOCATION="$WINEPREFIX/drive_c/Program Files/$TITLE"

mkdir "$LOCATION"
cp "$INSTALLER" "$LOCATION"

# Shortcut
TEXT=$(echo "$LOCATION" | rev | cut -d'/' -f1 | rev)
POL_Shortcut "$TEXT.exe" "$TITLE" "" "" "$CATEGORY"

# End script
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCZiDX9wAKCRDlMfrJqhPK
R67CAKCbem6DFoZaRMNjjIvlpzIMKRGsqACgrNDHD6hbDeU3L2m5sjJHurZkDlg=
=c0e8
-----END PGP SIGNATURE-----
