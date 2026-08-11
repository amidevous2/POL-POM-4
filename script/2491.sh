#!/bin/bash
# Date : (2015-04-02)
# Last revision : (2021-07-16 22-23)
# Distribution used to test : 
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux : 4.3.4
#
# CHANGELOG
# [R. Dusette] (2015-04-02)
#   First script.
# ...
# [Yaotl] (2019-11-26)
#   Wine 3.19 -> 4.0.2
# [Dadu042] (2019-12-02)
#   Wine 4.0.2 -> 4.0.3, because 4.0.2 is still not available from OSX on Playonmac (while 4.0.3 is).
# [Dadu042] (2020-01-09)
#   Fix VMS order.
# [Yaotl] (2021-05-05)
#   Wine 4.0.3 -> 6.0
#   Script updates

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

WINEVERSION="6.0.1"
TITLE="Star Trek Online"
PREFIX="StarTrekOnline"
DOWNLOAD_URL=" http://files.startrekonline.com/launcher/Star Trek Online.exe"
MD5_CHECKSUM="deb63cf6240232f92020ee95cf9fc435"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.png" "http://files.playonlinux.com/resources/setups/$PREFIX/left.png" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 2491
POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "Perfect World Entertainment Inc." "https://www.arcgames.com/games/star-trek-online" "RoninDusette" "$PREFIX"

# Checks the required POL/POM version
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update."

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

# Launcher Download
mkdir -p "$WINEPREFIX/drive_c/Program Files/Star Trek Online"
cd "$WINEPREFIX/drive_c/Program Files/Star Trek Online"
POL_Download "$DOWNLOAD_URL" "$MD5_CHECKSUM"

# Create Shortcut
POL_Shortcut "Star\ Trek\ Online.exe" "$TITLE" "" "" "Game;"

# Game Configuration
POL_System_TmpCreate "$PREFIX"
cd $POL_System_TmpDir

if [ "$POL_LANG" = "fr" ]; then
    lang="1036"; # French
elif [ "$POL_LANG" = "de" ]; then
    lang="1031"; # German
else
    lang="1033"; # English
fi

cat << EOF > "lang.reg"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Cryptic\Star Trek Online]
"InstallLanguage"="$lang"
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

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYPK5gQAKCRDlMfrJqhPK
Ryd7AJ95BKBD+5hiYGr13nFciMI0JAPuVwCfbRZ4dKhu8MQ1nMh+OIi4Rkm2Mgs=
=wvqn
-----END PGP SIGNATURE-----
