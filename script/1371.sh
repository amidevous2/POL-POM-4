
# CHANGELOG
# [Quentin P] (2010 ?)
#   Initial writting.
# [Dadu042] (2019-11-15 21:14)
#   Workaround for https://bugs.winehq.org/show_bug.cgi?id=45627 (win98 -> nt40)

POL_Download_Resource "http://download.microsoft.com/download/4/a/a/4aafff19-9d21-4d35-ae81-02c48dcbbbff/MDAC_TYP.EXE" "6e914a7391c3b17380ce54fd3a7a133d"

Set_OS nt40

# Overriding dlls
POL_Wine_OverrideDLL "native,builtin" odbc32 odbccp32 oledb32

cd "$POL_USER_ROOT/ressources/"

POL_Wine MDAC_TYP.EXE /q /C:"setup /QNT"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXc/eNQAKCRDlMfrJqhPK
R27DAKCvkug0/4fdFn5TRJ3n/E2VTLrqAgCgsv7A1vxJLHe+WJsfdW0cI8dcByc=
=X+IX
-----END PGP SIGNATURE-----
