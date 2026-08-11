#!/bin/bash
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"

POL_SetupWindow_Init 
POL_SetupWindow_free_presentation "OpenGL Fix" "This app will force a game to run in Window mode to fix OpenGL issues"
POL_SetupWindow_games "Choose an application" "OpenGL Fix"
if [ "$APP_ANSWER" == "" ]
then
POL_SetupWindow_Close
exit
fi
PREFIX=$(detect_wineprefix "$APP_ANSWER")
select_prefix "$PREFIX"

POL_SetupWindow_wait_next_signal "Processing" "OpenGL Fix"
sleep 2
Set_Managed Off
sleep 2
POL_SetupWindow_detect_exit
POL_SetupWindow_Close
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1pPn4ACgkQ5TH6yaoTykcGsQCePD7vgMKAbwMhnahsv3IilYuN
D8sAnja/iBDMpoPHj+Qn/FcoQW8rsXDx
=y5bg
-----END PGP SIGNATURE-----
