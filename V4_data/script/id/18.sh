#!/bin/bash

# CHANGELOG
# [Martenk] (2017-12-26 20-23)
#   Adding download free version from battle.net
#   Changing name from Starcraft to StarCraft
# [SuperPlumus] (2013-06-09 15-26)
#   gettext + clean
#   Fix POL_SetupWindow_browe -> POL_SetupWindow_browse (missing 's')

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="StarCraft : BroodWar"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Blizzard" "http://www.blizzard.com" "Zoloom" "StarCraft"

POL_Wine_SelectPrefix "StarCraft"
POL_Wine_PrefixCreate "2.21-staging"

POL_Wine_InstallFonts
Set_OS "win7"

POL_System_TmpCreate "StarCraft"

POL_SetupWindow_InstallMethod "CD,LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SetupIs="$APP_ANSWER"
fi

if [ "$INSTALL_METHOD" = "CD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "setup.exe"
    SetupIs="$CDROM/setup.exe"
fi

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    cd "$POL_System_TmpDir"
    POL_Download "https://battle.net/download/getInstallerForGame?os=WIN&version=LIVE&gameProgram=STARCRAFT"
    mv getInstallerForGame\?os=WIN\&version=LIVE\&gameProgram=STARCRAFT StarCraft-Setup.exe
    SetupIs="$POL_System_TmpDir/StarCraft-Setup.exe"
fi

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupIs"

POL_System_TmpDelete
if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    POL_Shortcut "Battle.net\ Launcher.exe" "$TITLE"
else
    POL_Shortcut "StarCraft.exe" "$TITLE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOveHAAKCRDlMfrJqhPK
RzLLAJ0bYtmIle1SG7j/ngvhuzPM/brMmACeIQZSWv+4gLyNPMp1NzbzRB5o9dc=
=ffGw
-----END PGP SIGNATURE-----
