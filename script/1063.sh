#!/bin/bash
# Date : (2012-01-15 23-29)
# Last revision : see changelog
# Wine version used : 1.5.22, 1.6.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [VisitntX] (2012-01-15 23-29)
#   Initial script.
# [Pierre Etchemaite] (2014-01-04 15-50)
#   Script updated for GOG's installer v2 ?
#   Got a crash with 1.3.37, backoff to 1.3.36; But could be random crashes
#   Use Wine 1.5.22 that fixes flickering flames and smokes
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.6.1 (outdated) -> system (not tested)


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_temple_of_elemental_evil"
PREFIX="TempleElementalEvil_gog"

TITLE="GOG.com - Temple of Elemental Evil"
SHORTCUT_NAME="Temple of Elemental Evil"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1063
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Troika Games / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "519c6cb7838b534ab9cc805db24e541e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# According to AppDB it doesn't work without virtual desktop
# I have multiscreen so I can't test without it to confirm it's necessary
Set_Desktop "On" "800" "600"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "ToEE.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Temple of Elemental Evil/Manual.pdf"
# C:\GOG Games\Temple of Elemental Evil\Readme.txt

# Last words
POL_SetupWindow_message "$(eval_gettext 'It is highly recommended to now install the Circle of Eight Modpack\nto fix many issues with this game, and optionally add new content\n(for "NC" modpacks).\nUse the dedicated PlayOnLinux script in patches section.')" "$TITLE"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx4IAAKCRDlMfrJqhPK
R8xRAKCNSkvI2RSpEJDpemEYhXUmJgMG0QCgic6yj6vGFLibzebZ3oeRsUDSkzg=
=P9FT
-----END PGP SIGNATURE-----
