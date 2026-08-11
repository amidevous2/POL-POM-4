#!/bin/bash
#Creator: petch

# Remove starting dot, if any
FILEXT="${1#.}"
# Lowercase
FILEXT="${FILEXT,,*}"

if [ -z "$FILEXT" ]; then
    POL_Debug_Warning "$(eval_gettext 'No filename extension specified, skipping association to native application.')" "$TITLE"
    return
fi

MIMETYPE=""
[ "$FILEXT" = "pdf" ] && MIMETYPE="application/pdf"
[ "$FILEXT" = "txt" ] && MIMETYPE="text/plain"
[ "$FILEXT" = "rtf" ] && MIMETYPE="application/rtf"

# Associate an extension with native app
# http://wiki.winehq.org/FAQ#head-91bf3f0a8ccbfab8dee96f82fae2f1a489e0d243

cat <<_EOF_ > "$REPERTOIRE/tmp/nativeext.reg"
REGEDIT4

[HKEY_CLASSES_ROOT\\.${FILEXT}]
@="${FILEXT}file"
"Content Type"="${MIMETYPE}"

[HKEY_CLASSES_ROOT\\${FILEXT}file\\Shell\\Open\\command]
@="winebrowser \\"%1\\""
_EOF_

POL_Wine regedit "$REPERTOIRE/tmp/nativeext.reg"
rm "$REPERTOIRE/tmp/nativeext.reg"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk8CDNUACgkQ5TH6yaoTykc84wCeK2B4rDCPzIVImfLs30WlDeuJ
yyYAnjfMoH27+hUMubqd8soCMENCedce
=TCAC
-----END PGP SIGNATURE-----
