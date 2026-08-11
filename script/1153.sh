#!/bin/bash
# Date : (2012-04-29 21-51)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-04-29 21-51)
#   Initial script.
# [Zachary_Foxx] (2019-08-13)
#   Wine 1.6.1 -> 1.9.4
# [Dadu042] (2020-01-20 11:30)
#   Wine 1.9.4 -> 2.22

# Pixel corruption in one background sky with Pixel Shaders enabled?

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="guilty_gear_x2_reload"
PREFIX="GuiltyGearX2_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Guilty Gear X2 Reload"
SHORTCUT_NAME="Guilty Gear X2 #Reload"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1153
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Arc System Works Co. / Funbox Media" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "1f842d29e34f12faa8ff9efe31fd523c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Call POL_Install_devenum
POL_Call POL_Install_quartz

# If I don't do that videos are black (?)
POL_Wine regsvr32 quartz.dll

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "launcher.exe" "$SHORTCUT_NAME" "Guilty Gear X2 Reload.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Guilty Gear X2 Reload/manual.pdf"
# C:\GOG Games\Guilty Gear X2 Reload/README.TXT

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

POL_LoadVar_PROGRAMFILES

cd "$GOGROOT/Guilty Gear X2 Reload/" || exit 1

TITLE="$TITLE"

POL_Wine --ignore-errors config.exe

exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiWA2AAKCRDlMfrJqhPK
Rxn/AKCzMOKOe+IXZtAux2wFfgYp0rpCGQCfQiWG8v3+vYsuhejfDvCqJym5VOI=
=9eJx
-----END PGP SIGNATURE-----
