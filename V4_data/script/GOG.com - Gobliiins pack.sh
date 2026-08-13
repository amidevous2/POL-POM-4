#!/bin/bash
# Date : (2012-08-09 16-43)
# Last revision : (2014-02-22 01-30)
# Wine version used : 1.4-scummvm_support
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="gobliiins_pack"
PREFIX="GobliiinsPack_gog"
WORKING_WINE_VERSION="1.4-scummvm_support"

TITLE="GOG.com - Gobliiins pack"
SHORTCUT_NAME1="Gobliiins 1"
SHORTCUT_NAME2="Gobliins 2 - Prince Buffoon"
SHORTCUT_NAME3="Goblins Quest 3"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1354
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Coktel Vision / DotEmu" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "1b3425388ea9a3c05596045bec57a3d4"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


cat <<'_EOFCFG_' > "$GOGROOT/Gobliiins Pack/Gobliiins/goblins1.polcfg"
[Gobliiins1]
description=Gobliiins CD (v1.02/DOS/English (US))
platform=pc
gameid=gob
language=us
path=C:\GOG Games\Gobliiins Pack\Gobliiins1\
guioptions=sndNoSubs sndNoSpeech launchNoLoad
savepath=C:\GOG Games\Gobliiins Pack\Gobliiins1\
_EOFCFG_

cat <<'_EOFCFG_' > "$GOGROOT/Gobliiins Pack/Gobliins 2/goblins2.polcfg"
[gobliins2]
description=Gobliins 2 CD (v1.02/DOS/English)
platform=pc
gameid=gob
language=en
path=C:\GOG Games\Gobliiins Pack\Gobliins2\
savepath=C:\GOG Games\Gobliiins Pack\Gobliins2\
_EOFCFG_

cat <<'_EOFCFG_' > "$GOGROOT/Gobliiins Pack/Goblins 3/goblins3.polcfg"
[Goblins3]
description=Goblins Quest 3 CD (v1.02/DOS/English)
platform=pc
gameid=gob
language=en
path=C:\GOG Games\Gobliiins Pack\Goblins3\
guioptions=sndNoSubs sndNoSpeech launchNoLoad
savepath=C:\GOG Games\Gobliiins Pack\Goblins3\
_EOFCFG_


POL_Shortcut "goblins1.polcfg" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;LogicGame;"
POL_Shortcut_Document "$SHORTCUT_NAME1" "$GOGROOT/Gobliiins Pack/Gobliiins/Manual.pdf"

POL_Shortcut "goblins2.polcfg" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;LogicGame;"
POL_Shortcut_Document "$SHORTCUT_NAME2" "$GOGROOT/Gobliiins Pack/Gobliins 2/Manual.pdf"

POL_Shortcut "goblins3.polcfg" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;LogicGame;"
POL_Shortcut_Document "$SHORTCUT_NAME3" "$GOGROOT/Gobliiins Pack/Goblins 3/Manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMH8RcACgkQ5TH6yaoTyke0LwCgl9pw6ligiNaosW2HlM8eS8Ru
6nkAoI2v5Rnb9XSDIanuuiKeHcFQhp/X
=PnTh
-----END PGP SIGNATURE-----
