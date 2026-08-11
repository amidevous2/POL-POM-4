#!/bin/bash
# Date : (2012-05-11 13-22)
# Last revision : (2012-10-29 02-22)
# Wine version used : N/A
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

INSTALLBIN="widescreen-v3.05.zip"

TITLE="Infinity Engine widescreen mod"
URL="http://www.gibberlings3.net/widescreen/"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1181
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "The Gibberlings" "$URL" "Pierre Etchemaite" "$PREFIX"

POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"

PREFIXFOUND=''
UNPATCHEDFOUND=''
DOWNLOADED=''

download_mod () {
    [ -n "$DOWNLOADED" ] && return
    cd "$POL_USER_ROOT/tmp"
    POL_Download 'http://files.playonlinux.com/widescreen-v3.05.zip' "99cee5d4a56d8b470e725aa231f35716"
    DOWNLOADED=1
}


check_install () {
    local PREFIX="$1"
    local EXE="$2"
    local SHORTCUT_NAME="$3"
    local TITLE="Widescreen mod: $SHORTCUT_NAME"

    [ "$(POL_Wine_PrefixExists $PREFIX)" = "True" ] || return

    POL_Wine_SelectPrefix "$PREFIX"
    local DRIVEC="$WINEPREFIX/drive_c"
    DIR="$(find $DRIVEC -iname $EXE -print|head -n 1)"
    [ -n "$DIR" ] && DIR="$(dirname "$DIR")"
    if [ -z "$DIR" -o ! -d "$DIR" ]; then
        POL_Debug_Error "$(eval_gettext 'Could not find executable $EXE in virtual disk $PREFIX')"
        return
    fi

    PREFIXFOUND=1
    [ -d "$DIR/widescreen" ] && return

    UNPATCHEDFOUND=1
    POL_SetupWindow_question "Patch $SHORTCUT_NAME?" "$TITLE"
    [ "$APP_ANSWER" = "TRUE" ] || return

    download_mod
    unzip "$POL_USER_ROOT/tmp/$INSTALLBIN" -d "$DIR/" || POL_Debug_Fatal "$(eval_gettext 'Error while installing archive')"

    CONFIGURATOR_EXTENSION="$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME.widescreen"
    cat <<-_EOF_ > "$CONFIGURATOR_EXTENSION"
	#!/bin/bash
	cd "$DIR" || exit 1

	if [ -e setup-widescreen.exe ]; then
	    POL_SetupWindow_question "\$(eval_gettext 'Run widescreen setup?')" "\$TITLE"
	    if [ "\$APP_ANSWER" = "TRUE" ]; then

	        POL_Wine_WaitBefore "\$TITLE"

	        POL_Wine wineconsole setup-widescreen.exe
	    fi
	fi
	_EOF_

    source "$CONFIGURATOR_EXTENSION"
}

# check_install PREFIX EXE SHORTCUT_NAME
check_install "BaldursGate1_gog" "Baldur.exe" "Baldur's Gate"
check_install "BaldursGate2_gog" "BGMain.exe" "Baldur's Gate II"
check_install "IcewindDale_gog" "IDMain.exe" "Icewind Dale"
check_install "IcewindDale2_gog" "IWD2.exe" "Icewind Dale II"
check_install "PlanescapeTorment_gog" "Torment.exe" "Planescape: Torment"

# FIXME add more Infinity Engine games here
# Potentially supported:
# * Baldur's Gate with the Tales of the Sword Coast expansion pack,
# * Baldur's Gate II: Shadows of Amn with or without the Throne of Bhaal expansion pack,
# * Icewind Dale with the Heart of Winter & Trials of the Loremaster expansion pack,
# * Icewind Dale II
# * Planescape: Torment

# In return, their configurators should contain code:
# ----------------
# POL_Call POL_Configurator_runparts
# ----------------
# in a place where SetupWindow and Debug are already initialized

if [ -z "$PREFIXFOUND" ]; then
    POL_SetupWindow_message "$(eval_gettext 'No supported Infinity Engine game found.')" "$TITLE"
elif [ -z "$UNPATCHEDFOUND" ]; then
    POL_SetupWindow_message "$(eval_gettext 'All supported Infinity Engine games already patched.\nTo modify the screen resolution of a shortcut, use its configurator.')" "$TITLE"
fi

POL_SetupWindow_Close

exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlCNEdQACgkQ5TH6yaoTykeRJgCfRdKxZNsgkW/s67y51pxAOKBk
+BwAnjEWpZICvdUZDtxdFRd60DKJgspq
=xvKK
-----END PGP SIGNATURE-----
