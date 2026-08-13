#!/usr/bin/env playonlinux-bash
# -*- mode: sh -*-

# Date : (2010-01-19 18-00)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian 10 Buster x86_64
# Game Version : N/A.
# Author : SuperPlumus, Quentin PÂRIS et Alexandre BEAUGY
# Licence : GPLv3
# PlayOnLinux: 4.3.4
#
# CHANGELOG
# [SuperPlumus] (2011-12-02 20-58)
#   Conversion v3 -> v4
# [Quentin PÂRIS] (2012-04-28 22-39)
#   Using dosbox instead of wine
# [Quentin PÂRIS] (2012-04-28 23-05)
#   Auto-closing dosbox
# [Quentin PÂRIS] (2012-04-29 17-41)
#   Fix CD-ROM Problems
# [Quentin PÂRIS] (2012-08-08 11-02)
#   Check PlayOnLinux version
# [SuperPlumus] (2013-12-08 18-53)
#   Update gettext messages
# [Alexandre BEAUGY] (2019-09-08 08-17)
#   Convert script from DOS game to Windows game.
#   Upgraded wine version
#   Fixed install process
#   Added MIDI playback capability
# [Dadu042] (2020-02-09 11:50)
#   Ask before to patch the game.
#   Improve POL_Shortcut
#   POL_SetupWindow_VMS "256" -> 64
  
 
[ "${PLAYONLINUX}" = "" ] && exit 0
source "${PLAYONLINUX}/lib/sources"
 
AUTHOR="SuperPlumus, Quentin PÂRIS et Alexandre BEAUGY"
EDITOR="Bullfrog Productions, Ltd."
TITLE="Theme Hospital"
PREFIX="ThemeHospital"
WORKING_WINE_VERSION="2.22"
DEFAULT_CDROM="/media/cdrom"
DEFAULT_SETUP="SETUP.EXE"
DEFAULT_PATCH="THPatch.rar"
 
# Initialisation
POL_SetupWindow_Init
POL_Debug_Init
POL_System_SetArch "x86" # Force default value, in case it changes one day...
 
# Presentation
POL_SetupWindow_presentation "${TITLE}" "${EDITOR}" "${GAME_URL}" "${AUTHOR}" "${PREFIX}"
 
# Create prefix
POL_Wine_SelectPrefix "${PREFIX}"
POL_Wine_PrefixCreate "${WORKING_WINE_VERSION}"
 
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
Set_OS "win98"
Set_Desktop "On" "640" "480"
 
# Game's initial install
POL_Wine_WaitBefore "${TITLE}"
POL_Wine "${setup_file}"
POL_Wine_WaitExit "${TITLE}"
 
POL_SetupWindow_VMS "64"


################
# Patch update #
################
    
POL_SetupWindow_menu "$(eval_gettext 'Do you have a official patch-update to install ?')" "$TITLE" "$(eval_gettext 'Yes')~$(eval_gettext 'No')" "~"     
     
if [ "$APP_ANSWER" == "$(eval_gettext 'Yes')" ]; then

# Select (latest) patch to install
POL_SetupWindow_browse "$(eval_gettext 'Please select the (latest) patch file to run')" "${TITLE}" "${DEFAULT_PATCH}"
setup_file="${APP_ANSWER}"

# Game's (latest) patch install
pushd "${WINEPREFIX}/drive_c/Program Files/Bullfrog/"
cp ${setup_file} .
mkdir THPatch
pushd THPatch >/dev/null
unrar x ../THPatch.rar
file_list=( $(find . -type f) )
popd >/dev/null
pushd Hospital >/dev/null
tar cvf ../THUnpatch.tar ${file_list[*]}
popd >/dev/null
cp -arv THPatch/* Hospital/.
rm -rf THPatch
popd >/dev/null

fi

# Create Shortcut
POL_Shortcut "HOSPITAL.EXE" "$TITLE" "" "" "Game;"
 
# Fix shortcut to allow game play MIDI musics
# [source: https://doc.ubuntu-fr.org/tutoriel/wine_et_midi#creation_d_un_script_pour_lancer_un_programme_avec_timidity]
sed -i -e '/source "$PLAYONLINUX/a timidity -iA -B2,8 -Os -EFreverb=0&' "${POL_USER_ROOT}/shortcuts/$TITLE"
echo "killall timidity" >>"${POL_USER_ROOT}/shortcuts/$TITLE"
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXj/k2wAKCRDlMfrJqhPK
R98oAJ9byJb/DVZzqCq/bdSi3BeuOo9T8QCffP70x94qEsQz3RgES/OhfyMcziU=
=U+MG
-----END PGP SIGNATURE-----
