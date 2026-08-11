mkdir "$POL_USER_ROOT/ressources/indeo50"
POL_Download_Resource "ftp://ftp.us.dell.com/audio/IV5PLAY.EXE" "24e0c7e08fb3e06b431803a896fc8b25" "indeo50"
 
cd "$WINEPREFIX/drive_c/windows/system32/"
cabextract "$POL_USER_ROOT/ressources/indeo50/IV5PLAY.EXE" -F "*.DLL"
cabextract "$POL_USER_ROOT/ressources/indeo50/IV5PLAY.EXE" -F "*.AX"

POL_SetupWindow_pulsebar "Registering libraries, please wait." "$TITLE"

PULSE=0
# not IVFSRC.AX
for file in IAC25_32.AX IACENC.DLL IR32_32.DLL IR41_32.AX IR50_32.DLL
do
  POL_SetupWindow_set_text "$file"
  POL_Wine regsvr32 /i "$file"
  PULSE=$(( PULSE + 20 ))
  POL_SetupWindow_pulse "$PULSE"
done
 
cat <<'_EOFREG_' > iv5.reg
REGEDIT4
 
[HKEY_LOCAL_MACHINE\Software\Classes\CLSID\{33D9A761-90C8-11D0-BD43-00A0C911CE86}\Instance\Indeo\xae audio software]
"CLSID"="{B4CA2970-DD2B-11D0-9DFA-00AA00AF3494}"
"FilterData"=hex:02,00,00,00,00,00,50,00,02,00,00,00,00,00,00,00,30,70,69,33,\
  00,00,00,00,01,00,00,00,04,00,00,00,00,00,00,00,00,00,00,00,30,74,79,33,00,\
  00,00,00,c0,00,00,00,d0,00,00,00,31,74,79,33,00,00,00,00,c0,00,00,00,e0,00,\
  00,00,32,74,79,33,00,00,00,00,c0,00,00,00,f0,00,00,00,33,74,79,33,00,00,00,\
  00,c0,00,00,00,00,01,00,00,31,70,69,33,08,00,00,00,01,00,00,00,04,00,00,00,\
  00,00,00,00,00,00,00,00,30,74,79,33,00,00,00,00,c0,00,00,00,d0,00,00,00,31,\
  74,79,33,00,00,00,00,c0,00,00,00,e0,00,00,00,32,74,79,33,00,00,00,00,c0,00,\
  00,00,f0,00,00,00,33,74,79,33,00,00,00,00,c0,00,00,00,00,01,00,00,61,75,64,\
  73,00,00,10,00,80,00,00,aa,00,38,9b,71,01,00,00,00,00,00,10,00,80,00,00,aa,\
  00,38,9b,71,8a,eb,36,e4,4f,52,ce,11,9f,53,00,20,af,0b,a7,70,02,04,00,00,00,\
  00,10,00,80,00,00,aa,00,38,9b,71,d0,f9,1f,f9,94,c8,d0,11,9d,e9,00,aa,00,af,\
  34,94
"FriendlyName"="Indeoxae audio software"
 
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\SharedDLLs]
"C:\\windows\\system32\\iac25_32.ax"=dword:00000001
"C:\\windows\\system32\\iacenc.dll"=dword:00000001
"C:\\windows\\system32\\ir32_32.dll"=dword:00000001
"C:\\windows\\system32\\ir41_32.ax"=dword:00000001
"C:\\windows\\system32\\ir50_32.dll"=dword:00000001
"C:\\windows\\system32\\ivfsrc.ax"=dword:00000001
 
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\drivers.desc]
"C:\\windows\\system32\\iac25_32.ax"="Indeo® audio software"
"C:\\windows\\system32\\ir32_32.dll"="Indeo® video 3.2 by Intel"
"C:\\windows\\system32\\ir41_32.ax"="Indeo® video interactive 4.x by Intel"
"C:\\windows\\system32\\ir50_32.dll"="Indeo® video 5.06"
 
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Drivers32]
"msacm.iac2"="C:\\windows\\system32\\iac25_32.ax"
"vidc.ir41"="C:\\windows\\system32\\ir41_32.ax"
"vidc.iv31"="C:\\windows\\system32\\ir32_32.dll"
"vidc.iv32"="C:\\windows\\system32\\ir32_32.dll"
"vidc.iv50"="C:\\windows\\system32\\ir50_32.dll"
_EOFREG_

POL_Wine regedit "iv5.reg"
 
cat <<'_EOFREG_' > iv5-user.reg
REGEDIT4
 
[HKEY_CURRENT_USER\Software\Intel]
 
[HKEY_CURRENT_USER\Software\Intel\Indeo]
 
[HKEY_CURRENT_USER\Software\Intel\Indeo\4.1]
"AccessKey"=dword:00000000
"BiDirPrediction"=dword:00000000
"EnabledAccessKey"=dword:00000000
"MinViewportHeight"=dword:00000000
"MinViewportWidth"=dword:00000000
"PlaybackPlatform"=dword:00000002
"QuickCompress"=dword:00000000
"Scalability"=dword:00000000
"Transparency"=dword:00000001
_EOFREG_

POL_Wine regedit "iv5-user.reg"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbGr6QAKCRDlMfrJqhPK
R0DgAJ0QouxPB1WLJ9Kccda/u911eflTpgCcD476IwoGtQ2z8IqgMO+nrKh0EI0=
=0vey
-----END PGP SIGNATURE-----
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbGtZAAKCRDlMfrJqhPK
RxVSAJ9ylDl1TL7EYmECEae/Ju/y31e+fACgn8xaKPjUZqlY772WVQq9du95hAQ=
=FnoP
-----END PGP SIGNATURE-----
