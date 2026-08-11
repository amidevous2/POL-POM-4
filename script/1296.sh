if [ "$3" = "" ]; then
	GoGName="$TITLE"
else
	GoGName="$3"
fi
RESOURCE_TO_EXTRACT="$1"
if [ ! "${RESOURCE_TO_EXTRACT::1}" = "/" ]; then
	RESOURCE_TO_EXTRACT="$PWD/$RESOURCE_TO_EXTRACT"
fi

POL_Download_Resource "$SITE/innounp.exe" "d631cc74216ca4cc1adb2a73af959616"

POL_EXTRACT="wine $POL_USER_ROOT/ressources/innounp.exe"

FinalSize="$2"

cd "$WINEPREFIX/drive_c"
$POL_EXTRACT -y -x "$RESOURCE_TO_EXTRACT" &
pid="$(ps aux | grep innounp.exe |  grep -v grep | tail -n 1  | awk '{print $2}')"
POL_Wine_WaitBefore "$TITLE"
sleep 5
if [ ! -e "{tmp}" -a ! -e "{app}" ]; then
	POL_Debug_Fatal "Failed to extract"
fi

echo $pid
ps aux | grep $pid
POL_SetupWindow_DirectoryProgress "$PWD/{app}" "$2" "$pid"
POL_SetupWindow_licence "$(eval_gettext 'Please read this')" "$TITLE" "$PWD/{tmp}/gog_eula.txt" 
echo "Ok"
rm -rf "$PWD/{tmp}"
mv "$PWD/{app}" "$PWD/$GoGName"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/0uX8ACgkQ5TH6yaoTykc92wCdEA82lKCrVQesgtPY57N2mJ1w
WQEAoKcdDErSu4dLsGIUlYISJgr5U+si
=U6Jh
-----END PGP SIGNATURE-----
