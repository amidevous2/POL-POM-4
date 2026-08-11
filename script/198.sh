#!/bin/bash

# CHANGELOG
# [Quentin PÂRIS] (2012-06-28 ??-??)
#   POLv4 compatibility
# [SuperPlumus] (2013-09-11 20-14)
#   Clean code
#   Remove Set_SoundDriver oss
# [Dadu042] (2019-10-30)
#   Wine 1.4 -> 2.22 (not tested)


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Last Chaos"
PREFIX="LastChaos"
WORKING_WINE_VERSION="2.22"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Aeria Games" "http://lastchaos.aeriagames.com/" "Zoloom" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86" # amd64 is untested
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

#Set_SoundDriver "oss"
Set_OS "winxp"

POL_Shortcut "LC.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbm9zwAKCRDlMfrJqhPK
R1yyAJ99NdvgC4u9gmwbwXJedas8JmaAvgCglm0yJxjwE1HexyGuhyu1/QgXj4k=
=iYoi
-----END PGP SIGNATURE-----
