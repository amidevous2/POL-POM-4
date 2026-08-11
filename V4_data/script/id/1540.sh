#!/bin/bash
# Date : (2013-01-13 14-14)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-01-13 14-14)
#   Initial script.
# [Pierre Etchemaite] (2013-05-11 19-57)
#   ?
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.4.1 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="medal_of_honor_allied_assault_war_chest"
PREFIX="MedalOfHonorAAWC_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Medal of Honor: Allied Assault War Chest"
SHORTCUT_NAME1="Medal of Honor - Allied Assault War Chest"
SHORTCUT_NAME2="Medal of Honor - Spearhead"
SHORTCUT_NAME3="Medal of Honor - Breakthrough"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1540
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "2f5dd640b3994d67fc71995b743cb22c" "3030b7213476b14fe52719083792d6ff" "a5538ad0837208b065cd8b10229ba717"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Not 100% sure it helps Q3 engine
POL_Call POL_Install_VideoDriver

POL_Wine_X11Drv "GrabFullScreen" "Y"

cat <<_EOFREG_ > "$POL_USER_ROOT/tmp/mohaa_disabled extensions.reg"
REGEDIT4

[HKEY_CURRENT_USER\Software\Wine\OpenGL]
"DisabledExtensions"="GL_ARB_color_buffer_float,GL_ARB_depth_texture,GL_ARB_draw_buffers,GL_ARB_fragment_program,GL_ARB_fragment_program_shadow,GL_ARB_fragment_shader,GL_ARB_half_float_pixel,GL_ARB_multisample,GL_ARB_occlusion_query,GL_ARB_pixel_buffer_object,GL_ARB_point_sprite,GL_ARB_shadow,GL_ARB_shader_objects,GL_ARB_shading_language_100,GL_ARB_texture_border_clamp,GL_ARB_texture_compression,GL_ARB_texture_cube_map,GL_ARB_texture_env_combine,GL_ARB_texture_env_dot3,GL_ARB_texture_float,GL_ARB_texture_non_power_of_two,GL_ARB_texture_rectangle,GL_ARB_vertex_program,GL_ARB_vertex_shader,GL_ATI_draw_buffers,GL_ATI_texture_float,GL_ATI_texture_mirror_once,GL_EXT_blend_color,GL_EXT_blend_equation_separate,GL_EXT_blend_func_separate,GL_EXT_blend_minmax,GL_EXT_blend_subtract,GL_EXT_Cg_shader,GL_EXT_depth_bounds_test,GL_EXT_framebuffer_blit,GL_EXT_framebuffer_multisample,GL_EXT_framebuffer_object,GL_EXT_gpu_program_parameters,GL_EXT_packed_depth_stencil,GL_EXT_pixel_buffer_object,GL_EXT_shadow_funcs,GL_EXT_stencil_two_side,GL_EXT_texture3D,GL_EXT_texture_cube_map,GL_EXT_texture_env_dot3,GL_EXT_texture_filter_anisotropic,GL_EXT_texture_lod,GL_EXT_texture_mirror_clamp,GL_EXT_texture_sRGB,GL_EXT_timer_query,GL_IBM_rasterpos_clip,GL_IBM_texture_mirrored_repeat,GL_NV_copy_depth_to_color,GL_NV_depth_clamp,GL_NV_fence,GL_NV_float_buffer,GL_NV_fragment_program,GL_NV_fragment_program_option,GL_NV_fragment_program2,GL_NV_framebuffer_multisample_coverage,GL_NV_half_float,GL_NV_light_max_exponent,GL_NV_multisample_filter_hint,GL_NV_occlusion_query,GL_NV_pixel_data_range,GL_NV_point_sprite,GL_NV_primitive_restart,GL_NV_register_combiners,GL_NV_register_combiners2,GL_NV_texture_compression_vtc,GL_NV_texture_expand_normal,GL_NV_texture_rectangle,GL_NV_texture_shader,GL_NV_texture_shader2,GL_NV_texture_shader3,GL_NV_vertex_array_range,GL_NV_vertex_array_range2,GL_NV_vertex_program,GL_NV_vertex_program1_1,GL_NV_vertex_program2,GL_NV_vertex_program2_option,GL_NV_vertex_program3,GL_NVX_conditional_render,GL_SGIS_generate_mipmap,GL_SGIS_texture_lod,GL_SGIX_depth_texture,GL_SGIX_shadow,GL_SUN_slice_accum"
_EOFREG_

POL_Wine regedit "$POL_USER_ROOT/tmp/mohaa_disabled extensions.reg"

# Disable DirectInput mouse support
#for dir in main mainta maintt; do
#  printf 'seta in_mouse -1\r\n' >> "$WINEPREFIX/drive_c/GOG Games/Medal of Honor - Allied Assault War Chest/$dir/newconfig.cfg"
#done

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "MOHAA.exe" "$SHORTCUT_NAME1" "$SHORTCUT_NAME1.png" "" "Game;ActionGame;"
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME1" 'export __GL_ExtensionStringVersion=17700'
POL_Shortcut_Document "$SHORTCUT_NAME1" "$WINEPREFIX/drive_c/GOG Games/Medal of Honor - Allied Assault War Chest/Readme.txt"

POL_Shortcut "moh_spearhead.exe" "$SHORTCUT_NAME2" "$SHORTCUT_NAME2.png" "" "Game;ActionGame;"
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME2" 'export __GL_ExtensionStringVersion=17700'
POL_Shortcut_Document "$SHORTCUT_NAME2" "$WINEPREFIX/drive_c/GOG Games/Medal of Honor - Allied Assault War Chest/Readme_Spearhead.txt"

POL_Shortcut "moh_breakthrough.exe" "$SHORTCUT_NAME3" "$SHORTCUT_NAME3.png" "" "Game;ActionGame;"
POL_Shortcut_InsertBeforeWine "$SHORTCUT_NAME3" 'export __GL_ExtensionStringVersion=17700'
POL_Shortcut_Document "$SHORTCUT_NAME3" "$WINEPREFIX/drive_c/GOG Games/Medal of Honor - Allied Assault War Chest/Readme_Breakthrough.txt"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYbfgAKCRDlMfrJqhPK
R6aCAJ9NZacOwJ49ECBFTAAKDKPeXXli7wCeM0lFVH6vgn8ZPf5oIBV1Nogad8o=
=ZxcI
-----END PGP SIGNATURE-----
