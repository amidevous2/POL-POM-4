#!/bin/bash
# Date : (2013-10-31 21-16)
# Last revision : (2013-10-31 21-26)
# Author : petch
# Only For : http://www.playonlinux.com

# Just to be on the safe side
[ -n "$WINEPREFIX" ] || POL_Debug_Fatal "POL_Function_CentralizedUserDirs: Variable WINEPREFIX not set!"

local CENTRALIZED_USERDIRS="$(POL_Config_Read CENTRALIZED_USERDIRS)"
 
if [ -z "$CENTRALIZED_USERDIRS" -o ! -d "$CENTRALIZED_USERDIRS" ]; then
        POL_SetupWindow_textbox "$(eval_gettext 'In what directory do you want to redirect user directories?')" "$TITLE" "$HOME/$APPLICATION_TITLE's user directories"
        CENTRALIZED_USERDIRS="$APP_ANSWER"
	mkdir -p "$CENTRALIZED_USERDIRS" || POL_Debug_Fatal "Could not create the directory"
        POL_Config_Write CENTRALIZED_USERDIRS "$CENTRALIZED_USERDIRS"
fi

find "$WINEPREFIX/drive_c/" -type l -exec sh -c 'echo "fixing {}"; rm "{}"; ln -s "'"$CENTRALIZED_USERDIRS"'" "{}"' \;


cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJyvUAACgkQ5TH6yaoTykc2bACgk90z6hWeo0VsHEuKe2nuOFmd
Q00AoKHJKcrhImOduCLXHkjChNe+NlhC
=xD1C
-----END PGP SIGNATURE-----
