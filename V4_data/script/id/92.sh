#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Druid Soccer"
PREFIX="DruidSoccer"

#Presentation

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Kloonigames" "http://www.kloonigames.com/blog/games/druid/" "Twinoatl" "Druid"

POL_Wine_SelectPrefix "$PREFIX" 
POL_Wine_PrefixCreate "1.4.1"

Set_SoundDriver esd

cd "$WINEPREFIX/drive_c"

#Fixme
POL_SetupWindow_download "Téléchargement du jeu..." "Installation" "http://www.kloonigames.com/download.php?file=druid.zip"

mv download.php druid.zip # compatibilité avec le script de zoloom
unzip druid.zip

POL_Call POL_Install_vcrun6 

POL_Shortcut "druid.exe" "$TITLE"

POL_SetupWindow_Close

exit 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlUq4DoACgkQ5TH6yaoTykcN3gCgo786wmac7YyUAq13ywvTOesk
yq0An3THbpzmYxZH0C6qzqSERpG4J6oY
=CjIp
-----END PGP SIGNATURE-----
