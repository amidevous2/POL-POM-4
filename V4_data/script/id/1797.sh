#!/bin/bash
# Date : (2013-08-15 14-11)
# Last revision : (2013-12-15 10-47)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-08-15 14-11)
#   Initial script, for the GOG release.
# [Pierre Etchemaite] (2013-12-15 10-47)
#   ?
# [Dadu042] (2020-01-25 12:10)
#   Wine 1.3.27 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="blade_of_darkness"
PREFIX="BladeOfDarkness_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Blade of Darkness"
SHORTCUT_NAME="Blade of Darkness"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1797
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Rebel Act Studios / Codemasters" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "7faa6812f14e6c3f8ceb63244f322fdb"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

POL_Call POL_Install_devenum
POL_Call POL_Install_quartz
POL_Call POL_Install_wmp9

## Default to rOpenGL renderer - not. Several issues
#if type -t POL_unbase64 > /dev/null; then
#	POL_unbase64 <<-'_EOFDAT_' > "$GOGROOT/Blade of Darkness/Config/Blade.config"
#	BwAAAAUAAAABAAAA
#	_EOFDAT_
#fi

# To use rOpenGL on nVidia
# and for lack of POL_Wine_OpenGL
cat << _EOFREG_ >> "$POL_USER_ROOT/tmp/nvidia-opengl.reg"
[HKEY_CURRENT_USER\Software\Wine\OpenGL]
"DisabledExtensions"="GL_KTX_buffer_region"
_EOFREG_
POL_Wine regedit "$POL_USER_ROOT/tmp/nvidia-opengl.reg"
rm "$POL_USER_ROOT/tmp/nvidia-opengl.reg"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Blade.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Blade of Darkness/Blade of Darkness - Manual.pdf"
# C:\GOG Games\Blade of Darkness\Docs\Readme.txt

POL_SetupWindow_Close

cat <<_EOF_ > "$POL_USER_ROOT/configurations/configurators/$SHORTCUT_NAME"
#!/bin/bash
[ -z "\$PLAYONLINUX" ] && exit 0
source "\$PLAYONLINUX/lib/sources"
export WINEPREFIX="\$POL_USER_ROOT/wineprefix/$PREFIX"
export WINEDEBUG="-all"

cd "$GOGROOT/Blade of Darkness/Bin/" || exit 1
TITLE="$TITLE"

POL_Wine nglide_config.exe
exit 0
_EOF_

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwiyQAKCRDlMfrJqhPK
Ryk/AJ9zpqottybHfwcMyX50I0n+0lsTUQCePJKp150yhvwW0T7jd862MiDudmQ=
=mS0E
-----END PGP SIGNATURE-----
