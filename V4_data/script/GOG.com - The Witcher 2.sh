#!/bin/bash
# Created: 2014-08-20
# Revised: see changelog
# WINE versions: 1.7.4-CSMT 1.5.31 (NOK), 2.22
# Distro(s): Gentoo 3.14.14
# Author: tylendel
# http://www.playonlinux.com
# Created using GNU_Raziel's Witcher 2 script as general guide

# [tylendel] (2014-08-20)
#   Initial script.
# [Dadu042] (2020-01-22)
#   Wine "1.7.4-CSMT" -> 2.22 (according appdb.winehq.org)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - The Witcher 2"
PREFIX="Witcher2_GOG"
SHORTCUT_GAME="The Witcher 2 : Assassins of Kings"
SHORTCUT_CONF="The Witcher 2 : Assassins of Kings (Configuration)"
PUBLISHER="CDProjekt"
SITE_URL="http://www.thewitcher.com"
AUTHOR="tylendel"
WORKING_WINE_VERSION="2.22"

POL_SetupWindow_Init
# Not sure what this is, nothing in docs
#POL_SetupWindow_SetID 12345

# Debug away
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$PUBLISHER" "$SITE_URL" "$AUTHOR" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"

# Dotnet 4 installer is only for 32 bit, game is 32 bit too
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Need some things
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_d3dx9_36
POL_Call POL_Install_dotnet40

# Browse for gog.com exe file
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup exe. Ensure all data (.bin) files are in the same directory as the exe')" "$TITLE"
SETUP_PROG="$APP_ANSWER"

# Need nogui option here to disable the gog setup wrapper thing
# which errors and freezes during setup
# This does not disable the setup's gui though
POL_Wine start /unix "$SETUP_PROG" /nogui
POL_Wine_WaitExit "$TITLE"

# TODO: get the icon graphics to actually work
POL_Shortcut "witcher2.exe" "$SHORTCUT_GAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut "Configurator.exe" "$SHORTCUT_CONF" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"

# All done
POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhTcbwAKCRDlMfrJqhPK
R+lBAJ44vv0ZEjgqe2cLVfmlLuSGf1/JQwCfRUeF/77DctyzPA7znWloVqUh4ek=
=Bipm
-----END PGP SIGNATURE-----
