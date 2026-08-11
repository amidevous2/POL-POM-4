# 1 : Setup file. If it exists, no need to unhide

if [ "$POL_OS" = "Linux" ]; then
	if [ ! "$CDROM" ]; then
		POL_Debug_Warning "$CDROM is not set" 
	fi
	if [ "$(find "$CDROM" -iwholename "$CDROM/$1")" = "" -a "$CDROM_UNHIDEN" = "TRUE" ]; then

	VALID_DEVNODE=`mount | grep "$CDROM" | awk '{print $1}'`
	VALID_UID=`id -g`

	cat << EOF > "$POL_USER_ROOT/tmp/unhide.txt"
"$(eval_gettext 'To continue, PlayOnLinux needs to umount your CD-ROM previously mounted with unhide option.')"

"$(eval_gettext 'We need to have sudo access on your computer. Therefore, your root password will be asked. Here is the commands PlayOnLinux will run as root:')"

umount "$CDROM"
rmdir "$CDROM"
EOF
	POL_SetupWindow_licence "$(eval_gettext 'Please read carrefully')" "$TITLE" "$POL_USER_ROOT/tmp/unhide.txt"

	# Now, we detect what sudo to use
	if which gksudo; then
		SUDO_COMMAND="gksudo --"
		unset gksudo
	elif which gksu; then
		SUDO_COMMAND="gksu --"
		unset gksu
	elif which kdesu; then
		SUDO_COMMAND="kdesu --"
		unset kdesu
	elif which sudo; then
		SUDO_COMMAND="xterm -e sudo"
		unset sudo
	else
		NOSUDO="TRUE"
	fi

	if [ "$NOSUDO" = "TRUE" ]; then
		POL_SetupWindow_message "Sudo is not installed on your system. Please run the following commands manually as root\n\numount \"$CDROM\"\nrmdir\"$CDROM\"\n\nPress next when it's done"
	else
		$SUDO_COMMAND umount "$CDROM"
		$SUDO_COMMAND rmdir "$CDROM"
	fi

	fi
else # OSX
	if [ "$1" = "--enable-osx" ]; then
		shift
		POL_SetupWindow_cdrom_UmountPC "$@"
	fi
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+4DeQACgkQ5TH6yaoTykdnPQCeJ9eKh8cRJwHCmD3AmfhnjYGJ
PpcAn0x2Gd11UJlYUgyTM7Tqx1KEmM6N
=Br7j
-----END PGP SIGNATURE-----
