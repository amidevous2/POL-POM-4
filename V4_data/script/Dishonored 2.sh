#!/usr/bin/env bash
# Date : (2018-12-29)
# Last revision : (2018-12-29)
# Wine version tested : WINE-4.0-rc2-22-g5a8e430b96 (Staging)
# Distribution used to test : Gentoo
# Author : Kreyren, Forked from Ruzven's Dishonored POL script
# Licence : Do what the hug you want i don't give a butterfly, just don't break it because i want to to play dishonored 2 - 2018 Czech republic

# TODO : Can PlayOnLinux work without winetricks?
# TODO : What extension should POL Scripts have?
# TODO : How to test scripts?
# TODO : Allow user to make custom wineprefix or use default
# TODO : Make a function which saved markdown documment in TMP with HW/SW info
# TODO : Fail if invoked from root?
# TODO : Check if system is able to use vulkan?
# TODO : Add install method from Steam using proton / WINE

### CHANGELOG ###
# 2018-12-29 19:19:47 (UTC) - Jacob Hrbek
#     - Initial commit

### MANDATORY
# Dependencies : xact, corefonts, dxvk, steam
# Wine : WINE-3.21 (Staging) ~ WINE-4.0-rc2-22-g5a8e430b96 (Staging)
# GPU Drivers : AMDGPU (Nvidia/Nouveau untested)
# MESA : 18.3.1 - needs testing
# Kernel : 4.18.18-gentoo-r1 In theory anything above 4.14?

### VARIABLES ### 
TITLE="Dishonored 2"
PREFIX="Dishonored-2"
SHORTCUT_NAME="Dishonored-2" # Name of shortcut
EDITOR="Arkane Studios"
# Verify: what is EDITOR
GAME_URL="http://www.dishonored.com/"
AUTHOR="Kreyren, Ruzven"
GAME_VMS="512" 
# TODO: What is GAME_VMS

install_wine () {

WINE_CHECK=$(wine --version); IFS=- read -r _ WINE_VERSION WINE_REVISION _ <<<"$WINE_CHECK"; 

  if [[ -x $(command -v wine) ]] && [[ $WINE_VERSION > 3.21 ]] && [[ $(wine --version | grep '(staging)') == @('(staging)'|'(Staging)') ]]; then # Experiment # TODO: grep 'Staging'
    POL_SetupWindow_message "$(wine --version) detected and is sufficient."
    POL_Wine_SelectPrefix "$PREFIX" # Name of prefix
    POL_Wine_PrefixCreate # Creates WINE prefix
    POL_Wine_SelectPrefix "$PREFIX" # Select WINE prefix

    else
      POL_SetupWindow_message "Wine is not sufficient, using POL WINE."
      POL_Wine_PrefixCreate "3.21-staging"
      POL_Wine_SelectPrefix "$PREFIX" # Name of prefix
      POL_Wine_PrefixCreate # Creates WINE prefix
      POL_Wine_SelectPrefix "$PREFIX" # Select WINE prefix
  fi
}

use_winetricks () {

  POL_Call POL_Install_xact # Required for audio
  POL_Call POL_Install_steam # Dependent on steam
  POL_Call POL_Install_corefonts # In case it's not pulled with steam which depends on corefonts
  POL_Call POL_Install_dxvk # Required for runtime
  Set_OS "win7"

}

if [[ -e /usr/share/playonlinux/lib ]]; then
  PLAYONLINUX='/usr/share/playonlinux/lib'
  source "$PLAYONLINUX/lib/sources"

  POL_SetupWindow_Init # Initiates POL installer window

  # RootCheck
  if [[ $UID == 0 ]]; then
    POL_SetupWindow_message "FATAL: This script needs to be invoked as non-root."
    exit 0
  fi

  # TODO: Ask for PREFIX
  PREFIX="/home/$USER/Games/Dishonored-2"

  POL_Debug_Init # Debug?

  POL_SetupWindow_presentation "49: $TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX" # needs verification

  # Minimum version to have access to Wine 4.x (and Wine > 3.20).
  POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

  POL_SetupWindow_message "
Game is expected to work on platinum excluding DXVK regression which causes freezes in game. 

Please report any other issues on https://www.playonlinux.com/en/app-3443-Dishonored_2.html

Credits: Kreyren, Ruzven
"

  # POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
    # TODO : Add images

  if [[ $(uname -s) == 'Linux' ]]; then
    install_wine
    use_winetricks
    POL_Wine "steam steam://rungameid/403640"
    # TODO: Check Graphics + drivers
  fi

  if [[ $(uname -s) != 'Linux' ]]; then
    POL_SetupWindow_message "FATAL: Script is not optimized for non-linux."
    # TODO: Needs non-linux support.
  fi

  POL_SetupWindow_Close
  exit 0

  else
    echo "FATAL: Directory /usr/share/playonlinux/lib doesn't exist."
    exit 0
 fi

## REFERENCES
# Introduction - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_1:_Getting_to_know_Bash
# Basic Functions - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_2:_Basic_Functions
# Variables - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_3:_Variables
# Conditions - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_4:_Conditions
# Wine - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_5:_Wine
# Filesystem - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_6:_The_Filesystem
# Installation Media - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_7:_Installation_Media
# Real Script - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_8:_My_First_Real_Script
# Standartization - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_9:_Standardization
# Script translation - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_10:_Script_Translation
# List of functions - http://wiki.playonlinux.com/index.php/Scripting_-_Chapter_11:_List_of_Functions
# 

## FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/tree/df9e090b4db5b7a41f72145877cc541b908c319b/lib
# DEBUG FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/debug.lib 
# DEPRECATED FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/deprecated.lib
# DOSBOX FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/dosbox.lib
# POL FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/playonlinux.lib
# PLUGINS FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/plugins.lib
# SCRIPT FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/scripts.lib
# SETUP WINDOW FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/setupwindow.lib
# SOURCES FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/sources
# VARIABLE FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/variables
# WEBSITE FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/website.lib
# WINE FUNCTIONS - https://github.com/PlayOnLinux/POL-POM-4/blob/df9e090b4db5b7a41f72145877cc541b908c319b/lib/wine.lib


-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiG7QAKCRDlMfrJqhPK
R22cAJ4uyyU7s0evKaOWFKXAQqWOc+sozQCfRuecLnQ0SMvoVlzV8KLFNaNHDwE=
=+O0r
-----END PGP SIGNATURE-----
