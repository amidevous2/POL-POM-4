# CHANGELOG
# [?] (201x)
#   Initial writting.
# [Dadu042] (2020-01-02)
#   English fix.

POL_SetupWindow_message "$(eval_gettext 'This script requires a virtual desktop, please select one smaller than your actual screen resolution.')" "$TITLE"
 
POL_SetupWindow_menu_num "$(eval_gettext 'Desired virtual resolution')" "$TITLE" "480 x 320 (3:2)|1152 x 768 (3:2)|1280 x 854 (3:2)|1440 x 960 (3:2)|320 x 240 (4:3)|352 x 288 (4:3) |384 x 288 (4:3)|640 x 480 (4:3)|768 x 576 (4:3)|800 x 600 (4:3)|1024 x 768 (4:3)|1152 x 864 (4:3)|1280 x 960 (4:3)|1400 x 1050 (4:3)|1440 x 1080 (4:3)|1600 x 1200 (4:3)|2048 x 1536 (4:3)|800 x 480 (5:3)|1280 x 768 (5:3)|1280 x 1024 (5:4)|2560 x 2048 (5:4)|854 x 480 (16:9)|1024 x 576 (16:9)|1280 x 720 (16:9)|1360 x 768 (16:9)|1366 x 768 (16:9)|1536 x 864 (16:9)|1600 x 900 (16:9)|1920 x 1080 (16:9) |2560 x 1440 (16:9)|3840 x 2160 (16:9)|320 x 200 (16:10)|1280 x 800 (16:10)|1440 x 900 (16:10)|1680 x 1050 (16:10)|1920 x 1200 (16:10)|2560 x 1600 (16:10)|1024 x 600 (~17:10) |2560 x 1080 (21:9)|3440 x 1440 (21:9)|2048 x 1080 (2K)|4096 x 2160 (4K)" "|"
 
case "$APP_ANSWER" in
    0)
        Set_Desktop "On" "480" "320"
        ;;
    1)
        Set_Desktop "On" "1152" "768"
        ;;
    2)
        Set_Desktop "On" "1280" "854"
        ;;
    3)
        Set_Desktop "On" "1440" "960"
        ;;
    4)
        Set_Desktop "On" "320" "240"
        ;;
    5)
        Set_Desktop "On" "352" "288"
        ;;
    6)
        Set_Desktop "On" "384" "288"
        ;;
    7)
        Set_Desktop "On" "640" "480"
        ;;
    8)
        Set_Desktop "On" "768" "576"
        ;;
    9)
        Set_Desktop "On" "800" "600"
        ;;
    10)
        Set_Desktop "On" "1024" "768"
        ;;
    11)
        Set_Desktop "On" "1152" "864"
        ;;
    12)
        Set_Desktop "On" "1280" "960"
        ;;
    13)
        Set_Desktop "On" "1400" "1050"
        ;;
    14)
        Set_Desktop "On" "1440" "1080"
        ;;
    15)
        Set_Desktop "On" "1600" "1200"
        ;;
    16)
        Set_Desktop "On" "2048" "1536"
        ;;
    17)
        Set_Desktop "On" "800" "480"
        ;;
    18)
        Set_Desktop "On" "1280" "760"
        ;;
    19)
        Set_Desktop "On" "1280" "1024"
        ;;
    20)
        Set_Desktop "On" "2560" "2048"
        ;;
    21)
        Set_Desktop "On" "854" "480"
        ;;
    22)
        Set_Desktop "On" "1024" "576"
        ;;
    23)
        Set_Desktop "On" "1280" "720"
        ;;
    24)
        Set_Desktop "On" "1360" "768"
        ;;
    25)
        Set_Desktop "On" "1366" "768"
        ;;
    26)
        Set_Desktop "On" "1536" "864"
        ;;
    27)
        Set_Desktop "On" "1600" "900"
        ;;
    28)
        Set_Desktop "On" "1920" "1080"
        ;;
    29)
        Set_Desktop "On" "2560" "1440"
        ;;
    30)
        Set_Desktop "On" "3840" "2160"
        ;;
    31)
        Set_Desktop "On" "320" "200"
        ;;
    32)
        Set_Desktop "On" "1280" "800"
        ;;
    33)
        Set_Desktop "On" "1440" "900"
        ;;
    34)
        Set_Desktop "On" "1680" "1050"
        ;;
    35)
        Set_Desktop "On" "1920" "1200"
        ;;
    36)
        Set_Desktop "On" "1024" "600"
        ;;
    37)
        Set_Desktop "On" "2560" "1600"
        ;;
    38)
        Set_Desktop "On" "2560" "1080"
        ;;
    39)
        Set_Desktop "On" "3440" "1440"
        ;;
    40)
        Set_Desktop "On" "2048" "1080"
        ;;
    41)
        Set_Desktop "On" "4096" "2160"
        ;;
    *)
        echo "$(eval_gettext 'Using default resolution')"
        Set_Desktop "On" "800" "600"
        ;;
esac
 
POL_SetupWindow_message "$(eval_gettext 'You can change it at any time there:\nConfigure -> select virtual drive -> Wine tab -> Wine Configuration -> Graphics tab.')" "$TITLE"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXn/MLAAKCRDlMfrJqhPK
R/8rAJ4oqdtbx7eqnnT8kLXumeb9GWJu8ACgpOnEV3kIuelnWGaRpuvlBfU4Ej0=
=hUUz
-----END PGP SIGNATURE-----
