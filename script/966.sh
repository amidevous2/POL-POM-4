POL_Download_Resource "https://web.archive.org/web/20210125001711if_/http://download.microsoft.com/download/5/a/d/5ad868a0-8ecd-4bb0-a882-fe53eb7ef348/VB6.0-KB290887-X86.exe" #"http://download.microsoft.com/download/5/a/d/5ad868a0-8ecd-4bb0-a882-fe53eb7ef348/VB6.0-KB290887-X86.exe" "ef5b83c4cc60e246bf627d85f6d7397b"

if [ "$POL_ARCH" = "amd64" ]; then
    cd "$WINEPREFIX/drive_c/windows/syswow64"
else
    cd "$WINEPREFIX/drive_c/windows/system32"
fi

rm comcat.dll
rm oleaut32.dll
rm olepro32.dll
rm stdole2.tlb

cd "$POL_USER_ROOT/ressources" 

POL_SetupWindow_wait "$(eval_gettext 'Installing Visual Basic runtime')" "$TITLE"
cabextract VB6.0-KB290887-X86.exe
POL_Wine --ignore-errors "vbrun60sp6.exe"
_ec=$?
POL_Wine_WaitExit

case "$_ec" in
    0|43) ;;
    *) POL_Debug_Error "Failed installing VB6 runtime"
esac


cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYXxf7AAKCRDlMfrJqhPK
RzoFAJ4s9Z4IyILBi69MCP+wnrlJTdDeVACfcU0r0XkWdNSjHfjT2E4R2hxst68=
=KYwt
-----END PGP SIGNATURE-----
