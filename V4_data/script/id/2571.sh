#!/bin/bash
# Date : (2015-07-04)
# Last revision : see changelog below
# Wine version used : see below
# Distribution used to test : Kubuntu 19.04 x64
# Author : see changelog
# Licence : GPLv3
# 
# CHANGELOG:
# [mimi89999] (2015-07-04)
#   Initial write.
# [amazingfate] (2016-06-27)
#   Add China server.
# (mauli] (2018-04-11)
#   Fix Download links.
# [VictorLima] (2018-10-11)
#   Fix North America Download link. Wine 1.7.55 -> 3.17
# [Dadu042] (2019-05-23)
#   Clean up. Approve latests submits. Wine 1.7.55 -> 4.01
# [Dadu042] (2019-06-24)
#   Fix 'game does not launch after clicking Play'. Wine 4.0.1 -> 3.0.5
# [Dadu042] (2019-06-26)
#   Wine 4.0.1 -> 4.11. POL_RequiredVersion 4.3.4
# [Dadu042] (2020-01-09)
#   Fix POL_RequiredVersion.
#   Fix POL_Shortcut category.
# [Dadu042] (2020-06-08)
#   Wine 4.11 -> 5.3
#   Game now fail to install correctly. I think it's because the 'Wargaming Game Center' is now mandatory.
#   Disable automatic setup download.

 
# KNOWN ISSUES:
# - Wine 3.0.5 and 4.0.1 24/06/2019. Game v0.8.4.0
# 'Bad exe format for: Games\World_of_Warships\bin64\WorldOfWarships64.exe.'
# After the first window, then click the button Play, the game launcher crashes. Same if launched in 'safe mode' (little button on the right of Play).
# Workaround : launch 'WorldOfWarships32.exe' instead of 'WoWSLauncher.exe'
#
# Game does crash at the end of a game session.  Wine 3.21 and 4.0.1 26/06/2019. Game v0.8.4.0
# Fixed by using Wine 4.11
#
#
# - After installing the 'Wargaming Game Center' (it's the begin of the installation), its window keep black.  Wine 4.21, 5.0. Fix: Wine 5.3
# - After installing the 'Wargaming Game Center' (it's the begin of the installation), it does crash.  Wine 4.11
# - After installing the 'Wargaming Game Center' I get 'Wargaming.net Game Center has stopped working' (window). Wine 5.3
# - After installing the 'Wargaming Game Center' it does not open (only appear in the task bar), installation stall. Wine 5.7


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="World Of Warships"
PREFIX="WorldOfWarships"
WINEVERSION="5.3"
AUTHOR="Several (see the changelog)"
EDITOR="Lesta Studio"
GAME_URL="https://en.wikipedia.org/wiki/World_of_Warships"
GAME_VMS="512"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2571
   
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_RequiredVersion "4.3.4" || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION\nPlease update"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "win10"

#######################################
#  Installing mandatory dependencies  #
#######################################

POL_Call POL_Install_d3dx9
POL_Call POL_Install_d3dcompiler_43

################
#      GPU     #
################
          
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
           
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
            
# Useful for Nvidia GPUs
POL_Call POL_Install_physx

#######################################
#  Select WoWS version                #
#######################################

cd "$WINEPREFIX/drive_c"

POL_SetupWindow_browse "$(eval_gettext 'Please select the installation file (.EXE)')" "$TITLE"
INSTALLER="$APP_ANSWER"

# Disabled because as of 2020-06 these .EXE (Europe) fail to install. The game seems now to require to use 'Wargaming Game Center'.
#
# POL_SetupWindow_menu "$(eval_gettext 'Which region version of World Of Warships would you like to install? Note: Korea is not supported yet.')" "$TITLE" "North America~Europe~Russia~Asia" "~"
# [ "$APP_ANSWER" = "North America" ] && DL_URL="http://dl-wows-gc.wargaming.net/na/files/MDcyICBcdT/WoWS_internet_install_na.exe"
# [ "$APP_ANSWER" = "Europe" ] && DL_URL="http://dl-wows-gc.wargaming.net/eu/files/ilcClx1YzB/WoWS_internet_install_eu.exe"
# [ "$APP_ANSWER" = "Russia" ] && DL_URL="http://dl-wows-gc.wargaming.net/ru/files/xIFx1MTA3O/WoWS_internet_install_ru.exe"
# [ "$APP_ANSWER" = "Asia" ] && DL_URL="http://dl-wows-gc.wargaming.net/asia/files/Kg9cc1LM/WoWS_internet_install_asia.exe"
# [ "$APP_ANSWER" = "China" ] && DL_URL="http://wowsdn.kongzhong.com/official/wows.0.5.7.0_cn_setup.0570062111.exe"
#
# POL_Download "$DL_URL"
# INSTALLER="${DL_URL##*/}"
  
# Useful ?  Submitted by Mauli, 2018.
# [ "$APP_ANSWER" = "North America" ] && DL_URL="https://worldofwarships.com/en/game/download/"
# [ "$APP_ANSWER" = "Europe" ] && DL_URL="https://worldofwarships.eu/en/game/download/"
# [ "$APP_ANSWER" = "Russia" ] && DL_URL="https://worldofwarships.ru/ru/game/download/"
# [ "$APP_ANSWER" = "Asia" ] && DL_URL="https://worldofwarships.asia/en/game/download/"
  
POL_SetupWindow_message "$(eval_gettext 'Note: we recommend you to uncheck all the checkboxes:\n[x] -> [ ]')" "$TITLE"

POL_Wine_WaitBefore "World Of Warships"
POL_Wine start /unix "$INSTALLER"
POL_Wine_WaitExit "World Of Warships"

################################ 
# Modify WoWSLauncher.cfg file #
################################

OLD="<launcher_transport>3"
NEW="<launcher_transport>2"
DPATH="$WINEPREFIX/drive_c/Games/World_of_Warships/WoWSLauncher.cfg"
TFILE="/tmp/out.tmp.$$"
for f in $DPATH
do
  if [ -f $f -a -r $f ]; then
   sed "s/$OLD/$NEW/g" "$f" > $TFILE && mv $TFILE "$f"
  else
   echo "Error: Cannot read $f"
  fi
done
/bin/rm $TFILE
   
OLD="<display_seeding_mode>2"
NEW="<display_seeding_mode>0"
DPATH="$WINEPREFIX/drive_c/Games/World_of_Warships/WoWSLauncher.cfg"
TFILE="/tmp/out.tmp.$$"
for f in $DPATH
do
  if [ -f $f -a -r $f ]; then
   sed "s/$OLD/$NEW/g" "$f" > $TFILE && mv $TFILE "$f"
  else
   echo "Error: Cannot read $f"
  fi
done
/bin/rm $TFILE
   
OLD="<display_seeding_mode>1"
NEW="<display_seeding_mode>0"
DPATH="$WINEPREFIX/drive_c/Games/World_of_Warships/WoWSLauncher.cfg"
TFILE="/tmp/out.tmp.$$"
for f in $DPATH
do
  if [ -f $f -a -r $f ]; then
   sed "s/$OLD/$NEW/g" "$f" > $TFILE && mv $TFILE "$f"
  else
   echo "Error: Cannot read $f"
  fi
done
/bin/rm $TFILE
   
POL_Shortcut "WoWSLauncher.exe" "World Of Warships (Launcher)" "" "" "Game;StrategyGame;"
 
# Probable fix for those whose launcher is stuck at receiving updates:
POL_Shortcut_InsertBeforeWine "$TITLE" 'sed -i.bak -e "s@<launcher_transport>3</launcher_transport>@<launcher_transport>2</launcher_transport>@" "$WINEPREFIX/drive_c/Games/World_of_Warships/WoWSLauncher.cfg"'
# As in https://www.playonlinux.com/en/app-1592-World_Of_Tanks.html
 
# Workaround (see KNOWN ISSUES above. There are 2 shortcuts because this script does not force WineArch):
POL_Shortcut "WorldOfWarships32.exe" "World Of Warships (32 bits)" "" "" "Game;StrategyGame;"
POL_Shortcut "WorldOfWarships64.exe" "World Of Warships (64 bits)" "" "" "Game;StrategyGame;"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXt4l2gAKCRDlMfrJqhPK
R+AHAKCaL0xCIFzlpMeEetbCnNFR45NWggCgmtf89tE0ru1P/y2B+m1vDsMYq/o=
=bW4B
-----END PGP SIGNATURE-----
