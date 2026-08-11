#!/bin/bash
# PlayOnLinux Function
# RealName: Adobe Air
# Author : Tinou
#
# CHANGELOG
# [Petch] (2015-12-13)
#   Set dnsapi DLL override to that AdobeAIR works (http://wiki.playonlinux.com/index.php/Troubleshooting_Common_Problems#Install_needed_components)
# [Petch] (2015-12-23)
#   Download the installer as a resource
# [Dadu042] (2020-01-24 21:20)
#   Adobe Air v18 -> 32.

POL_SetupWindow_wait "$(eval_gettext 'Installing Adobe Air')" "$TITLE"

POL_Download_Resource "https://archive.org/download/adobe-airinstaller/AdobeAIRInstaller.exe" "a57c38903764f64ba656df01130c38d7"

cd "$POL_USER_ROOT/ressources"
POL_Wine AdobeAIRInstaller.exe -silent

# Incorrect dnsapi overrides is often the reason why AdobeAIR stops working
POL_Wine_OverrideDLL "builtin,native" "dnsapi"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYW3elgAKCRDlMfrJqhPK
R6g2AJ910HSsIIelRT5UOpYAAVjlohRYzwCfdNw5eZyfmSA9MM6n21rSjEa1Mgs=
=AbE+
-----END PGP SIGNATURE-----
