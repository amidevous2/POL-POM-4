#!/bin/bash
# Date : (2020-10-25 10:00)
# Last revision : 
# Wine version used : see script
# Distribution used to test : Xubuntu 20.04 64bits
# Author : Dadu042
# Script licence : GPL v.3
# Only for : http://www.playonlinux.com

# TESTED Editions: Game v1.0.0 or v1.0.1 .
#
# Middlewares used by this software : .
#
# CHANGELOG
# [Dadu042] (2020-10-25 10:00)
#   Initial script (source script: 'Anno 1701 Patch 1.02' and 'GOG.com - Heroes of Might and Magic 3 HD mod').
# [timbuntu] (2020-10-27 10:00)
#   Check if game files have been downloaded.
# [Dadu042] (2020-11-13 10:00)
#   Update patch for game v1.1.0, however reported to not allow to pass 'doors'.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE_REQUIRED="Genshin Impact: patch for Play button"
PREFIX="Genshin_Impact"

POL_SetupWindow_Init
POL_SetupWindow_free_presentation "$TITLE" "This patch will modify your installed game.\nTested with game versions v1.0.0 and v1.0.1, however next game's updates might break this patch."

  
if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit 1
fi


POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_AutoSetVersionEnv
POL_LoadVar_PROGRAMFILES

if [ -e "$WINEPREFIX/drive_c/Program Files/Genshin Impact/Genshin Impact Game/UnityPlayer.dll" ]; then
    cd "$WINEPREFIX/drive_c/Program Files/Genshin Impact/Genshin Impact Game"

    cp UnityPlayer.dll UnityPlayer.bak

# Works partially (until doors) with game v1.1.0 (2020-11-11)
dd if=<(echo -ne "\xc3") of=UnityPlayer.dll bs=1 seek=$((0x014CDDB0)) conv=notrunc
dd if=<(echo -ne "\xc3") of=UnityPlayer.dll bs=1 seek=$((0x014CE400)) conv=notrunc
dd if=<(echo -ne "\x31\xd2") of=UnityPlayer.dll bs=1 seek=$((0x01CA75C3)) conv=notrunc

# Worked (for some days) with game v1.0.0 (2020-10)
#    dd if=<(echo -ne "\xc3") of=UnityPlayer.dll bs=1 seek=$((0x0148BDD0)) conv=notrunc
#    dd if=<(echo -ne "\xc3\xf5") of=UnityPlayer.dll bs=1 seek=$((0x0148C420)) conv=notrunc
#    dd if=<(echo -ne "\x31\xed") of=UnityPlayer.dll bs=1 seek=$((0x01B30933)) conv=notrunc

    POL_SetupWindow_message "$(eval_gettext 'Patch is finished.')" "$TITLE"
else
    POL_SetupWindow_message "$(eval_gettext 'Could not find UnityPlayer.dll.\nMake sure you download the game files through the launcher before applying this patch.')" "$TITLE"
fi

POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX660uwAKCRDlMfrJqhPK
R9aqAJ9m8ScXwHB4HJUb77AZ70J70sEGaACdG5B90mWMf6dAdioNEfNH6+erFXo=
=6rSH
-----END PGP SIGNATURE-----
