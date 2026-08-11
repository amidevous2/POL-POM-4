#!/bin/bash
# Date : (2008-09-07 19-00)
# Last revision : (2013-09-30 13-08)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-09-30 13-08)
#   Update gettext messages
#   Update $TITLE var and script name
#   Fix call eval_gettext function (not evalgettext)
#   Fix $PROGRAMFILES var (missing POL_LoadVar_PROGRAMFILES)
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Command And Conquer 3 : Tiberium Wars (Kane Edition) Patch 1.09"
TITLE_REQUIRED="Command And Conquer 3 : Tiberium Wars (Kane Edition)"
PREFIX="CommandAndConquer3-KaneEdition"
PVERSION="1.09"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/cnc3/top.jpg" "http://files.playonlinux.com/resources/setups/cnc3/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 52

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION Installer for $TITLE_REQUIRED')"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "False" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')"
    POL_SetupWindow_Close
    exit
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
POL_LoadVar_PROGRAMFILES

POL_System_TmpCreate "$PREFIX"

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
    POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
    POL_SetupWindow_Close
    exit
fi

# Choose Game language
POL_SetupWindow_menu "$(eval_gettext 'Which language version would you like to install?')" "$TITLE" "$(eval_gettext 'French')~$(eval_gettext 'German')~$(eval_gettext 'English')" "~"
if [ "$APP_ANSWER" = "$(eval_gettext 'French')" ]; then
    GAME_LNG="fr"
elif [ "$APP_ANSWER" = "$(eval_gettext 'German')" ]; then
    GAME_LNG="de"
else
    GAME_LNG="en"
fi


POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    cd "$POL_System_TmpDir"
    if [ "$GAME_LNG" = "fr" ]; then
        PATCH_URL="ftp://ftp.ea.com/pub/eapacific/cnc3/CNC3_patch109_french.exe"
        PATCH_MD5="fdcaee1cc72274096c180aa2df331497"
        PATCH_EXE="CNC3_patch109_french.exe"
    elif [ "$GAME_LNG" = "de" ]; then
        PATCH_URL="ftp://ftp.ea.com/pub/eapacific/cnc3/CNC3_patch109_german(KaneEdition).exe"
        PATCH_MD5="c30c6ad734ecfbdf05e0de008f91c84f"
        PATCH_EXE="CNC3_patch109_german(KaneEdition).exe"
    else
        PATCH_URL="ftp://ftp.ea.com/pub/eapacific/cnc3/CNC3_patch109_english.exe"
        PATCH_MD5="42a82aa646ac77f12f0ccdea5fcd51fa"
        PATCH_EXE="CNC3_patch109_english.exe"
    fi
    POL_Download "$PATCH_URL" "$PATCH_MD5"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$PATCH_EXE"
    POL_Wine_WaitExit "$TITLE"
fi

if [ "$GAME_LNG" = "fr" ]; then
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Command & Conquer 3/"
    echo "add-big ../Lang-french/1.1/patch1.big" >> "RetailExe/1.1/config.txt"
    echo "add-big ../Lang-french/1.5/patch5.big" >> "RetailExe/1.5/config.txt"
    echo "add-big ../Lang-french/1.6/patch5.big" >> "RetailExe/1.6/config.txt"
    echo "add-big ../Lang-french/1.7/patch7.big" >> "RetailExe/1.7/config.txt"
    echo "add-big ../Lang-french/1.8/patch8.big" >> "RetailExe/1.8/config.txt"
    echo "add-big ../Lang-french/1.9/patch9.big" >> "RetailExe/1.9/config.txt"
elif [ "$GAME_LNG" = "de" ]; then
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Electronic Arts/Command & Conquer 3/"
    echo "add-big ../Lang-german/1.1/patch1.big" >> "RetailExe/1.1/config.txt"
    echo "add-big ../Lang-german/1.5/patch5.big" >> "RetailExe/1.5/config.txt"
    echo "add-big ../Lang-german/1.6/patch5.big" >> "RetailExe/1.6/config.txt"
    echo "add-big ../Lang-german/1.7/patch7.big" >> "RetailExe/1.7/config.txt"
    echo "add-big ../Lang-german/1.8/patch8.big" >> "RetailExe/1.8/config.txt"
    echo "add-big ../Lang-german/1.9/patch9.big" >> "RetailExe/1.9/config.txt"
fi

POL_System_TmpDelete

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJJZKQACgkQ5TH6yaoTykfQoQCcDqCcXWY9nBSKcQBhGGjy6zHA
ypgAoJqTkwqhg18TZEf4k+hchLuicfyF
=lWp4
-----END PGP SIGNATURE-----
