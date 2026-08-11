#!/bin/bash
# Date : (2012-08-11 16-50)
# Last revision : see changelog
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2014-02-15 19-30)
#   First script.
# [Dadu042] (2019-12-19 20:50)
#   Wine 1.6.2 -> system version

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="sid_meiers_alpha_centauri"
PREFIX="AlphaCentauri_gog"

TITLE="GOG.com - Alpha Centauri"
SHORTCUT_NAME1="Alpha Centauri"
SHORTCUT_NAME2="Alpha Centauri - Alien Crossfire"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1361

POL_SetupWindow_presentation "$TITLE" "Firaxis Games / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

# For OS/X we automatically download sox
if [ "$POL_OS" != "Mac" ]; then
    sox --version || POL_Debug_Fatal "Please install sox before installing $TITLE"
fi

POL_Debug_Init

POL_Call POL_GoG_setup "$GOGID" "6c9bd7e1cf88fdbfa0e75f694bf8b0e5"

POL_Wine_SelectPrefix "$PREFIX"
# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_Wine_PrefixCreate

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "2"

if [ "$POL_OS" = "Mac" ]; then
    POL_System_TmpCreate "$PREFIX"
    cd "$POL_System_TmpDir"
    POL_Download "http://files.playonlinux.com/sox-osx.7z" "3c97904fa3799513a31fbbb48c8edf4b"
    POL_System_ExtractSingleFile "$PWD/sox-osx.7z" "sox" "$PWD/sox"
    chmod +x sox
    PATH="$POL_System_TmpDir:$PATH"
fi

cd "$WINEPREFIX/drive_c/GOG Games/Sid Meier's Alpha Centauri/fx" || POL_Debug_Fatal "Could not find sounds directory"

# Activate pulsebar if you want to turn a 4 seconds job into a 3 minutes one (POL 4.1.6)
#POL_SetupWindow_pulsebar "$(eval_gettext 'Fixing sounds gain')" "$TITLE"
PULSE=0
# 2s of silence (for what I'm about to do :D)
sox -n -r 22050 -c 1 silence.wav trim 0 2
for i in *.wav; do # 355 files
  #POL_SetupWindow_set_text "$i"
  case "$i" in
    "CPU please don't go.wav"|"CPU review your options.wav")
      # those loop if modified - possibly more to go
      ;;
    "opening menu.wav")
      # Need looping, but the whole sound!
      mv "$i" "$i.orig" &&
      sox "$i.orig" "$i.orig" "$i.orig" "$i.orig" "$i.orig" "$i.orig" silence.wav "$i" && rm "$i.orig"
      ;;
    *)
      # avoid clipping
      mv "$i" "$i.orig" &&
      sox "$i.orig" "$i" gain -3 && rm "$i.orig"
      ;;
    esac
    let PULSE++
    #POL_SetupWindow_pulse "$((PULSE*20/71))"
done

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "terran.exe" "$SHORTCUT_NAME1" "" "" "Game;StrategyGame;" # "$SHORTCUT_NAME1.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME1"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Sid Meier's Alpha Centauri/Manual.pdf"
# C:\GOG Games\Sid Meier's Alpha Centauri\readme.txt

POL_Shortcut "terranx.exe" "$SHORTCUT_NAME2" "" "" "Game;StrategyGame;" # "$SHORTCUT_NAME2.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME2"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Sid Meier's Alpha Centauri/readme_ac.txt"
# C:\GOG Games\Sid Meier's Alpha Centauri\facedit.exe

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg5pawAKCRDlMfrJqhPK
R+dhAJ9JZAVHM9v1UdK6kXTTuMPZYP0n4QCeJkCqj+4B+w+pkAlJv/qzAfQX2+U=
=wTOL
-----END PGP SIGNATURE-----
