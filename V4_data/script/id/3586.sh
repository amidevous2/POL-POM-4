#!/usr/bin/env playonlinux-bash
# -*- mode: sh -*-

# CHANGELOG
# [Alexandre BEAUGY] (2019-08-13 10-50)
#   Initial revision
# [Alexandre BEAUGY] (2019-09-08 08-17)
#   Added capability to install latest known patch
#   Upgraded to latest wine-2.x

# Date : (2017-10-21 14-23)
# Last revision : (2019-09-08 10-49)
# Wine version used : 2.22
# Distribution used to test : Debian 10 Buster x86_64
# Game Version : 1.01.346
# Author : Alexandre BEAUGY
# Licence : GPLv3
# PlayOnLinux: 4.3.4

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

AUTHOR="Alexandre BEAUGY"
EDITOR="cdv Software Entertainment"
#GAME_URL=""
TITLE="Glory of the Roman Empire"
PREFIX="Glory_of_the_Roman_Empire"
WORKING_WINE_VERSION="2.22"
DEFAULT_CDROM="/media/cdrom"
DEFAULT_PATCH="glory_of_the_roman_empire_patch_v1.01.346_europe_25273.exe"
DEFAULT_SETUP="Setup.1"

# Initialisation
POL_SetupWindow_Init
POL_Debug_Init
POL_System_SetArch "x86" # Force default value, in case it changes one day...

# Presentation
POL_SetupWindow_presentation "${TITLE}" "${EDITOR}" "${GAME_URL}" "${AUTHOR}" "${PREFIX}"

# Create prefix
POL_Wine_SelectPrefix "${PREFIX}"
POL_Wine_PrefixCreate "${WORKING_WINE_VERSION}"

# Dependencies
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma
POL_Call POL_Install_d3dx9
POL_Call POL_Install_msxml3

# Select installer's location: LOCAL or CD 
setup_file="${POL_SELECTED_FILE}"
if [ x${setup_file} = x ] ; then
  POL_SetupWindow_InstallMethod "LOCAL,CD"
  case "$INSTALL_METHOD" in
    "CD" )
      POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "Sorry, $APPLICATION_TITLE 4.0+ is required to install $TITLE from CD-ROM"
      setup_file=${DEFAULT_CDROM}/${DEFAULT_SETUP}
      if [ ! -f ${setup_file} ] ; then
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "${DEFAULT_SETUP}"
	setup_file="$CDROM_SETUP"
      fi
      ;;
    "LOCAL" )
      POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
      setup_file="$APP_ANSWER"
      ;;
  esac
fi

[ "${setup_file}" = "" ] && exit 2

# Configuration
Set_OS "winxp" "sp3" # Force default value, in case it changes one day...

# Game's initial install
POL_Wine_WaitBefore "${TITLE}"
POL_Wine "${setup_file}"
POL_Wine_WaitExit "${TITLE}"

POL_SetupWindow_VMS "256"

# Select (latest) patch to install
POL_SetupWindow_browse "$(eval_gettext 'Please select the (latest) patch file to run')" "${TITLE}" "${DEFAULT_PATCH}"
setup_file="${APP_ANSWER}"

# Game's (latest) patch install
POL_Wine_WaitBefore "${TITLE}"
POL_Wine "${setup_file}"
POL_Wine_WaitExit "${TITLE}"

# Create Shortcut
POL_Shortcut "Glory.exe" "$TITLE"

# Reboot windows
POL_Wine_reboot

POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDoSQAKCRDlMfrJqhPK
RyMZAJ9EFV7JQZ7d1jodVPGsMu6K/a5khgCaAqx1m3tqx8vj+Aoc06zqJGenjZI=
=fQhl
-----END PGP SIGNATURE-----
