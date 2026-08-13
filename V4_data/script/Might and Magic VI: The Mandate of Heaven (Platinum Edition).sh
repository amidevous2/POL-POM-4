#!/bin/bash
# Date : (2013-03-06 19-30)
# Last revision : (2013-03-06 19-30)
# Wine version used : 1.4.1
# Distribution used to test : Ubuntu 12.04.01 LTS 64-bit
# Author : horsemanoffaith

# CHANGELOG
# [horsemanoffaith] (2013-03-06 19-30)
#   Initial writting.
# [Dadu042] (2019-11-16)
#   Wine 1.4.1 -> 2.22 (this should help many cases).

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Might and Magic VI: The Mandate of Heaven Platinum Edition"
PREFIX="MM6_MandateOfHeavenPE"
WORKING_WINE_VERSION="2.22"


POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "New World Computing / 3DO / Ubisoft" "http://www.ubi.com" "horsemanoffaith" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "_setup/data1.cab"

cd "$CDROM"
POL_Wine "_setup/Setup.exe"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "MM6.EXE" "$TITLE" "" "" "Game;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNcgwAKCRDlMfrJqhPK
R5A4AJ40PvBDKgSqRpOJDOZZsyqUfyyLkwCeKqkYprsNlESO8NNvAOCqBqDV0Jk=
=Sh3l
-----END PGP SIGNATURE-----
