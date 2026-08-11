#!/bin/bash
# Date                            : (2013-03-12)
# Last revision                    : see changelog
# Wine version used                : system
# Distribution used to test        : Ubuntu 12.04.2 LTS
# Author                        : ntzrmtthihu777
# Testers                        :

# CHANGELOG
# [ntzrmtthihu777] (2013-03-12 22:21)
#   First script. With Wine 1.5.24
# [Dadu042] (2019-12-30)
#   utau0416installer.zip -> utau0418installer.zip

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="UTAU 4.18"
PREFIX="UTAU"
ORIG_LANG="$LANG"    # Stores the original system language
POL_SetupWindow_Init
locale -a | grep -q "ja_JP.utf8" || POL_Debug_Fatal "$(eval_gettext 'ja_JP.utf8 locale must be installed for $TITLE to work.')"
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "?????" "http://utau-synth.com/" "ntzrmtthihu777" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

# Dowloads the installer and installs program properly with a japanese LANG variable
POL_System_TmpCreate "$PREFIX"
cd "$POL_System_TmpDir"
POL_Download "http://utau2008.xrea.jp/utau0418installer.zip" "fd2e74ad2930e96cf98435403b55ce6d"
unzip utau0418installer.zip

# Sets lang to japanese, needed for a proper install
LANG="ja_JP.utf8"
POL_Wine "$POL_System_TmpDir/utau0418inst.exe"
POL_Wine_WaitExit "$TITLE"
rm "$HOME/Desktop/UTAU - ???????.lnk"

# Restores original language.
LANG="$ORIG_LANG"

# Gives the option to enable the english language patch
POL_SetupWindow_question "$(eval_gettext 'Would you like to enable the English GUI Patch?')" "$TITLE"
if [[ "$APP_ANSWER" == "TRUE" ]]
    then mv "$WINEPREFIX/drive_c/$PROGRAMFILES/UTAU/res/ja" "$WINEPREFIX/drive_c/$PROGRAMFILES/UTAU/res/foo"
fi

# Cleans up, creates shortcut
POL_Shortcut "utau.exe" "$TITLE" "" "" "Audio;"
POL_System_TmpDelete
POL_Shortcut_InsertBeforeWine "$TITLE" 'export LANG=ja_JP.utf8'

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgshfAAKCRDlMfrJqhPK
R57pAJ0Yuj7+Pchj50Nd4Z2KzKvKwywG1ACeL7tR+wCiHJpNNcTqfOG6AmH+zz4=
=jy+7
-----END PGP SIGNATURE-----
