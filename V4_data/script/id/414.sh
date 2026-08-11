#!/bin/bash
# Date : (2010-05-11 21:00)
# Last revision : (2018-11-05 09:38)
# Wine version used : 3.19
# Distribution used to test : Ubuntu 12.10, 12.04, 18.10 x64
# PlayOnLinux: 4.2.12
# Author : NSWL & GNU_Raziel, Tawane, LinuxScripter
  
# CHANGELOG
# [Tawane] (2012-05-25 17-10)
#   Delete all deprecated functions
#   Replace Mono by .NET
#   Add Debug messages
#   Set wine version to 1.4.1
#   Fix the script for x64 users
# [Tawane] (2012-05-26 21-30)
#   Fix some bugs
#   Fix localization
# [SuperPlumus] (2013-08-24 19-14)
#   Clean and update code
#   Fix $TITLE (Remove gettext in $TITLE)
#   Fix $TITLE (Move $TITLE before POL_SetupWindow_Init)
#   Update gettext messages
# [LinuxScripter] (2018-07-08 14:37)
#   Moved authors, game's developer and URL to SetupWindow
#   Changes to dependencies, the installer will crash without mcf42
#   Using more accurate file to verify the DVD
#   Fixed POL_Shortcut pointing to an incorrect .exe file, causing fake activation pop-ups
# [LinuxScripter] (2018-11-05 09:38)
#   Updated wine version to 3.19
#   Added the "xgamma -gamma 1" argumment to fix the issue with the screen getting too bright
#   Added a fix for Steam installer (content servers unreachable error)
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="The Sims 3"
TITLE_LAUNCHER="The Sims 3 Launcher"
PREFIX="TheSims3"
EDITOR="Electronic Arts and Maxis"
GAME_URL="http://www.thesims3.com/"
AUTHOR="NSWL, GNU_Raziel, Tawane and LinuxScripter"
WORKING_WINE_VERSION="3.19"
  
# Start the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/sims3/top.jpg" "http://files.playonlinux.com/resources/setups/sims3/left.jpeg" "$TITLE"
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_Call POL_Install_mfc42 #required by the installer
POL_Call POL_Install_vcrun2010 #required by the installer and the game
POL_Call POL_Install_dotnet35 #required by the launcher
POL_Call POL_Install_gecko #required by the launcher
POL_Call POL_Install_flashplayer #required by the launcher
POL_Call POL_Install_tahoma #required by the launcher
  
POL_SetupWindow_InstallMethod "LOCAL,DVD,STEAM"
  
if [ "$INSTALL_METHOD" = "DVD" ]; then
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "eauninstall.ico"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$CDROM/Setup.exe"
    POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    POL_SetupWindow_message "$(eval_gettext 'After loging in to Steam, shut it down so the script can apply the fix to config file')"
    POL_Call POL_Install_steam
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam/config"
    sed '27i                                "CS"                "valve511.steamcontent.com;valve501.steamcontent.com;valve517.steamcontent.com;valve557.steamcontent.com;valve513.steamcontent.com;valve535.steamcontent.com;valve546.steamcontent.com;valve538.steamcontent.com;valve536.steamcontent.com;valve530.steamcontent.com;valve559.steamcontent.com;valve545.steamcontent.com;valve518.steamcontent.com;valve548.steamcontent.com;valve555.steamcontent.com;valve556.steamcontent.com;valve506.steamcontent.com;valve544.steamcontent.com;valve525.steamcontent.com;valve567.steamcontent.com;valve521.steamcontent.com;valve510.steamcontent.com;valve542.steamcontent.com;valve519.steamcontent.com;valve526.steamcontent.com;valve504.steamcontent.com;valve500.steamcontent.com;valve554.steamcontent.com;valve562.steamcontent.com;valve524.steamcontent.com;valve502.steamcontent.com;valve505.steamcontent.com;valve547.steamcontent.com;valve560.steamcontent.com;valve503.steamcontent.com;valve507.steamcontent.com;valve553.steamcontent.com;valve520.steamcontent.com;valve550.steamcontent.com;valve531.steamcontent.com;valve558.steamcontent.com;valve552.steamcontent.com;valve563.steamcontent.com;valve540.steamcontent.com;valve541.steamcontent.com;valve537.steamcontent.com;valve528.steamcontent.com;valve523.steamcontent.com;valve512.steamcontent.com;valve532.steamcontent.com;valve561.steamcontent.com;valve549.steamcontent.com;valve522.steamcontent.com;valve514.steamcontent.com;valve551.steamcontent.com;valve564.steamcontent.com;valve543.steamcontent.com;valve565.steamcontent.com;valve529.steamcontent.com;valve539.steamcontent.com;valve566.steamcontent.com;valve165.steamcontent.com;valve959.steamcontent.com;valve164.steamcontent.com;valve1611.steamcontent.com;valve1601.steamcontent.com;valve1617.steamcontent.com;valve1603.steamcontent.com;valve1602.steamcontent.com;valve1610.steamcontent.com;valve1615.steamcontent.com;valve909.steamcontent.com;valve900.steamcontent.com;valve905.steamcontent.com;valve954.steamcontent.com;valve955.steamcontent.com;valve1612.steamcontent.com;valve1607.steamcontent.com;valve1608.steamcontent.com;valve1618.steamcontent.com;valve1619.steamcontent.com;valve1606.steamcontent.com;valve1605.steamcontent.com;valve1609.steamcontent.com;valve907.steamcontent.com;valve901.steamcontent.com;valve902.steamcontent.com;valve1604.steamcontent.com;valve908.steamcontent.com;valve950.steamcontent.com;valve957.steamcontent.com;valve903.steamcontent.com;valve1614.steamcontent.com;valve904.steamcontent.com;valve952.steamcontent.com;valve1616.steamcontent.com;valve1613.steamcontent.com;valve958.steamcontent.com;valve956.steamcontent.com;valve906.steamcontent.com"' config.vdf > config.vdf
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine "steam.exe" steam://install/47890
    POL_Wine_WaitBefore "$TITLE"
fi
  
if [ "$INSTALL_METHOD" = "STEAM" ]; then
    POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/47890" "-no-ces-sandbox" "xgamma -gamma 1"
else
    POL_Shortcut "*/Game/Bin/TS3.exe" "$TITLE" "xgamma -gamma 1"
    POL_Shortcut "*/Game/Bin/Sims3Launcher.exe" "$TITLE_LAUNCHER" "xgamma -gamma 1"
fi
 
POL_SetupWindow_Close
  
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUZoIAAKCRDlMfrJqhPK
R6mfAJ9KjQu4HgMRyOI3qHRxArAxJYulTACaA1XZY6UStaXxxmvqDaxu7d3MvT8=
=FJ6R
-----END PGP SIGNATURE-----
