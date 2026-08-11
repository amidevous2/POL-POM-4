CDNumber="$1"
Letter="$2"

shift
shift

if [ "$CDNumber" = "1" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Please insert the first disc')" "$TITLE"

	POL_SetupWindow_cdrom
	
	POL_SetupWindow_cdrom_MountPC "$@"
	POL_SetupWindow_check_cdrom "$@"
	POL_SetupWindow_message "$(eval_gettext 'Read this carefully!\n\nWhen the $TITLE installer ask you to change your cdrom, please come back to this $APPLICATION_TITLE window')" "$TITLE"
	POL_Call POL_Wine_LinkCDROM "$Letter"

else
	POL_SetupWindow_message "$(eval_gettext 'When the installer ask you to insert the cdrom number $CDNumber, click next.\n\nDo not click next before!')" "$TITLE"

	POL_Wine --ignore-errors eject
	POL_SetupWindow_message "$(eval_gettext 'Now, insert the cdrom number $CDNumber.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_cdrom_MountPC "$@"
	POL_SetupWindow_check_cdrom "$@"
	
	POL_Call POL_Wine_LinkCDROM "$LETTER"
	POL_SetupWindow_wait "$(eval_gettext 'Now you can go back to the $TITLE installation window to continue')" "$TITLE"
	sleep 10
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlBB1eAACgkQ5TH6yaoTykcmSACeL3+wTUvpTJjqOFvn/cfZXHkB
K3wAn3zqcZANvdZ7gyBo6eCiSp3ZBS4Y
=bVlR
-----END PGP SIGNATURE-----
