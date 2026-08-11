POL_SetupWindow_wait_next_signal "Processing" "Anti aliasing"
POL_Wine_InstallFonts
cat << EOF > "$REPERTOIRE/tmp/fontsaa.reg"
REGEDIT4
[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"
"FontSmoothingType"=dword:00000002
"FontSmoothingGamma"=dword:00000578
"FontSmoothingOrientation"=dword:00000000
EOF
POL_Wine regedit "$REPERTOIRE/tmp/fontsaa.reg"
 
POL_SetupWindow_detect_exit
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk9Wez4ACgkQ5TH6yaoTykcbhgCggERthTPX0SsjGEU1EgWv7A63
sZAAn3Pm/fy7dhgAc8yGjdDlM3AO3+Ty
=ws4t
-----END PGP SIGNATURE-----
