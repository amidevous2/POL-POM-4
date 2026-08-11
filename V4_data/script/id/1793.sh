#!/bin/bash
# Date : (2013-08-11)
# Last revision : (2013-08-11)
# Wine version used : 1.4.1
# Distribution used to test : Linux Mint 15 KDE (64-bit)
# Author : pip99

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - Neighbours From Hell Compilation"
PREFIX="NeighboursFromHellCompilation_gog"
SHORTCUT_NAME1="Neighbours From Hell 1"
SHORTCUT_NAME2="Neighbours From Hell 2"
GOGID="neighbours_from_hell_compilation"
WORKING_WINE_VERSION="1.4.1"
SELECTED_LANGUAGE="eng"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "JoWooD Productions Software / Nordic Games" "http://www.gog.com/gamecard/$GOGID" "pip99" "$PREFIX"

POL_SetupWindow_menu "$(eval_gettext 'What is your preferred language?')" "$(eval_gettext 'Language')" "eng: $(eval_gettext 'English')-ger: $(eval_gettext 'German')-fra: $(eval_gettext 'French')-esp: $(eval_gettext 'Spanish')" "-"
SELECTED_LANGUAGE=$(cut -d ':' -f 1 <<< "$APP_ANSWER")

POL_Call POL_GoG_setup "$GOGID" "af0d54ef825b974fe4207e817f857bd9"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

if [ "$SELECTED_LANGUAGE" != "eng" ]
then
    mv "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 1/data/gamedata.bnd" "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 1/data/eng-gamedata.bnd"
    mv "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 2/data/gamedata.bnd" "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 2/data/eng-gamedata.bnd"
    cp "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 1/data/$SELECTED_LANGUAGE-gamedata.bnd" "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 1/data/gamedata.bnd"
    cp "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 2/data/$SELECTED_LANGUAGE-gamedata.bnd" "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 2/data/gamedata.bnd"
fi

POL_Shortcut "$PROGRAMFILES/GOG.com/Neighbours From Hell Compilation/Neighbours From Hell 1/bin/game.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;AdventureGame;"
POL_Shortcut "$PROGRAMFILES/GOG.com/Neighbours From Hell Compilation/Neighbours From Hell 2/bin/game.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 1/manual.pdf"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Neighbours From Hell Compilation/Neighbours From Hell 2/manual.pdf"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlIH+UUACgkQ5TH6yaoTykc/8gCdGunGIEU2WVIGUONVSc/i1Lnf
Mt4An3tkBhvXF2kHKExIQ1qORz4+Co8J
=XNlJ
-----END PGP SIGNATURE-----
