#!/bin/bash
# Date : (2012-05-31 20-09)
# Last revision : (2014-02-02 21-18)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-31 20-09)
#   First script. 
# [?]  (2014-02-02 21-18)
#   ?
# [Dadu042] (2020-04-30)
#   Wine 1.6.2 -> system (Wine is at least v3.0 noawadays)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="gothic_2_gold_edition"
PREFIX="Gothic2_gog"

TITLE="GOG.com - Gothic 2 Gold"
SHORTCUT_NAME="Gothic 2 Gold"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1239
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Piranha Bytes / Nordic Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" "1" "b8daf54cf2c80a8e0c80ffb6beadf4b3" "3a27b5b17c14d574b6f78432626d688e" "786c2428c4338bddfdd6e805660ad443"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate 

# fake sdbinst.exe (bug report #2520)
POL_Call POL_Install_nop "$WINEPREFIX/drive_c/windows/system32/sdbinst.exe" 

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Call POL_Install_directmusic
# vdfs32e.exe often crashes, couldn't find a solution
POL_Call POL_Install_DisableCrashDialog

# Doesn't hurt ;)
POL_Wine_reboot

# extendedMenu allows to set resolution ingame
# tip from http://www.gog.com/forum/gothic_series/notes_on_widescreen_resolution
cat <<_EOFFUNC_ > "$GOGROOT/Gothic 2 Gold/gothic2_funcs"

# echo statements to set \$zVidResFullscreenX, \$zVidResFullscreenY and \$zVidResFullscreenBPP
read_g2_settings () {
  [ -z "\$WINEPREFIX" ] && POL_Debug_Fatal 'read_g2_settings: \$WINEPREFIX must be set'
  perl -ne 'print "\$1\n" if /^((zVidResFullscreenX|zVidResFullscreenY|zVidResFullscreenBPP)=\d+)/' "$GOGROOT/Gothic 2 Gold/system/Gothic.ini"
}

# update Gothic.ini with value of \$zVidResFullscreenX, \$zVidResFullscreenY and \$zVidResFullscreenBPP
write_g2_settings () {
  [ -z "\$WINEPREFIX" ] && POL_Debug_Fatal 'write_g2_settings: \$WINEPREFIX must be set'
  perl -i.bak -pe 's/^zVidResFullscreenX=\d+/zVidResFullscreenX='"\$zVidResFullscreenX"'/;
                   s/^zVidResFullscreenY=\d+/zVidResFullscreenY='"\$zVidResFullscreenY"'/;
                   s/^zVidResFullscreenBPP=\d+/zVidResFullscreenBPP='"\$zVidResFullscreenBPP"'/;
                   s/^extendedMenu=\d+/extendedMenu=1/;' "$GOGROOT/Gothic 2 Gold/system/Gothic.ini"
}

# until POL_LoadVar_ScreenResolution does it?
LoadVar_ScreenDepth () {
  export ScreenBpp=\$(xdpyinfo |perl -ne 'print \$1 if /^bitmap unit, bit order, padding:\s*(\d+)/')
  POL_Debug_Message "Screen depth: \$ScreenBpp"
}

sync_resolutions () {
  LoadVar_ScreenDepth
  eval \$(read_g2_settings)
  [ "\$zVidResFullscreenBPP" != "\$ScreenBpp" ] && zVidResFullscreenBPP="\$ScreenBpp" write_g2_settings
  Set_Desktop "On" "\$zVidResFullscreenX" "\$zVidResFullscreenY"
}

_EOFFUNC_


POL_Shortcut "Gothic2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
# Using $WINEPREFIX here causes trouble, bug #953
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'source "../gothic2_funcs" || exit 0'
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME" 'sync_resolutions'

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Gothic 2 Gold/manual.pdf"
# C:\GOG Games\Gothic 2 Gold\Readme.txt
# C:\GOG Games\Gothic 2 Gold\manual_addon.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqqXpAAKCRDlMfrJqhPK
R4UAAKCdHRKhrzANXVAKlm+qGR1b1tk+dwCeKcmaXmjAUxU0Q7tW2yxZy6Dow7I=
=VibD
-----END PGP SIGNATURE-----
