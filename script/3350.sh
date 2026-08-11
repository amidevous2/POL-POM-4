#!/usr/bin/env playonlinux-bash
# -*- mode: sh -*-
# Date : (2009-06-07 15-40)
# Last revision : (2019-08-17 11-52)
# Wine version used : 3.21-staging
# Distribution used to test : Fedora 13 & Debian 10 Buster x86_64
# Author : Quentin PÂRIS et Alexandre BEAUGY
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

AUTHOR="Quentin PÂRIS et Alexandre BEAUGY"
EDITOR="Blizzard Entertainment Inc."
GAME_URL="http://us.battle.net/en"
TITLE="Warcraft III - Reign of Chaos + The Frozen Throne (Battle.net Edition)"
PREFIX="WarcraftIII"
WORKING_WINE_VERSION="3.21-staging"

# Initialisation
POL_SetupWindow_Init
POL_Debug_Init
POL_System_SetArch "x86" # Force default value, in case it changes one day...

# Presentation
POL_SetupWindow_presentation "${TITLE}" "${EDITOR}" "${GAME_URL}" "${AUTHOR}" "${PREFIX}"

# 
POL_System_TmpCreate "${PREFIX}"
cd "${POL_System_TmpDir}"

# Warcraft III now has a unique installer for both extensions (ROC+TFT)
# with language selection at start
# Automatic POL download:
POL_Download "https://www.battle.net/download/getInstallerForGame?os=win&locale=frFR&version=LIVE&gameProgram=WARCRAFT_3" #""
SetupIs="${POL_System_TmpDir}/Warcraft-III-Setup.exe"
mv "${POL_System_TmpDir}/getInstallerForGame?os=win&locale=frFR&version=LIVE&gameProgram=WARCRAFT_3" "${SetupIs}"
if [ x${SetupIs} = x ] ; then
  # Or, manual download from:
  # (your blizzard.com) User Account > Games > Downloads > Classical Games
  # > Warcraft® III: The Frozen Throne®
  POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "${TITLE}" "Warcraft-III-Setup.exe"
  SetupIs="${APP_ANSWER}"
fi
[ x${SetupIs} = x ] && exit 0

# Disable Mono installing dialogue
export WINEDLLOVERRIDES="mscoree,mshtml="

# Select prefix
POL_Wine_SelectPrefix "${PREFIX}"
POL_Wine_PrefixCreate "${WORKING_WINE_VERSION}"

# Disable Mono installing dialogue
POL_Wine_OverrideDLL "disabled" "mscoree"
POL_Wine_OverrideDLL "disabled" "mshtml"

# Install
[ "${POL_OS}" = "Mac" ] && Set_Managed Off
Set_OS "winxp" "sp3" # Force default value, in case it changes one day...
POL_Wine_WaitBefore "${TITLE}"
POL_Wine "${SetupIs}"
POL_Wine_WaitExit "${TITLE}"

POL_SetupWindow_VMS
POL_System_TmpDelete

POL_Shortcut "$PROGRAMFILES/Warcraft III/x86/Warcraft III.exe" "${TITLE}" "" "-d3d9"
POL_Shortcut_QuietDebug "${TITLE}"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNVOgAKCRDlMfrJqhPK
R3sAAKCQWQJqF1fckEzIlM5pC77/TMA0XwCcDtuGSPYWjZfTvNdm8vbdEULPQZA=
=5FRl
-----END PGP SIGNATURE-----
