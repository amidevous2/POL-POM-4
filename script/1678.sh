# 1: URL
# 2: filename
# 3: MD5 hash
# 4: Title

# Failed piece from previous download, maybe reference MD5 was corrected?
local FAILEDPIECE="$2.failed"
if [ -n "$3" -a ! -e "$2" -a -e "$FAILEDPIECE" ]; then
        POL_Debug_Message "Failed download found, trying to recover"
        POL_SetupWindow_wait "$(eval_gettext 'Checking piece integrity...')" "$4"
        if [ "$(POL_MD5_file $FAILEDPIECE)" = "$3" ]; then
                POL_Debug_Message "Download recovery successful"
                mv "$FAILEDPIECE" "$2"
        fi
fi

[ -e "$2" ] && return

local TMPPIECE="$2.part"
while true; do
        POL_System_wget "$1" "$4" --no-check-certificate --continue -O "$TMPPIECE"
        POL_Debug_Message "POL_System_wget exit code: $?"

        POL_SetupWindow_wait "$(eval_gettext 'Checking download integrity...')" "$4"
        if [ ! -e "$TMPPIECE" ]; then
                POL_Debug_Message "No downloaded file"
                DLMSG="$(eval_gettext 'Download failed')"
        elif [ -n "$3" ] && [ "$(POL_MD5_file $TMPPIECE)" != "$3" ]; then
                POL_Debug_Message "Downloaded file incomplete or corrupted"
                DLMSG="$(eval_gettext 'Download seems to be corrupted')"
                mv "$TMPPIECE" "$FAILEDPIECE"
        else
                POL_Debug_Message "Download completed successfully"
                mv "$TMPPIECE" "$2"
                [ -e "$FAILEDPIECE" ] && rm "$FAILEDPIECE"
                break
        fi

        local OLD_APP_ANSWER="$APP_ANSWER"
        POL_SetupWindow_question "$DLMSG\n$(eval_gettext 'Retry?')" "$TITLE"
        [ "$APP_ANSWER" = "TRUE" ] || POL_Debug_Fatal "$DLMSG"
        APP_ANSWER="$OLD_APP_ANSWER"
done

cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlXKHa0ACgkQ5TH6yaoTykfVwACglQKY+c3onm9SkNyAzyy4Ha1e
KFYAn246LZ9k8SYgApPb5bzq5uwFz8Kv
=k04z
-----END PGP SIGNATURE-----
