[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "{SCRIPT_NAME}" "{SCRIPT_EDITEUR}" "{SCRIPT_URL}" "{SCRIPT_USER}" "Sea_Dogs_To_Each_His_Own"
POL_Wine_SelectPrefix "Sea_Dogs_To_Each_His_Own"
export POL_WINEVERSION="1.6"
POL_SetupWindow_prefixcreate
POL_Call "POL_Function_FontsSmoothRGB"
POL_Call "POL_Install_corefonts"
POL_Call "POL_Install_steam"
POL_Call "POL_Internal_InstallFonts"
POL_SetupWindow_browse "$(eval_gettext "Please select the install file.")" "$TITLE"
SETUP_PATH="$APP_ANSWER"
POL_SetupWindow_wait "$(eval_gettext 'PlayOnLinux is installing your application...')" "$TITLE"
POL_Wine "$SETUP_PATH"
POL_Wine_WaitExit
POL_Shortcut "ENGINE.exe" "?Sea Dogs: To Each His Own"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUSX/QAKCRDlMfrJqhPK
R4wkAJ0cTc4M9v2GF8W4Y524XCljlEzeuQCgrO03QojI5KDw1P+OgXazIZBvM9U=
=gWkb
-----END PGP SIGNATURE-----
