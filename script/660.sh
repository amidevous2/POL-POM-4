#!/bin/bash
#Creator : GNU_Raziel
# Accepted by Tinou

COMMAND="$*"

if [ "$COMMAND" == "" ]; then
	POL_SetupWindow_message "$(eval_gettext 'No root command specified, abording installation.')" "$TITLE"
	exit 0
else	
	# Setting warning
	if [ "$POL_OS" == "Linux" ]; then
		WARNING_NOTE="$(eval_gettext 'PlayOnLinux/PlayOnMac philosophy is to never ask super-user password, however, for this script, it s mandatory. So, we give you the command you must type yourself for this installation to go on :')"
	else
cat << EOF > "$POL_USER_ROOT/tmp/note.bash"
#!/bin/bash
echo "$(eval_gettext 'PlayOnLinux/PlayOnMac philosophy is to never ask super-user password, however, for this script, it s mandatory. So, we give you the command you must type yourself for this installation to go on :')"
echo "$COMMAND"
bash
EOF
		chmod +x  "$POL_USER_ROOT/tmp/note.bash"
	fi

	# Displaying command
	[ "$POL_OS" == "Mac" ] && xterm -e "$POL_USER_ROOT/tmp/note.bash"
	[ "$POL_OS" == "Linux" ] && xterm -e "echo \"$WARNING_NOTE\"; echo \"$COMMAND\"; bash"
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk5X09gACgkQ5TH6yaoTykcVDgCgmED87KFS1+EIoYUfBlMLqU1w
c44AoJiOr55SoxSrvYUoDRioEHwbob6q
=nk8J
-----END PGP SIGNATURE-----
