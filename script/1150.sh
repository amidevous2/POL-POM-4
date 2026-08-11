if [ "$CDROM" ]; then
	POL_Config_DosPrefixWrite manual_mount true
	cat <<_EOFAE_ > "$WINEPREFIX/drive_c/autoexec.bat"
mount D "$CDROM" -t cdrom
_EOFAE_
	rm "$WINEPREFIX/dosdevices/d::"
	rm "$WINEPREFIX/dosdevices/d:"
fi

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+xOdoACgkQ5TH6yaoTykdM+ACglRkyTtPttzgXk/UTi2S0/1cN
spsAoJ7ILuq9k/tZK5cgL5cISsTuBBgm
=t1hJ
-----END PGP SIGNATURE-----
