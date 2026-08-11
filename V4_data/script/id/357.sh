#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Graph"
PREFIX="Graph"

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "" "" "Quentin PÂRIS" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

cd "$WINEPREFIX/drive_c"

POL_Download "$SITE/divers/SetupGraphBeta-4.4.0.415.exe" "fa4dc1876fcff8ebcde3aad185448d11"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "SetupGraphBeta-4.4.0.415.exe" /silent

POL_Shortcut "Graph.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+ut78ACgkQ5TH6yaoTykdezwCffhIUgtkhG9xPa0h2BA9ZnqyF
Xp8An29gj5yBzMW63d7uesHkEu1Hd8uA
=TpIu
-----END PGP SIGNATURE-----
