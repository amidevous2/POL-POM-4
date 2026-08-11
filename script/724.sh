POL_SetupWindow_wait_next_signal "Processing" "Anti aliasing"
POL_Wine_InstallFonts
cat << EOF > "$REPERTOIRE/tmp/fontsaa.reg"
REGEDIT4
[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"
"FontSmoothingType"=dword:00000001
"FontSmoothingGamma"=dword:00000578
"FontSmoothingOrientation"=dword:00000001
EOF
POL_Wine regedit "$REPERTOIRE/tmp/fontsaa.reg"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk9We1sACgkQ5TH6yaoTykfFPQCgh8/idk+wfYzYdvCnXXn6cMXd
EEMAnjmqyJXhdZRCSgm+P2CyUuoMa4DN
=TNur
-----END PGP SIGNATURE-----
