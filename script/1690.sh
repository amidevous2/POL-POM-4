#!/bin/bash

#  Check Kernel ptrace

#  Without Yama patch, we assume ptrace is allowed from anywhere
if [ -e /proc/sys/kernel/yama/ptrace_scope ]; then
        NEED_WINESERVER_RESTART=''
        while true;
            do [ "$(cat /proc/sys/kernel/yama/ptrace_scope)" = 0 ] && break
                if setcap -q -v cap_sys_ptrace=ep "$(which wineserver)"; then
                        [ -n "$NEED_WINESERVER_RESTART" ] && wineserver -k
                        break
                fi
                NEED_WINESERVER_RESTART=1
                POL_SetupWindow_Init
                POL_SetupWindow_menu_num "$(eval_gettext 'The program needs access to ptrace() to proceed:')" "$TITLE" "$(eval_gettext 'Give the capability to wineserver executable')~$(eval_gettext 'Enable ptrace() globally')~$(eval_gettext 'I fixed it myself, just retest')~$(eval_gettext 'Abort installation')" "~"
                case "$APP_ANSWER" in
                    0)
                        POL_Call POL_Function_RootCommand 'sudo setcap cap_sys_ptrace=ep "'"$(which wineserver)"'"'
                        ;;
                    1)
                        POL_Call POL_Function_RootCommand 'echo 0|sudo tee "/proc/sys/kernel/yama/ptrace_scope"'
                        ;;
                    2)
                        ;;
                    *)
                        NOBUGREPORT="TRUE"
                        POL_Debug_Fatal "$(eval_gettext 'User abort')"
                        ;;
                esac
        done
fi

POL_SetupWindow_Close
exit 0
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHh4v8ACgkQ5TH6yaoTykfVwACfciBE/4wY6qvG3IAH72C7K+6Y
Pw8AoJ75chJNZGWW0qG8/2Xr6Ytg5wwq
=5EFX
-----END PGP SIGNATURE-----
