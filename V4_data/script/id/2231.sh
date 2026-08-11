#!/bin/bash
# Date : (2014-08-19 18:32)
# Last Revision : see changelog
# Wine Version used :
# Distribution used to test : Debian testing/jessie
# Author: Hoshpak
#  - updated by petch
# Script license : GPL v2
# Programm license : Retail
# Depend :
#
# CHANGELOG
# [Hoshpak] (2014-08-19 18:32)
#   Initial script.
# [Pierre Etchemaite] (2014-11-16 22:01)
#   Script updated for GOG's installer v2.
#   Update download hash
#   Add SetID
#   Add sdbinst workaround
#   Replace language selection script code by game configurator
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="stronghold_crusader"
PREFIX="Stronghold_crusader_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Stronghold Crusader HD"
SHORTCUT_NAME1="Stronghold Crusader HD"
SHORTCUT_NAME2="Stronghold Crusader Extreme HD"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2231
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Firefly Studios" "http://www.gog.com/game/$GOGID" "Hoshpak" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "440291642e8e588cdb046c9f30878353"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe"

POL_Call POL_GoG_install

# Needed for multiplayer
POL_Call POL_Install_directplay

Set_OS winxp

# Configure the shortcut
GOGPATH="$GOGROOT/Stronghold Crusader Extreme HD"
POL_Shortcut "Stronghold Crusader.exe" "$SHORTCUT_NAME1" "" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGPATH/manual/manual.pdf"
POL_Shortcut "Stronghold_Crusader_Extreme.exe" "$SHORTCUT_NAME2" "" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGPATH/manual/manual.pdf"

POL_SetupWindow_Close

for SHORTCUT in "$SHORTCUT_NAME1" "$SHORTCUT_NAME2"; do
cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES
cd "\$WINEPREFIX/drive_c/GOG Games/Stronghold Crusader Extreme HD" || exit 1
TITLE="$TITLE"

POL_Wine "Language Setup.exe"

# Workaround, setup forgets to rename documentation files when French is selected
[ -e readme.html ] || ln -s readme_fr.html readme.html
[ -e manual/manual.pdf ] || ln -s manual_fr.pdf manual/manual.pdf

exit 0
_EOF_
done

# Run the configurator?
bash "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME1"

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx+7AAKCRDlMfrJqhPK
R+uXAKCwQj6mVITblrsKAvu79rXyVnR5tgCgl7YGPS/y3x4CEGf3KGEvUPlzYP0=
=xyst
-----END PGP SIGNATURE-----
