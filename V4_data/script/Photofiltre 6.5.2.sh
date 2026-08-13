#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#Initialisation
TITLE="Photofiltre 6.5.2"
POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Antonio Da Cruz" "http://photofiltre.free.fr" "Styx - http://www.styxonweb.fr.nf" "photofiltre"

#Creation du prefixe
POL_Wine_SelectPrefix "photofiltre"
POL_Wine_PrefixCreate "3.0.4"
POL_Call POL_Install_LunaTheme

if [ "$POL_SELECTED_FILE" ]; then
	SetupFile="$POL_SELECTED_FILE"
else
	POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
	if [ "$INSTALL_METHOD" = "LOCAL" ]; then
		cd "$HOME"
		POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
		SetupFile="$APP_ANSWER"
	fi
	if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
		cd "$POL_USER_ROOT/tmp"
		POL_Download "http://photofiltre.free.fr/utils/pf-setup-fr-652.exe" "7f58fcc440c424ca85cc601bb01fbff5"
		SetupFile="$PWD/pf-setup-fr-652.exe"
	fi
fi
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupFile"

#Creation du racourcie
POL_Shortcut "PhotoFiltre.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlwhROIACgkQ5TH6yaoTykd9KQCffMNvdQPLpTdXnnhcl1Jj4B1O
PzoAn3Q9mhZT+AkKVq/RGTP8hq+B6N21
=Bl8k
-----END PGP SIGNATURE-----
