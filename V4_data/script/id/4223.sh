#!/bin/bash
# Date : (2020-09-25)
# Last revision : see the changelog below
# Wine version used : see the changelog below
# Distribution used to test : XUbuntu 18.04 64 bits (Linux kernel v5.4.0). GPU: AMD Vega 11.
# Author : Dadu042
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# TESTED Editions:
#
# Middlewares used by this software : 
#
#
# CHANGELOG
# [Dadu042] (2020-09-25 10-00)
#   Initial script. This is a fake script (redirecting to the Glyph game store).
#
# KNOWN ISSUES :
#  - Wine amd64 5.0.2: X
#
#
# KNOWN ISSUES (FIXED):
#  - Wine amd64 5.0.2: X

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Trove"
PREFIX="Trove"
EDITOR=""
GAME_URL=""
AUTHOR="Dadu042"
STEAM_ID=""
GAME_VMS="512"
SHORTCUT_FILENAME=""
SOFTWARE_CATEGORIES="Game;"
# http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization#Advanced_Standardization
DOCUMENT_FILE=""


# Starting the script
POL_SetupWindow_Init
                         
        
# Open dialogue box 
POL_SetupWindow_message "$(eval_gettext 'Trove does install and work from the editor game store script (Glyph), please use it (this avoid us to have 2 same scripts).')" "$TITLE"


POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCX28ZlAAKCRDlMfrJqhPK
R1RzAJ9pt1H9NQBENWItDpMlnXwQ91tnFgCfY7cmKiPKofA81DZgwBzBrRu/Czw=
=tXow
-----END PGP SIGNATURE-----
