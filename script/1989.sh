local ID="$1"
local TMP_DIR="$2"
local RESULT="$3"
local NAME="$4"
local URL1="http://gamefront.com/files/$ID"
local URL2="http://gamefront.com/files/service/thankyou?id=$ID"
local COOKIE="$TMP_DIR/cookie.txt"
POL_SetupWindow_wait "$(eval_gettext 'Contacting download server.')" "$TITLE"
$POL_WGET --cookies=on --keep-session-cookies --save-cookies="$COOKIE" -O /dev/null "$URL1"
local HTML_FILE="$TMP_DIR/url2.html"
$POL_WGET --referer="$URL1" --cookies=on --load-cookies="$COOKIE" --keep-session-cookies --save-cookies="$COOKIE" -O "$HTML_FILE" "$URL2"
GAMEFRONT_URL="$(grep 'click here' "$HTML_FILE" | grep -oE 'href="[^"]*"' | cut -d '"' -f2)"
POL_System_wget "$GAMEFRONT_URL" "$NAME" --referer="$URL2" --cookies=on --load-cookies="$COOKIE" --keep-session-cookies --save-cookies="$COOKIE" -O "$RESULT"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNC9dUACgkQ5TH6yaoTykcYXgCglV6VBatE9uXgWelt9MwX9bFN
xzQAoIio+pcZk8gy2lsqOrDXf2QXd7CX
=hORg
-----END PGP SIGNATURE-----
