#!/usr/bin/env playonlinux-bash
# Date : (2021-04-13)
# Last revision : (2021-06-15 22-22)
# Distribution used to test : Linux Mint 20.1 Cinnamon
# Author : Yaotl
# Licence : GPLv3
# PlayOnLinux : 4.3.4


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Magic Legends"
PREFIX="MagicLegends"
WINEVERSION="6.0.1"
DOWNLOAD_URL="https://yaotl.heliohost.us/resources/setups/$PREFIX/CL_2021_05_21_17_59/Magic.7z"
MD5_CHECKSUM="f2cd2deb74919f3bcd6323224734e440"

#Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 4366
POL_Debug_Init

POL_SetupWindow_message "The game is currently in open beta! Game crashes and poor performance are to be expected!" "$TITLE - Open Beta"

# Presentation
POL_SetupWindow_presentation "$TITLE" "Cryptic Studios, Perfect World Entertainment Inc." "https://www.arcgames.com/games/magic-legends" "Yaotl" "$PREFIX"

# Checks the required POL/POM version
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

# Launcher Download
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "$DOWNLOAD_URL" "$MD5_CHECKSUM"

# Create Prefix
POL_System_SetArch "amd64"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Dependencies
POL_Call POL_Install_vcrun2019

# Asking about memory size of graphic card
POL_SetupWindow_VMS ${GAME_VMS}

POL_Wine_Direct3D "UseGLSL" "enabled"
POL_Wine_Direct3D "DirectDrawRenderer" "opengl"

# Set Graphic Card informations keys for wine
POL_Call POL_Install_VideoDriver

Set_OS "win81"

# Installation
mkdir -p "$WINEPREFIX/drive_c/Program Files/Magic Legends"
7z e "$POL_System_TmpDir/Magic.7z" -o"$WINEPREFIX/drive_c/Program Files/Magic Legends"

# Create Shortcut
POL_Shortcut "Magic.exe" "$TITLE" "" "" "Game;"

# Game Configuration
cd $POL_System_TmpDir

if [ "$POL_LANG" = "fr" ]; then
    lang="1036"
elif [ "$POL_LANG" = "de" ]; then
    lang="1031"
else
    lang="1033"
fi

cat << EOF > "lang.reg"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Cryptic\Magic: Legends]
"InstallLanguage"="$lang"
"InstallLocation"="C:/Program Files/Magic Legends"
EOF
POL_Wine regedit "lang.reg"

if [ "$POL_OS" = "Linux" ]; then
    POL_SetupWindow_checkbox_list "Optimal components:" "$TITLE" "DXVK" "~"
    if [ "$(echo $APP_ANSWER | grep -o "DXVK")" != "" ]; then
        POL_Call POL_Install_DXVK
    fi
fi

# Cleanup
POL_System_TmpDelete
POL_SetupWindow_message "$(eval_gettext 'NOTICE: $TITLE can take up to 15 minutes or longer to start for the first time. It only does this the first time the game has be ran.')" "$TITLE"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYMl9tAAKCRDlMfrJqhPK
R+0mAKCs4Xtgk8PVRSephb/PirBrUfL+nACeK5ynlhrvPwfME+I2EJ6Buya4myI=
=66d5
-----END PGP SIGNATURE-----
