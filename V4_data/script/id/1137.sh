#!/bin/bash
# Date : (2012-04-21 16-25)
# Last revision : (2013-04-01 15-08)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Freeware
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Must match adventrising-gog script values
TITLE_REQUIRED="Advent Rising (GoG release)"
PREFIX="AdventRising_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Advent Rising: Advent Revising patch"
DOWNLOAD_URL="http://www.miketyndall.com/setz/Advent%20Revising/"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1137
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Setz" "$DOWNLOAD_URL" "Pierre Etchemaite" "$PREFIX"

if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
    POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')" "$TITLE"
    POL_SetupWindow_Close
    exit 1
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_AutoSetVersionEnv
POL_LoadVar_PROGRAMFILES

if [ -n "$POL_SELECTED_FILE" ]; then
    ARCHIVE="$POL_SELECTED_FILE"
else
    POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
    if [ "$INSTALL_METHOD" = "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "RAR archives (*.rar)|*.rar;*.RAR"
        ARCHIVE="$APP_ANSWER"
    fi

    if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
        cd "$POL_USER_ROOT/tmp"
        LITE_DESC="$(eval_gettext 'Lite (702MB), fix major issues (18 cutscenes)')"
        FULL_DESC="$(eval_gettext 'Full (1.5GB), fix even minor issues (49 cutscenes)')"
        POL_SetupWindow_menu "$(eval_gettext 'Which version do you want to install?')" "$TITLE" "${LITE_DESC}~${FULL_DESC}" "~"

        if [ "$APP_ANSWER" = "$LITE_DESC" ]; then
            POL_Download "${DOWNLOAD_URL}AdventRevising%20lite(segmented).part1.rar" "3aec0105b9d8513a7c7ccc6b97c264f7"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20lite(segmented).part2.rar" "c6b9c5a08633ba7720a73c52bdc4f320"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20lite(segmented).part3.rar" "702a02f9503515134281bb85816fed09"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20lite(segmented).part4.rar" "f53b9e6ba241c20191a4b5f231e4172f"
            ARCHIVE="$POL_USER_ROOT/tmp/AdventRevising lite(segmented).part1.rar"
        fi

        if [ "$APP_ANSWER" = "$FULL_DESC" ]; then
            POL_Download "${DOWNLOAD_URL}AdventRevising%20full(segmented).part1.rar" "6922d7d0bcfb1db9f048c45a80a5ba7e"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20full(segmented).part2.rar" "498686c63cbe1774ac86ac95e0570003"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20full(segmented).part3.rar" "905da750ea5c9d2163cccf6adfe42c3f"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20full(segmented).part4.rar" "676869792b8fc19527f3edb3d8ba0aca"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20full(segmented).part5.rar" "33e641a140b7278e0345ae058926abac"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20full(segmented).part6.rar" "642fa8eb3e0d6402453b7035660ade96"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20full(segmented).part7.rar" "6c8fd48fc00f8d432b520aa10ea71b13"
            POL_Download "${DOWNLOAD_URL}AdventRevising%20full(segmented).part8.rar" "bd3fe73f259e021eadb606c6d964ad51"
            ARCHIVE="$POL_USER_ROOT/tmp/AdventRevising full(segmented).part1.rar"
        fi
    fi
fi

POL_Download_Resource "http://files.playonlinux.com/unrar.exe" "eb6033179b6c6427f5f61e4fb3915ff4"


POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/GOG.com/Advent Rising" || POL_Debug_Fatal "Could not find game directory"

TOTAL=$(POL_Wine "$POL_USER_ROOT/ressources/unrar.exe" l -v "$(winepath -w "$ARCHIVE")"|tail -n 2|head -n 1|awk '{ print $1 }')
FILES=0

POL_SetupWindow_pulsebar "$(eval_gettext 'Decompressing archive...')" "$TITLE"

POL_Wine "$POL_USER_ROOT/ressources/unrar.exe" x -v -o+ "$(winepath -w "$ARCHIVE")" | \
while read line; do
  case "$line" in
      "Extracting  "*)
          let FILES++
          line="${line%%   *}"
          POL_SetupWindow_set_text "${line//\\//}"
          POL_SetupWindow_pulse $((100 * FILES / TOTAL))
          ;;
  esac
done

[ $? = 0 ] || POL_Debug_Fatal "$(eval_gettext 'Error while installing archive')"

POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_message "$(eval_gettext 'Advent Revising patch has been installed;\nDont forget to leave some email to Setz for his work.')" "$TITLE"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlFZkWAACgkQ5TH6yaoTykea5wCdEHDRnXQduoY677xH6jWeqQcJ
SLgAoJydxKI2kQDNXQ06Yqs6JB++NIMC
=7Mcn
-----END PGP SIGNATURE-----
