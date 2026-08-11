#!/bin/bash
# Date : (2011-12-09 20-31)
# Last revision : 
# Wine version used : 1.3.36, 1.5.29, 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2011-12-09 20-31)
#   Initial script.
# [Pierre Etchemaite] (2013-12-17 01-11)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.6.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="two_worlds"
PREFIX="2Worlds_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Two Worlds: Epic Edition"
SHORTCUT_NAME="Two Worlds"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1019
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Reality Pump Studios / Topware Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 3 "cfff8aad16e2486defa17dea93dcde8c" "57c4c9ce6ec296a59fcbcea2efbf3a58" "488a1f02f86b9e20b5b080d250b4b5af" "d3ebede3724ec5b67128a8d79df11b7b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install /nogui


POL_Call POL_Install_xact
POL_Call POL_Install_d3dx9_36

# Necessary to play videos
POL_Call POL_Install_devenum
POL_Call POL_Install_quartz
POL_Call POL_Install_wmp10

# WMV9AP VC-1 Codec
cd "$POL_USER_ROOT/tmp/" || POL_Debug_Fatal "$(eval_gettext 'temp directory missing')"
POL_Download 'http://www-pc.uni-regensburg.de/systemsw/WinMedia/wvc1dmo.exe' "cbbfea5937bebcc8ebf2ff6abfc050bd"
POL_Wine wvc1dmo.exe /C /Q '/T:C:\windows\temp'
cp "$WINEPREFIX/drive_c/windows/temp/wvc1dmod.dll" "$WINEPREFIX/drive_c/windows/system32"
POL_Wine regsvr32 wvc1dmod.dll

# Untested
#POL_Call POL_Install_directplay

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Fixes visible atmospheric planes
POL_Wine_Direct3D "StrictDrawOrdering" "enabled"

POL_Wine_X11Drv "GrabFullScreen" "Y"

#POL_Wine_DirectSound "DefaultSampleRate" "48000"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "TwoWorlds.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Two Worlds/Manual.pdf"

POL_Shortcut "TwoWorlds_RADEON.exe" "$SHORTCUT_NAME (Radeon)" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME (Radeon)" "$GOGROOT/Two Worlds/Manual.pdf"

# C:\GOG Games\Two Worlds\TwoWorlds.exe -network

POL_SetupWindow_question "$(eval_gettext 'Two Worlds Control Panel is a tool from InsideTwoWorlds community,\nthat allows you to tweak parameters and manage mods\nfor this game. See\nhttp://www.insidetwoworlds.com/local_links.php?linkid=21&catid=13 for details.\nInstall it?')" "$TITLE"
if [ "$APP_ANSWER" = "TRUE" ]; then
  cd "$POL_USER_ROOT/tmp/" 
  POL_Download 'http://www.insidetwoworlds.com/local_links.php?action=jump&catid=6&id=21' "49c9efa645fb560cf55c88d504d3eeaf"
  # Changed in POL 4.2
  [ -e local_links.php ] && mv local_links.php TwoWorldsCP107.zip || mv 'local_links.php?action=jump&catid=6&id=21' TwoWorldsCP107.zip
  unzip TwoWorldsCP107.zip TwoWorldsCP.exe
  POL_Wine_InstallFonts
  POL_Call POL_Install_dotnet20
  cd "$POL_USER_ROOT/tmp/"
  POL_Wine TwoWorldsCP.exe
  if [ $? -eq 0 ]; then
    # CP needs that weird path ending to find TW correctly!
    cat <<'_EOFINI_' > "$POL_USER_ROOT/tmp/fixtw1path.reg"
REGEDIT4

[HKEY_LOCAL_MACHINE\Software\Reality Pump\TwoWorlds\FileSystem]
"DataPath"="C:\\GOG Games\\Two Worlds/>"
"OutputDir"="C:\\GOG Games\\Two Worlds"
_EOFINI_
    POL_Wine regedit "$POL_USER_ROOT/tmp/fixtw1path.reg"
    rm "$POL_USER_ROOT/tmp/fixtw1path.reg"

    # Create a shortcut, since the CP behaves more like a launcher than a
    # configurator
    POL_Shortcut "TwoWorldsCP.exe" "$SHORTCUT_NAME - $(eval_gettext 'Control Panel')" "Two Worlds Control Panel.png" "" "Game;RolePlaying;"
  fi
fi

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT\Two Worlds/" || exit 1

POL_Wine TwoWorlds.exe -safemode
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxHbgAKCRDlMfrJqhPK
R7S9AJ92ZGly8SNaW0iuYTUOG5PcsaJ22gCbBJf2Um0FWB5AC7P7ItH0VOAoJMI=
=XJxu
-----END PGP SIGNATURE-----
