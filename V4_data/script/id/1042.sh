#!/bin/bash
# Date : (2012-01-20 23-25)
# Last revision : (2013-12-09 23-10)
# Wine version used : 1.3.37, 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="enclave"
PREFIX="Enclave_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Enclave"
SHORTCUT_NAME="Enclave"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1042
# 4.0.15 needed for complex POL_Shortcut_InsertBeforeWine
POL_RequiredVersion "4.0.15" || POL_Debug_Fatal "$APPLICATION_TITLE 4.0.15 is required to install $TITLE"

POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Starbreeze Studios / TopWare Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_System_SetArch "auto"

POL_Call POL_GoG_setup "$GOGID" "c043fb01c784a18febe6332ac5bc08f5"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# fake sdbinst.exe
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/sdbinst.exe" 

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Enclave.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
# Fixes a problem with CPU management on modern computers (specially laptops):
# Enclave doesn't handle variable frequency, so make sure they stay at top frequency
# with a background busy loop (other means are less portable and/or require root privileges)
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'taskset -pc 0 $$'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'nice -19 bash -c "while true; do let i=1; done" &'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'BUSYLOOP_PID=$!'
echo 'kill $BUSYLOOP_PID' >> "$POL_USER_ROOT/shortcuts/$SHORTCUT_NAME"

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Enclave/Manual.pdf"
# C:\GOG Games\Enclave\readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG=""

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Enclave/" || exit 1

TITLE="$TITLE"

POL_SetupWindow_Init

DRIVER="\$(sed -e 's/^VID_RENDER=\([A-Za-z0-9]*\).*/\1/p; d' environment.cfg)"

POL_SetupWindow_menu_list "\$(eval_gettext 'Pick video renderer to use:')" "\$TITLE" "Direct3D8~OpenGL" "~" "\$DRIVER"
NEW_DRIVER="\$APP_ANSWER"

if [ "\$NEW_DRIVER" != "\$DRIVER" ]; then
    sed -i.bak -e 's/^VID_RENDER=[A-Za-z0-9]*/VID_RENDER='"\$NEW_DRIVER"'/' environment.cfg
fi

POL_SetupWindow_Close
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKmTWUACgkQ5TH6yaoTykf34QCgrMFLZDz1FLnf003xvrIgiObR
0OYAoJ6F/ud+ROp7V8YJIDRVQdSkl7BY
=MJhq
-----END PGP SIGNATURE-----
