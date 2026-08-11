#!/bin/bash
# PlayOnLinux Function
# Date: 2015-11-25
# Author: MTres19
# Use: Downloads and K-Lite Codec Pack to overcome deficiencies in Wine's DirectShow filters
 
# Changelog
# 2019-04-18 Download URL changed because dead. v1385 is the last supporting WinXP SP3. Dadu042.
 
    
# Download K-Lite
POL_Download_Resource "http://files2.codecguide.com/K-Lite_Codec_Pack_1385_Basic.exe" "0d0dc84a72b9a6a97809370996751b27"

 
# Write unattended installation config
cd "$POL_USER_ROOT/ressources"
    
cat <<EOF>klcp_basic_unattended.ini
[Setup]
Group=K-Lite Codec Pack
NoIcons=0
SetupType=custom
Components=video\h264\lav, video\hevc\lav, video\mpeg4\lav, video\mpeg2\lav, video\vc1\lav, video\wmv\lav, video\other\lav, audio\ac3dts\lav, audio\truehd\lav, audio\aac\lav, audio\mpeg\lav, audio\wma\lav, audio\other\lav, sourcefilter\avi\lav, sourcefilter\matroska\lav, sourcefilter\mp4\lav, sourcefilter\mpegts\lav, sourcefilter\mpegps\lav, sourcefilter\wmv\lav, sourcefilter\lav, subtitles\vsfilter, tools\codectweaktool, shell\icaros_thumbnail, shell\icaros_property, misc\brokencodecs, misc\brokenfilters
Tasks=reset_settings, config_shortcuts, adjust_preferred_decoders
[Thumbnails]
Extensions=.avi;.divx;.amv;.mpeg;.mpg;.m1v;.m2v;.mp2v;.mpv2;.vob;.evo;.wmv;.mp4;.m4v;.mp4v;.mpv4;.hdmov;.mov;.3g2;.3gp;.3gp2;.3gpp;.dv;.mkv;.webm;.flv;.f4v;.ts;.m2ts;.mts;.m2t;.tp;.mxf;.ogm;.ogv;.rm;.rmvb;.ape;.flac;.mka;.mpc;.opus;.tak;.wv;.m4a
[Audio Configuration]
audio_passthrough=0
bitstream_ac3=0
bitstream_dts=0
bitstream_eac3=0
bitstream_dtshd=0
bitstream_thruehd=0
EOF
    
# Start K-Lite setup
POL_Wine K-Lite_Codec_Pack_1385_Basic.exe /verysilent /norestart /LoadInf=".\klcp_basic_unattended.ini"
cat << "-----END PGP SIGNATURE-----" > /dev/null
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAly8qUUACgkQ5TH6yaoTykeyFwCfeAxv2pnF0ozr83SKS1LD5p+B
B2AAnRYF1XG6+Mk81p6nG4cVdpeCc7jb
=ecw+
-----END PGP SIGNATURE-----
