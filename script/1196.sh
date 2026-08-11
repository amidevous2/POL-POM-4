# 1 : Setup file. If it exists, no need to unhide

if [ "$POL_OS" = "Linux" ]; then
	if [ ! "$CDROM" ]; then
		POL_Debug_Warning "$CDROM is not set" 
	fi
	if [ "$(find "$CDROM" -iwholename "$CDROM/$1")" = "" ]; then

	VALID_DEVNODE=`mount | grep "$CDROM" | awk '{print $1}'`
	VALID_UID=`id -g`

	cat << EOF > "$POL_USER_ROOT/tmp/unhide.txt"
"$(eval_gettext 'To continue, PlayOnLinux needs to remount your CD-ROM with unhide option.')"

"$(eval_gettext 'We need to have sudo access on your computer. Therefore, your root password will be asked. Here is the commands PlayOnLinux will run as root:')"

umount "$CDROM"
mkdir -p ${CDROM}_Unhide
mount -o ro,unhide,uid=$VALID_UID $VALID_DEVNODE ${CDROM}_Unhide
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
		POL_SetupWindow_message "Sudo is not installed on your system. Please run the following commands manually as root\n\numount \"$CDROM\"\nmkdir -p \"${CDROM}_Unhide\"\nmount -o ro,unhide,uid=$VALID_UID $VALID_DEVNODE \"${CDROM}_Unhide\"\n\nPress next when it's done"
	else
		$SUDO_COMMAND umount "$CDROM"
		$SUDO_COMMAND mkdir -p "${CDROM}_Unhide"
		if $SUDO_COMMAND mount -o ro,unhide,uid=$VALID_UID $VALID_DEVNODE "${CDROM}_Unhide"; then
			export CDROM_UNHIDEN="TRUE"
		else	
			POL_Debug_Error "Unable to mount the cdrom"
		fi
	fi
	export CDROM="${CDROM}_Unhide"
	fi
else # OSX
	if [ "$1" = "--enable-osx" ]; then
		shift
		POL_SetupWindow_cdrom_MountPC "$@"
	fi
fi
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+4De0ACgkQ5TH6yaoTykdGkACeJK3ysxLlKckzOnw9v2Bzm7jb
F04AoLKRFTNOiouIaYXoE6CEOIUcASgT
=oGwA
-----END PGP SIGNATURE-----
