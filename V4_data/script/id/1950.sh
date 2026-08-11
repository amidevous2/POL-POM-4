#!/usr/bin/env playonlinux-bash
# Date : 2014-02-08 14:54
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : ubuntu 19.04 x64
# Author : kweepeer2, m1kc (+ contributions by many others, thanks!)
# Depend :
# NOTE! From Options -> Game Settings -> Additional Command Line Arguments (for Hearthstone), write: -force-d3d9
  
# CHANGELOG
# [kweepeer2] (2014-02-08)
#   First script
# [iArska] (2018-01-28)
#   Misc.
# [Dadu042] (2019-05-25 22-40)
#   Wine 2.21-staging -> 2.22
# [Dadu042] (2019-11-31 15:30)
#   Wine 2.22 -> 4.0.2
#   Apply some changes found in this report: https://appdb.winehq.org/objectManager.php?sClass=version&iId=30038
# [Dadu042] (2020-11-01 18:00)
#   Wine 4.0.2 -> 4.0.4
#   Move "-force-d3d9" from warning message to automatic argument.
#   POL_System_SetArch "x86" (32 bits). Required for Dotnet40, because default is 64bits nowadays.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Hearthstone"
PREFIX="hearthstone"
   
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 1950
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "Blizzard" "http://us.battle.net/hearthstone/en/" "kweepeer2" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "4.0.4"
   
# Fix "Battle.net Helper.exe" crash on startup.
POL_Call POL_Install_corefonts
POL_Call POL_Install_RegisterFonts

# Disabled because 32bits only (was used with Wine v2)
# POL_Call POL_Install_ie8
   
# Fix Fireside Gathering search
POL_Call POL_Install_dotnet40

# Changes (2019-11-13) according: https://appdb.winehq.org/objectManager.php?sClass=version&iId=30038
POL_Wine_OverrideDLL "native,builtin" "msvcp140"
POL_Wine_OverrideDLL "native,builtin" "api-ms-win-crt-pricate-l1-1-0"
POL_Wine_OverrideDLL "" "d3d12"
POL_Wine_OverrideDLL "" "locationapi"
POL_Wine_OverrideDLL "" "nvapi"
POL_Wine_OverrideDLL "" "nvapi64"
POL_Wine_OverrideDLL "native,builtin" "ucrtbase"
#
cat << EOF > hearhstone_fix.reg
REGEDIT4
[HKCU\software\Wine\X11 Driver]
UseTakeFocus="no"
EOF
POL_Wine regedit.exe hearhstone_fix.reg
POL_Wine_WaitExit "$(eval_gettext 'Registry fix for X11.')"

   
# Set OS after .NET install
# to upgrade on win10, only .NET 4.6 is compliant, and not available on POL
Set_OS "win7"
   
# Download & Install the game.
# Multiple Language support. See https://eu.battle.net/account/download/?show=hearthstone&style=hearthstone
POL_SetupWindow_menu "$(eval_gettext 'What language do you want to install?')" "Language Selection" \
    "English (US)|Español (AL)|Português (BR)|English (EU)|Deutsch|Español (EU)|Português (EU)|Français|Russian|Italiano|Polski|Korean|Chinese (Taiwan)|Chinese (China)" "|"
case "$APP_ANSWER" in
    "English (US)")
        LANG="enUS";;
    "Español (AL)")
        LANG="esMX";;
    "Português (BR)")
        LANG="ptBR";;
    "English (EU)")
        LANG="enGB";;
    "Deutsch")
        LANG="deDE";;
    "Español (EU)")
        LANG="esES";;
    "Português (EU)")
        LANG="ptPT";;
    "Français")
        LANG="frFR";;
    "Russian")
        LANG="ruRU";;
    "Italiano")
        LANG="itIT";;
    "Polski")
        LANG="plPL";;
    "Korean")
        LANG="koKR";;
    "Chinese (Taiwan)")
        LANG="zhTW";;
    "Chinese (China)")
        LANG="zhCN";;
    *)
        exit 1;;
esac
   
SHORTCUT_FILE="Battle.net Launcher.exe"
EXE_FILE="Hearthstone-Setup-$LANG.exe"
   
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "http://dist.blizzard.com/downloads/hs-installers/a6029a1d625c79252defff3914fb6e67/retail.1/$EXE_FILE"
POL_Wine "$POL_System_TmpDir/$EXE_FILE"
POL_Wine_WaitExit "$TITLE" --allow-kill
POL_System_TmpDelete
   
POL_SetupWindow_VMS "256"
POL_Wine_reboot
   
POL_Shortcut "$SHORTCUT_FILE" "$TITLE" "$TITLE.png" "-force-d3d9" "Game;CardGame;"

# Useless as of 2020-10.
# POL_SetupWindow_message "$(eval_gettext 'WARNING:\nAfter exiting, select Hearhstone, then click Options -> Game Settings -> Additional Command Line Arguments, then do write: -force-d3d9')" "$TITLE"
  
POL_SetupWindow_Close   
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX57t+QAKCRDlMfrJqhPK
R6xbAJ9ucV8QnzpKO4CoUh9PWs9Q5/GQDACghfAwzVzK7VE/eHKBuetZQPmOi7E=
=mFLM
-----END PGP SIGNATURE-----
