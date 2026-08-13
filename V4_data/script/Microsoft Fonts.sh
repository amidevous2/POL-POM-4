#!/bin/bash
#made by cendre , 25/10/08
if [ "$PLAYONLINUX" = "" ]
then
exit 0
fi
source "$PLAYONLINUX/lib/sources"
cfg_check

if [ "$POL_LANG" == "fr" ];then 
LNG_NO_FONT="Merci d'installer les polices Microsoft avant d'utiliser ce script."
LNG_FONT="Cette installateur vous aidera à installer les polices Microsoft dans un préfixe."
LNG_CHOOSE="Choisissez le préfixe dans lequel copier les polices Microsoft."
LNG_NAME="Polices Microsoft"
LNG_DONE="Copie des polices terminée."
else
LNG_NO_FONT="Please install Microsoft fonts before using this script."
LNG_FONT="This wizard will help you to install Microsoft fonts in a prefix"
LNG_CHOOSE="Choose a prefix to copy Microsoft fonts."
LNG_NAME="Microsoft fonts"
LNG_DONE="Copy of fonts done."
fi


POL_SetupWindow_Init
POL_SetupWindow_free_presentation "$LNG_NAME" "$LNG_FONT"
POL_SetupWindow_games "$LNG_CHOOSE" "$LNG_NAME"
prefixe=$(detect_wineprefix "$APP_ANSWER")
if [ -d "$prefixe" ]
then
select_prefixe "$prefixe"
fonts_to_prefix
POL_SetupWindow_reboot
POL_SetupWindow_message "$LNG_DONE" "Microsoft Fonts"
fi
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEwACgkQ5TH6yaoTykdT5ACgqtcdCm+NqlaqwWotUCdJ7j6b
b6AAnjVBtHPTqTboXnj7Q6ZgLqV7w28U
=2N3O
-----END PGP SIGNATURE-----
