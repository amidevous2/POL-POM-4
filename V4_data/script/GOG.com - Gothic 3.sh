#!/bin/bash
# Date : (2012-06-30 21-24)
# Last revision : (2014-02-01 16-28)
# Wine version used : 1.5.15, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2014-08-20 20:18)
#   Initial script
# [Pierre Etchemaite] (2014-08-20 20:18)
#   ?
# [Dadu042] (2020-03-21 22:10)
#   Wine 1.6.2 (outdated) -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="gothic_3"
PREFIX="Gothic3_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Gothic 3"
SHORTCUT_NAME="Gothic 3"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1291
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Piranha Bytes / Nordic Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "1aadb3d847fc6bd346b583fe0621d85c" "76fba2e801e2e45efa780ae1598abaf8" "78ba49e01c07bf6c97c14145931525b7"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# Shaders compilation doesn't seem to work under Wine, use precompiled cache from
# Community patch 1.75.14
MYDOCS_PATH="$(winepath -u "$(POL_Wine regedit /E - 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' | sed -n 's/"Personal"="\(.*\)".*/\1/p')")"
mkdir -p "$MYDOCS_PATH/Gothic3"
cd "$MYDOCS_PATH/Gothic3" || POL_Debug_Fatal "Could not find shaders cache directory"
POL_Download "http://files.playonlinux.com/Shader.Cache.bz2" "7d256885053747b6610a77d8f3782838"
bunzip2 "Shader.Cache.bz2"

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

POL_Call POL_Install_d3dx9_36
POL_Call POL_Install_d3dx9_40

# Workaround for black sky
POL_Wine_Direct3D "AlwaysOffscreen" "enabled"

# Performance tweak http://appdb.winehq.org/objectManager.php?sClass=version&iId=6012&iTestingId=71819
perl -i.bak -pe 'print "Timer.ThreadSafe=false\r\n" if /^Timer\.bIsSmooth=/' "$GOGROOT/Gothic 3/Ini/ge3.ini"

POL_Wine_X11Drv "GrabFullScreen" "Y"
POL_Wine_X11Drv "DXGrab" "Y"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Gothic3.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Gothic 3/Manual.pdf"
# C:\GOG Games\Gothic 3\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnVXDAAKCRDlMfrJqhPK
R+6dAJ4jB8nwx4JaDdrjjamLS9wCKwuSywCfZFaO3sM3k0UW9nMJSvGwsQy0gh4=
=fZBu
-----END PGP SIGNATURE-----
