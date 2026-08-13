#!/bin/bash
# Date : (2015-08-05)
# Last revision : see changelog
# Wine version used : see changelog
# Distribution used to test : Xubuntu 18.04 amd64 (kernel 5.4.0)
# Author : mimi89999
# Licence : GPLv3
#
# CHANGELOG
# [mimi89999] (2015-08-05)
#   Initial writting.
# [Dadu042] (2019-06-20)
#   Wine 1.7.48 -> 2.22 because I saw many strange visual issues this year with POL + Wine 1.x scripts.
# [Dadu042] (2020-02-17 22:17)
#   Wine 2.22 -> 4.0.3 (seems to fix the logging issue).
#   Improve POL_Shortcut
#   OS winxp -> win7
# [Dadu042] (2020-08-28 10:00)  (with iTunes v12.10.8.5)
#   Wine 4.0.3 -> 4.0.4
#   Add a warning about missing "ntlm_auth" (located in "winbind" package).

# KNOWN ISSUES:
#   Wine x86 4.0.4, 5.0.2, 5.9, 5.12 + iTunes v12.10.8.5): black coverage/background
#     Described at: https://www.playonlinux.com/en/topic-16444-Itunes_12__black_coverage_and_cannot_start.html
#     Tried: D3D11, DXVK_171, dwrite native.

TITLE="iTunes 12"
PREFIX="iTunes12"
WINEVERSION="4.0.4"
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
POL_SetupWindow_Init
  
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Apple" "https://www.apple.com/itunes/" "mimi89999" "$PREFIX"
POL_SetupWindow_message "$(eval_gettext 'Syncing with iDevices does not work! Are you sure you want to install iTunes?')" "$TITLE"
POL_SetupWindow_message "$(eval_gettext 'You need the 32-bit installer. You can download it from there: "https://www.apple.com/itunes/affiliates/download/"')" "$TITLE"

check_one "ntlm_auth" "winbind"
POL_SetupWindow_missing

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "win7"
  
POL_Call POL_Install_gdiplus
  
POL_SetupWindow_browse "$(eval_gettext 'Please select the 32-bit iTunes installer.')" "$TITLE"
INSTALLER="$APP_ANSWER"
  
cd "$WINEPREFIX/drive_c"
  
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$INSTALLER"
POL_Shortcut "iTunes.exe" "$TITLE" "" "" "AudioVideo;"
POL_Wine_reboot

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX0i64AAKCRDlMfrJqhPK
R3G5AJ0abHSc5F1uUuzLLTYvWWPxoVx/zgCgg+4Zt4Z+4qskojRcIf0yMGoWL00=
=YJ5X
-----END PGP SIGNATURE-----
