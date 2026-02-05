/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excairo_h__
#define __excairo_h__

#include "exgeomet.h"

#ifdef WIN32
// float-32 divide 8bit value
#define FD8V(v) ((v) / 255.f)
#else // compat linux
// float-64 divide 8bit value
#define FD8V(v) ((v) / 255.)
#endif

#pragma pack(push, 1)

struct FT_FaceRec_;
typedef struct FT_FaceRec_ ft_face_t;

typedef int cr_bool_t;
typedef struct _cairo cr_t;
typedef struct _cairo_device cr_device_t;
typedef struct _cairo_pattern cr_pattern_t;
typedef struct _cairo_surface cr_surface_t;
typedef void (*cr_destroy_func_t)(void* data);

struct cr_matrix_t {
    float64 xx; float64 yx;
    float64 xy; float64 yy;
    float64 x0; float64 y0;
};

struct cr_user_data_key_t {
    int32 unused;
};

enum cr_status_t {
    CR_STATUS_SUCCESS = 0,

    CR_STATUS_NO_MEMORY,
    CR_STATUS_INVALID_RESTORE,
    CR_STATUS_INVALID_POP_GROUP,
    CR_STATUS_NO_CURRENT_POINT,
    CR_STATUS_INVALID_MATRIX,
    CR_STATUS_INVALID_STATUS,
    CR_STATUS_NULL_POINTER,
    CR_STATUS_INVALID_STRING,
    CR_STATUS_INVALID_PATH_DATA,
    CR_STATUS_READ_ERROR,
    CR_STATUS_WRITE_ERROR,
    CR_STATUS_SURFACE_FINISHED,
    CR_STATUS_SURFACE_TYPE_MISMATCH,
    CR_STATUS_PATTERN_TYPE_MISMATCH,
    CR_STATUS_INVALID_CONTENT,
    CR_STATUS_INVALID_FORMAT,
    CR_STATUS_INVALID_VISUAL,
    CR_STATUS_FILE_NOT_FOUND,
    CR_STATUS_INVALID_DASH,
    CR_STATUS_INVALID_DSC_COMMENT,
    CR_STATUS_INVALID_INDEX,
    CR_STATUS_CLIP_NOT_REPRESENTABLE,
    CR_STATUS_TEMP_FILE_ERROR,
    CR_STATUS_INVALID_STRIDE,
    CR_STATUS_FONT_TYPE_MISMATCH,
    CR_STATUS_USER_FONT_IMMUTABLE,
    CR_STATUS_USER_FONT_ERROR,
    CR_STATUS_NEGATIVE_COUNT,
    CR_STATUS_INVALID_CLUSTERS,
    CR_STATUS_INVALID_SLANT,
    CR_STATUS_INVALID_WEIGHT,
    CR_STATUS_INVALID_SIZE,
    CR_STATUS_USER_FONT_NOT_IMPLEMENTED,
    CR_STATUS_DEVICE_TYPE_MISMATCH,
    CR_STATUS_DEVICE_ERROR,
    CR_STATUS_INVALID_MESH_CONSTRUCTION,
    CR_STATUS_DEVICE_FINISHED,
    CR_STATUS_JBIG2_GLOBAL_MISSING,
    CR_STATUS_PNG_ERROR,
    CR_STATUS_FREETYPE_ERROR,
    CR_STATUS_WIN32_GDI_ERROR,
    CR_STATUS_TAG_ERROR,

    CR_STATUS_LAST_STATUS
};

enum cr_content_t {
    CR_CONTENT_COLOR        = 0x1000,
    CR_CONTENT_ALPHA        = 0x2000,
    CR_CONTENT_COLOR_ALPHA  = 0x3000
};

enum cr_format_t {
    CR_FORMAT_INVALID   = -1,
    CR_FORMAT_ARGB32    = 0,
    CR_FORMAT_RGB24     = 1,
    CR_FORMAT_A8        = 2,
    CR_FORMAT_A1        = 3,
    CR_FORMAT_RGB16_565 = 4,
    CR_FORMAT_RGB30     = 5
};

typedef cr_status_t (*cr_write_func_t)(void* closure, const uint8* data, uint32 length);
typedef cr_status_t (*cr_read_func_t)(void* closure, uint8* data, uint32 length);

enum cr_operator_t {
    CR_OPERATOR_CLEAR,

    CR_OPERATOR_SOURCE,
    CR_OPERATOR_OVER,
    CR_OPERATOR_IN,
    CR_OPERATOR_OUT,
    CR_OPERATOR_ATOP,

    CR_OPERATOR_DEST,
    CR_OPERATOR_DEST_OVER,
    CR_OPERATOR_DEST_IN,
    CR_OPERATOR_DEST_OUT,
    CR_OPERATOR_DEST_ATOP,

    CR_OPERATOR_XOR,
    CR_OPERATOR_ADD,
    CR_OPERATOR_SATURATE,

    CR_OPERATOR_MULTIPLY,
    CR_OPERATOR_SCREEN,
    CR_OPERATOR_OVERLAY,
    CR_OPERATOR_DARKEN,
    CR_OPERATOR_LIGHTEN,
    CR_OPERATOR_COLOR_DODGE,
    CR_OPERATOR_COLOR_BURN,
    CR_OPERATOR_HARD_LIGHT,
    CR_OPERATOR_SOFT_LIGHT,
    CR_OPERATOR_DIFFERENCE,
    CR_OPERATOR_EXCLUSION,
    CR_OPERATOR_HSL_HUE,
    CR_OPERATOR_HSL_SATURATION,
    CR_OPERATOR_HSL_COLOR,
    CR_OPERATOR_HSL_LUMINOSITY
};

enum cr_antialias_t {
    CR_ANTIALIAS_DEFAULT,
    CR_ANTIALIAS_NONE,
    CR_ANTIALIAS_GRAY,
    CR_ANTIALIAS_SUBPIXEL,
    CR_ANTIALIAS_FAST,
    CR_ANTIALIAS_GOOD,
    CR_ANTIALIAS_BEST
};

enum cr_fill_rule_t {
    CR_FILL_RULE_WINDING,
    CR_FILL_RULE_EVEN_ODD
};

enum cr_line_cap_t {
    CR_LINE_CAP_BUTT,
    CR_LINE_CAP_ROUND,
    CR_LINE_CAP_SQUARE
};

enum cr_line_join_t {
    CR_LINE_JOIN_MITER,
    CR_LINE_JOIN_ROUND,
    CR_LINE_JOIN_BEVEL
};

struct cr_rectangle_int_t {
    int32 x, y;
    int32 width, height;
};

struct cr_rectangle_t {
    float64 x, y, width, height;
};

struct cr_rectangle_list_t {
    cr_status_t     status;
    cr_rectangle_t *rectangles;
    int32           num_rectangles;
};

typedef struct _cairo_scaled_font cr_scaled_font_t;
typedef struct _cairo_font_face cr_font_face_t;

struct cr_glyph_t {
    uint64      index;
    float64     x;
    float64     y;
};

struct cr_text_cluster_t {
    int32       num_bytes;
    int32       num_glyphs;
};

struct cr_font_extents_t { // cairo_font_extents_t
    float64 ascent;
    float64 descent;
    float64 height;
    float64 max_x_advance;
    float64 max_y_advance;
};

struct cr_text_extents_t { // cairo_text_extents_t
    float64 x_bearing;
    float64 y_bearing;
    float64 width;
    float64 height;
    float64 x_advance;
    float64 y_advance;
};

enum cr_font_slant_t {
    CR_FONT_SLANT_NORMAL,
    CR_FONT_SLANT_ITALIC,
    CR_FONT_SLANT_OBLIQUE
};

enum cr_font_weight_t {
    CR_FONT_WEIGHT_NORMAL,
    CR_FONT_WEIGHT_BOLD
};

enum cr_subpixel_order_t {
    CR_SUBPIXEL_ORDER_DEFAULT,
    CR_SUBPIXEL_ORDER_RGB,
    CR_SUBPIXEL_ORDER_BGR,
    CR_SUBPIXEL_ORDER_VRGB,
    CR_SUBPIXEL_ORDER_VBGR
};

enum cr_hint_style_t {
    CR_HINT_STYLE_DEFAULT,
    CR_HINT_STYLE_NONE,
    CR_HINT_STYLE_SLIGHT,
    CR_HINT_STYLE_MEDIUM,
    CR_HINT_STYLE_FULL
};

enum cr_hint_metrics_t {
    CR_HINT_METRICS_DEFAULT,
    CR_HINT_METRICS_OFF,
    CR_HINT_METRICS_ON
};

enum cr_font_type_t {
    CR_FONT_TYPE_TOY,
    CR_FONT_TYPE_FT,
    CR_FONT_TYPE_WIN32,
    CR_FONT_TYPE_QUARTZ,
    CR_FONT_TYPE_USER
};

typedef struct _cairo_font_options cr_font_options_t;

enum cr_path_data_type_t {
    CR_PATH_MOVE_TO,
    CR_PATH_LINE_TO,
    CR_PATH_CURVE_TO,
    CR_PATH_CLOSE_PATH
};

union cr_path_data_t {
    struct {
        cr_path_data_type_t type;
        int32 length;
    } header;
    struct {
        float64 x, y;
    } point;
};

struct cr_path_t {
    cr_status_t status;
    cr_path_data_t* data;
    int32 num_data;
};

enum cr_device_type_t {
    CR_DEVICE_TYPE_DRM,
    CR_DEVICE_TYPE_GL,
    CR_DEVICE_TYPE_SCRIPT,
    CR_DEVICE_TYPE_XCB,
    CR_DEVICE_TYPE_XLIB,
    CR_DEVICE_TYPE_XML,
    CR_DEVICE_TYPE_COGL,
    CR_DEVICE_TYPE_WIN32,

    CR_DEVICE_TYPE_INVALID = -1
};

enum cr_surface_observer_mode_t {
    CR_SURFACE_OBSERVER_NORMAL = 0,
    CR_SURFACE_OBSERVER_RECORD_OPERATIONS = 0x1
};

enum cr_surface_type_t {
    CR_SURFACE_TYPE_IMAGE,
    CR_SURFACE_TYPE_PDF,
    CR_SURFACE_TYPE_PS,
    CR_SURFACE_TYPE_XLIB,
    CR_SURFACE_TYPE_XCB,
    CR_SURFACE_TYPE_GLITZ,
    CR_SURFACE_TYPE_QUARTZ,
    CR_SURFACE_TYPE_WIN32,
    CR_SURFACE_TYPE_BEOS,
    CR_SURFACE_TYPE_DIRECTFB,
    CR_SURFACE_TYPE_SVG,
    CR_SURFACE_TYPE_OS2,
    CR_SURFACE_TYPE_WIN32_PRINTING,
    CR_SURFACE_TYPE_QUARTZ_IMAGE,
    CR_SURFACE_TYPE_SCRIPT,
    CR_SURFACE_TYPE_QT,
    CR_SURFACE_TYPE_RECORDING,
    CR_SURFACE_TYPE_VG,
    CR_SURFACE_TYPE_GL,
    CR_SURFACE_TYPE_DRM,
    CR_SURFACE_TYPE_TEE,
    CR_SURFACE_TYPE_XML,
    CR_SURFACE_TYPE_SKIA,
    CR_SURFACE_TYPE_SUBSURFACE,
    CR_SURFACE_TYPE_COGL
};

enum cr_pattern_type_t {
    CR_PATTERN_TYPE_SOLID,
    CR_PATTERN_TYPE_SURFACE,
    CR_PATTERN_TYPE_LINEAR,
    CR_PATTERN_TYPE_RADIAL,
    CR_PATTERN_TYPE_MESH,
    CR_PATTERN_TYPE_RASTER_SOURCE
};

enum cr_extend_t {
    CR_EXTEND_NONE,
    CR_EXTEND_REPEAT,
    CR_EXTEND_REFLECT,
    CR_EXTEND_PAD
};

enum cr_filter_t {
    CR_FILTER_FAST,
    CR_FILTER_GOOD,
    CR_FILTER_BEST,
    CR_FILTER_NEAREST,
    CR_FILTER_BILINEAR,
    CR_FILTER_GAUSSIAN
};

typedef struct _cairo_region cr_region_t;

enum cr_region_overlap_t {
    CR_REGION_OVERLAP_IN,       /* completely inside region */
    CR_REGION_OVERLAP_OUT,      /* completely outside region */
    CR_REGION_OVERLAP_PART      /* partly inside region */
};

cr_t* cr_create(cr_surface_t* target);
cr_t* cr_reference(cr_t* cr);
void cr_destroy(cr_t* cr);
uint32 cr_get_reference_count(cr_t* cr);
void* cr_get_user_data(cr_t* cr, const cr_user_data_key_t* key);
cr_status_t cr_set_user_data(cr_t* cr, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy);
void cr_save(cr_t* cr);
void cr_restore(cr_t* cr);
void cr_push_group(cr_t* cr);
void cr_push_group_with_content(cr_t* cr, cr_content_t content);
cr_pattern_t* cr_pop_group(cr_t* cr);
void cr_pop_group_to_source(cr_t* cr);
void cr_set_operator(cr_t* cr, cr_operator_t op);
void cr_set_source(cr_t* cr, cr_pattern_t* source);
void cr_set_source_rgb(cr_t* cr, float64 red, float64 green, float64 blue);
void cr_set_source_rgba(cr_t* cr, float64 red, float64 green, float64 blue, float64 alpha);
void cr_set_source_surface(cr_t* cr, cr_surface_t* surface, float64 x, float64 y);
void cr_set_tolerance(cr_t* cr, float64 tolerance);
void cr_set_antialias(cr_t* cr, cr_antialias_t antialias);
void cr_set_fill_rule(cr_t* cr, cr_fill_rule_t fill_rule);
void cr_set_line_width(cr_t* cr, float64 width);
void cr_set_line_cap(cr_t* cr, cr_line_cap_t line_cap);
void cr_set_line_join(cr_t* cr, cr_line_join_t line_join);
void cr_set_dash(cr_t* cr, const float64* dashes, int32 num_dashes, float64 offset);
void cr_set_miter_limit(cr_t* cr, float64 limit);
void cr_translate(cr_t* cr, float64 tx, float64 ty);
void cr_scale(cr_t* cr, float64 sx, float64 sy);
void cr_rotate(cr_t* cr, float64 angle);
void cr_transform(cr_t* cr, const cr_matrix_t* matrix);
void cr_set_matrix(cr_t* cr, const cr_matrix_t* matrix);
void cr_identity_matrix(cr_t* cr);
void cr_user_to_device(cr_t* cr, float64* x, float64* y);
void cr_user_to_device_distance(cr_t* cr, float64* dx, float64* dy);
void cr_device_to_user(cr_t* cr, float64* x, float64* y);
void cr_device_to_user_distance(cr_t* cr, float64* dx, float64* dy);
void cr_new_path(cr_t* cr);
void cr_move_to(cr_t* cr, float64 x, float64 y);
void cr_new_sub_path(cr_t* cr);
void cr_line_to(cr_t* cr, float64 x, float64 y);
void cr_curve_to(cr_t* cr, float64 x1, float64 y1, float64 x2, float64 y2, float64 x3, float64 y3);
void cr_arc(cr_t* cr, float64 xc, float64 yc, float64 radius, float64 angle1, float64 angle2);
void cr_arc_negative(cr_t* cr, float64 xc, float64 yc, float64 radius, float64 angle1, float64 angle2);
void cr_rel_move_to(cr_t* cr, float64 dx, float64 dy);
void cr_rel_line_to(cr_t* cr, float64 dx, float64 dy);
void cr_rel_curve_to(cr_t* cr, float64 dx1, float64 dy1, float64 dx2, float64 dy2, float64 dx3, float64 dy3);
void cr_rectangle(cr_t* cr, float64 x, float64 y, float64 width, float64 height);
void cr_close_path(cr_t* cr);
void cr_path_extents(cr_t* cr, float64* x1, float64* y1, float64* x2, float64* y2);
void cr_paint(cr_t* cr);
void cr_paint_with_alpha(cr_t* cr, float64 alpha);
void cr_mask(cr_t* cr, cr_pattern_t* pattern);
void cr_mask_surface(cr_t* cr, cr_surface_t* surface, float64 surface_x, float64 surface_y);
void cr_stroke(cr_t* cr);
void cr_stroke_preserve(cr_t* cr);
void cr_fill(cr_t* cr);
void cr_fill_preserve(cr_t* cr);
void cr_copy_page(cr_t* cr);
void cr_show_page(cr_t* cr);
cr_bool_t cr_in_stroke(cr_t* cr, float64 x, float64 y);
cr_bool_t cr_in_fill(cr_t* cr, float64 x, float64 y);
cr_bool_t cr_in_clip(cr_t* cr, float64 x, float64 y);
void cr_stroke_extents(cr_t* cr, float64* x1, float64* y1, float64* x2, float64* y2);
void cr_fill_extents(cr_t* cr, float64* x1, float64* y1, float64* x2, float64* y2);
void cr_reset_clip(cr_t* cr);
void cr_clip(cr_t* cr);
void cr_clip_preserve(cr_t* cr);
void cr_clip_extents(cr_t* cr, float64* x1, float64* y1, float64* x2, float64* y2);
cr_rectangle_list_t* cr_copy_clip_rectangle_list(cr_t* cr);
void cr_rectangle_list_destroy(cr_rectangle_list_t* rectangle_list);

cr_glyph_t* cr_glyph_allocate(int32 num_glyphs);
void cr_glyph_free(cr_glyph_t* glyphs);
cr_text_cluster_t* cr_text_cluster_allocate(int32 num_clusters);
void cr_text_cluster_free(cr_text_cluster_t* clusters);
cr_font_options_t* cr_font_options_create(void);
cr_font_options_t* cr_font_options_copy(const cr_font_options_t* original);
void cr_font_options_destroy(cr_font_options_t* options);
cr_status_t cr_font_options_status(cr_font_options_t* options);
void cr_font_options_merge(cr_font_options_t* options, const cr_font_options_t* other);
cr_bool_t cr_font_options_equal(const cr_font_options_t* options, const cr_font_options_t* other);
uint64 cr_font_options_hash(const cr_font_options_t* options);
void cr_font_options_set_antialias(cr_font_options_t* options, cr_antialias_t antialias);
cr_antialias_t cr_font_options_get_antialias(const cr_font_options_t* options);
void cr_font_options_set_subpixel_order(cr_font_options_t* options, cr_subpixel_order_t subpixel_order);
cr_subpixel_order_t cr_font_options_get_subpixel_order(const cr_font_options_t* options);
void cr_font_options_set_hint_style(cr_font_options_t* options, cr_hint_style_t hint_style);
cr_hint_style_t cr_font_options_get_hint_style(const cr_font_options_t* options);
void cr_font_options_set_hint_metrics(cr_font_options_t* options, cr_hint_metrics_t hint_metrics);
cr_hint_metrics_t cr_font_options_get_hint_metrics(const cr_font_options_t* options);
void cr_select_font_face(cr_t* cr, const char* family, cr_font_slant_t slant, cr_font_weight_t weight);
void cr_set_font_size(cr_t* cr, float64 size);
void cr_set_font_matrix(cr_t* cr, const cr_matrix_t* matrix);
void cr_get_font_matrix(cr_t* cr, cr_matrix_t* matrix);
void cr_set_font_options(cr_t* cr, const cr_font_options_t* options);
void cr_get_font_options(cr_t* cr, cr_font_options_t* options);
void cr_set_font_face(cr_t* cr, cr_font_face_t* font_face);
cr_font_face_t* cr_get_font_face(cr_t* cr);
void cr_set_scaled_font(cr_t* cr, const cr_scaled_font_t* scaled_font);
cr_scaled_font_t* cr_get_scaled_font(cr_t* cr);
void cr_show_text(cr_t* cr, const char* utf8);
void cr_show_glyphs(cr_t* cr, const cr_glyph_t* glyphs, int32 num_glyphs);
void cr_text_path(cr_t* cr, const char* utf8);
void cr_glyph_path(cr_t* cr, const cr_glyph_t* glyphs, int32 num_glyphs);
void cr_text_extents(cr_t* cr, const char* utf8, cr_text_extents_t* extents);
void cr_glyph_extents(cr_t* cr, const cr_glyph_t* glyphs, int32 num_glyphs, cr_text_extents_t* extents);
void cr_font_extents(cr_t* cr, cr_font_extents_t* extents);

cr_font_face_t* cr_font_face_reference(cr_font_face_t* font_face);
void cr_font_face_destroy(cr_font_face_t* font_face);
uint32 cr_font_face_get_reference_count(cr_font_face_t* font_face);
cr_status_t cr_font_face_status(cr_font_face_t* font_face);
cr_font_type_t cr_font_face_get_type(cr_font_face_t* font_face);
void* cr_font_face_get_user_data(cr_font_face_t* font_face, const cr_user_data_key_t* key);
cr_status_t cr_font_face_set_user_data(cr_font_face_t* font_face, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy);

cr_scaled_font_t* cr_scaled_font_create(cr_font_face_t* font_face, const cr_matrix_t* font_matrix, const cr_matrix_t* ctm, const cr_font_options_t* options);
cr_scaled_font_t* cr_scaled_font_reference(cr_scaled_font_t* scaled_font);
void cr_scaled_font_destroy(cr_scaled_font_t* scaled_font);
uint32 cr_scaled_font_get_reference_count(cr_scaled_font_t* scaled_font);
cr_status_t cr_scaled_font_status(cr_scaled_font_t* scaled_font);
cr_font_type_t cr_scaled_font_get_type(cr_scaled_font_t* scaled_font);
void* cr_scaled_font_get_user_data(cr_scaled_font_t* scaled_font, const cr_user_data_key_t* key);
cr_status_t cr_scaled_font_set_user_data(cr_scaled_font_t* scaled_font, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy);
void cr_scaled_font_extents(cr_scaled_font_t* scaled_font, cr_font_extents_t* extents);
void cr_scaled_font_text_extents(cr_scaled_font_t* scaled_font, const char* utf8, cr_text_extents_t* extents);
void cr_scaled_font_glyph_extents(cr_scaled_font_t* scaled_font, const cr_glyph_t* glyphs, int32 num_glyphs, cr_text_extents_t* extents);
cr_status_t cr_scaled_font_text_to_glyphs (cr_scaled_font_t* scaled_font, float64 x, float64 y,
                            const char* utf8, int32 utf8_len, cr_glyph_t** glyphs, int32* num_glyphs);
cr_font_face_t* cr_scaled_font_get_font_face(cr_scaled_font_t* scaled_font);
void cr_scaled_font_get_font_matrix(cr_scaled_font_t* scaled_font, cr_matrix_t* font_matrix);
void cr_scaled_font_get_ctm(cr_scaled_font_t* scaled_font, cr_matrix_t* ctm);
void cr_scaled_font_get_scale_matrix(cr_scaled_font_t* scaled_font, cr_matrix_t* scale_matrix);
void cr_scaled_font_get_font_options(cr_scaled_font_t* scaled_font, cr_font_options_t* options);

cr_operator_t cr_get_operator(cr_t* cr);
cr_pattern_t* cr_get_source(cr_t* cr);
float64 cr_get_tolerance(cr_t* cr);
cr_antialias_t cr_get_antialias(cr_t* cr);
cr_bool_t cr_has_current_point(cr_t* cr);
void cr_get_current_point(cr_t* cr, float64* x, float64* y);
cr_fill_rule_t cr_get_fill_rule(cr_t* cr);
float64 cr_get_line_width(cr_t* cr);
cr_line_cap_t cr_get_line_cap(cr_t* cr);
cr_line_join_t cr_get_line_join(cr_t* cr);
float64 cr_get_miter_limit(cr_t* cr);
int32 cr_get_dash_count(cr_t* cr);
void cr_get_dash(cr_t* cr, float64* dashes, float64* offset);
void cr_get_matrix(cr_t* cr, cr_matrix_t* matrix);
cr_surface_t* cr_get_target(cr_t* cr);
cr_surface_t* cr_get_group_target(cr_t* cr);

cr_path_t* cr_copy_path(cr_t* cr);
cr_path_t* cr_copy_path_flat(cr_t* cr);
void cr_append_path(cr_t* cr, const cr_path_t* path);
void cr_path_destroy(cr_path_t* path);

cr_status_t cr_status(cr_t* cr);
const char* cr_status_to_string(cr_status_t status);

cr_surface_t* cr_surface_create_similar(cr_surface_t* other, cr_content_t content, int32 width, int32 height);
cr_surface_t* cr_surface_create_similar_image(cr_surface_t* other, cr_format_t format, int32 width, int32 height);
cr_surface_t* cr_surface_map_to_image(cr_surface_t* surface, const cr_rectangle_int_t* extents);
void cr_surface_unmap_image(cr_surface_t* surface, cr_surface_t* image);
cr_surface_t* cr_surface_create_for_rectangle(cr_surface_t* target, float64 x, float64 y, float64 width, float64 height);
cr_surface_t* cr_surface_reference(cr_surface_t* surface);
void cr_surface_finish(cr_surface_t* surface);
void cr_surface_destroy(cr_surface_t* surface);
cr_device_t* cr_surface_get_device(cr_surface_t* surface);
uint32 cr_surface_get_reference_count(cr_surface_t* surface);
cr_status_t cr_surface_status(cr_surface_t* surface);
cr_surface_type_t cr_surface_get_type(cr_surface_t* surface);
cr_content_t cr_surface_get_content(cr_surface_t* surface);
cr_status_t cr_surface_write_to_png(cr_surface_t* surface, const char* filename);
void* cr_surface_get_user_data(cr_surface_t* surface, const cr_user_data_key_t* key);
cr_status_t cr_surface_set_user_data(cr_surface_t* surface, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy);
cr_surface_t* cr_image_surface_create(cr_format_t format, int32 width, int32 height);
int32 cr_format_stride_for_width(cr_format_t format, int32 width);
cr_surface_t* cr_image_surface_create_for_data(uint8* data, cr_format_t format, int32 width, int32 height, int32 stride);
uint8* cr_image_surface_get_data(cr_surface_t* surface);
cr_format_t cr_image_surface_get_format(cr_surface_t* surface);
int32 cr_image_surface_get_width(cr_surface_t* surface);
int32 cr_image_surface_get_height(cr_surface_t* surface);
int32 cr_image_surface_get_stride(cr_surface_t* surface);
cr_pattern_t* cr_pattern_create_rgb(float64 red, float64 green, float64 blue);
cr_pattern_t* cr_pattern_create_rgba(float64 red, float64 green, float64 blue, float64 alpha);
cr_pattern_t* cr_pattern_create_for_surface(cr_surface_t* surface);
cr_pattern_t* cr_pattern_create_linear(float64 x0, float64 y0, float64 x1, float64 y1);
cr_pattern_t* cr_pattern_create_radial(float64 cx0, float64 cy0, float64 radius0, float64 cx1, float64 cy1, float64 radius1);
cr_pattern_t* cr_pattern_create_mesh(void);
cr_pattern_t* cr_pattern_reference(cr_pattern_t* pattern);
void cr_pattern_destroy(cr_pattern_t* pattern);
uint32 cr_pattern_get_reference_count(cr_pattern_t* pattern);
cr_status_t cr_pattern_status(cr_pattern_t* pattern);
void* cr_pattern_get_user_data(cr_pattern_t* pattern, const cr_user_data_key_t* key);
cr_status_t cr_pattern_set_user_data(cr_pattern_t* pattern, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy);
cr_pattern_type_t cr_pattern_get_type(cr_pattern_t* pattern);
void cr_pattern_add_color_stop_rgb(cr_pattern_t* pattern, float64 offset, float64 red, float64 green, float64 blue);
void cr_pattern_add_color_stop_rgba(cr_pattern_t* pattern, float64 offset, float64 red, float64 green, float64 blue, float64 alpha);
void cr_pattern_set_matrix(cr_pattern_t* pattern, const cr_matrix_t* matrix);
void cr_pattern_get_matrix(cr_pattern_t* pattern, cr_matrix_t* matrix);
void cr_pattern_set_extend(cr_pattern_t* pattern, cr_extend_t extend);
cr_extend_t cr_pattern_get_extend(cr_pattern_t* pattern);

void cr_matrix_init(cr_matrix_t* matrix, float64 xx, float64 yx, float64 xy, float64 yy, float64 x0, float64 y0);
void cr_matrix_init_identity(cr_matrix_t* matrix);
void cr_matrix_init_translate(cr_matrix_t* matrix, float64 tx, float64 ty);
void cr_matrix_init_scale(cr_matrix_t* matrix, float64 sx, float64 sy);
void cr_matrix_init_rotate(cr_matrix_t* matrix, float64 radians);
void cr_matrix_translate(cr_matrix_t* matrix, float64 tx, float64 ty);
void cr_matrix_scale(cr_matrix_t* matrix, float64 sx, float64 sy);
void cr_matrix_rotate(cr_matrix_t* matrix, float64 radians);
cr_status_t cr_matrix_invert(cr_matrix_t* matrix);
void cr_matrix_multiply(cr_matrix_t* result, const cr_matrix_t* a, const cr_matrix_t* b);
void cr_matrix_transform_distance(const cr_matrix_t* matrix, float64* dx, float64* dy);
void cr_matrix_transform_point(const cr_matrix_t* matrix, float64* x, float64* y);

cr_region_t* cr_region_create(void);
cr_region_t* cr_region_create_rectangle(const cr_rectangle_int_t* rectangle);
cr_region_t* cr_region_create_rectangles(const cr_rectangle_int_t* rects, int32 count);
cr_region_t* cr_region_copy(const cr_region_t* original);
cr_region_t* cr_region_reference(cr_region_t* region);
void cr_region_destroy(cr_region_t* region);
cr_bool_t cr_region_equal(const cr_region_t* a, const cr_region_t* b);
cr_status_t cr_region_status(const cr_region_t* region);
void cr_region_get_extents(const cr_region_t* region, cr_rectangle_int_t* extents);
int32 cr_region_num_rectangles(const cr_region_t* region);
void cr_region_get_rectangle(const cr_region_t* region, int32 nth, cr_rectangle_int_t* rectangle);
cr_bool_t cr_region_is_empty(const cr_region_t* region);
cr_region_overlap_t cr_region_contains_rectangle(const cr_region_t* region, const cr_rectangle_int_t* rectangle);
cr_bool_t cr_region_contains_point(const cr_region_t* region, int32 x, int32 y);
void cr_region_translate(cr_region_t* region, int32 dx, int32 dy);
cr_status_t cr_region_subtract(cr_region_t* dst, const cr_region_t* other);
cr_status_t cr_region_subtract_rectangle(cr_region_t* dst, const cr_rectangle_int_t* rectangle);
cr_status_t cr_region_intersect(cr_region_t* dst, const cr_region_t* other);
cr_status_t cr_region_intersect_rectangle(cr_region_t* dst, const cr_rectangle_int_t* rectangle);
cr_status_t cr_region_union(cr_region_t* dst, const cr_region_t* other);
cr_status_t cr_region_union_rectangle(cr_region_t* dst, const cr_rectangle_int_t* rectangle);
cr_status_t cr_region_xor(cr_region_t* dst, const cr_region_t* other);
cr_status_t cr_region_xor_rectangle(cr_region_t* dst, const cr_rectangle_int_t* rectangle);

void cr_debug_reset_static_data(void);

bool cr_write_to_png(cr_t* cr, const char* filename);

class ExCairo {
public:
    struct Face {
        cr_font_face_t* crf;
        ft_face_t* ftFace;

        static void finiFtLib();
        static void initFtLib();

        bool load(const char* path, const char* name);
        void free();
    };

    struct Color {
        float64 a, r, g, b;

        Color() {}
        Color(float64 f) : a(f), r(f), g(f), b(f) {}
        Color(float64 r, float64 g, float64 b) : a(1.), r(r), g(g), b(b) {}
        Color(float64 r, float64 g, float64 b, float64 a) : a(a), r(r), g(g), b(b) {}

        void set(float64 r, float64 g, float64 b) {
            this->r = r; this->g = g; this->b = b; this->a = 1.;
        }
        void set(float64 r, float64 g, float64 b, float64 a) {
            this->r = r; this->g = g; this->b = b; this->a = a;
        }
        void setv(uint8 r, uint8 g, uint8 b) {
            this->r = FD8V(r); this->g = FD8V(g); this->b = FD8V(b); this->a = 1.;
        }
        void setv(uint8 r, uint8 g, uint8 b, uint8 a) {
            this->r = FD8V(r); this->g = FD8V(g); this->b = FD8V(b); this->a = FD8V(a);
        }
        void setv(uint32 rgb) {
            setv(rgb >> 16, rgb >> 8, rgb);
        }
    };

    struct Point {
        float64 x, y;

        Point() {}
        Point(float64 f) : x(f), y(f) {}
        Point(float64 x, float64 y) : x(x), y(y) {}
        Point(int32 x, int32 y) : x((float64)x), y((float64)y) {}

        void set(float64 x, float64 y) { this->x = x; this->y = y; }
        void set(int32 x, int32 y) { this->x = (float64)x; this->y = (float64)y; }
    };

    struct Size {
        float64 w, h;

        Size() {}
        Size(float64 f) : w(f), h(f) {}
        Size(float64 w, float64 h) : w(w), h(h) {}
        Size(int32 w, int32 h) : w((float64)w), h((float64)h) {}

        void set(float64 w, float64 h) { this->w = w; this->h = h; }
        void set(int32 w, int32 h) { this->w = (float64)w; this->h = (float64)h; }
    };

    struct Rect {
        union {
            struct { float64 x, y, w, h; };
            struct { Point pt; Size sz; } u;
        };

        Rect() {}
        Rect(ExRect rc) : x((float64)rc.x), y((float64)rc.y), w((float64)rc.w), h((float64)rc.h) {}
        Rect(int32 x, int32 y, int32 w, int32 h) : x((float64)x), y((float64)y), w((float64)w), h((float64)h) {}
        Rect(float64 x, float64 y, float64 w, float64 h) : x(x), y(y), w(w), h(h) {}

        void set(ExRect rc) {
            this->x = (float64)rc.x; this->y = (float64)rc.y; this->w = (float64)rc.w; this->h = (float64)rc.h;
        }
        void set(int32 x, int32 y, int32 w, int32 h) {
            this->x = (float64)x; this->y = (float64)y; this->w = (float64)w; this->h = (float64)h;
        }
        void set(float64 x, float64 y, float64 w, float64 h) {
            this->x = x; this->y = y; this->w = w; this->h = h;
        }
        Point p2() const { return Point(x + w, y + h); }
    };

    struct Box {
        union {
            struct { float64 l, t, r, b; };
            struct { Point p1, p2; } u;
        };

        Box() {}
        Box(ExBox bx) : l((float64)bx.l), t((float64)bx.t), r((float64)bx.r), b((float64)bx.b) {}
        Box(int32 l, int32 t, int32 r, int32 b) : l((float64)l), t((float64)t), r((float64)r), b((float64)b) {}
        Box(float64 l, float64 t, float64 r, float64 b) : l(l), t(t), r(r), b(b) {}

        float64 width() const { return r - l; }
        float64 height() const { return b - t; }

        void set(ExBox bx) {
            this->l = (float64)bx.l; this->t = (float64)bx.t; this->r = (float64)bx.r; this->b = (float64)bx.b;
        }
        void set(int32 l, int32 t, int32 r, int32 b) {
            this->l = (float64)l; this->t = (float64)t; this->r = (float64)r; this->b = (float64)b;
        }
        void set(float64 l, float64 t, float64 r, float64 b) {
            this->l = l; this->t = t; this->r = r; this->b = b;
        }
    };

protected:
    const ExCanvas* const canvas;
    void set_region(const ExRegion* srcrgn);
public:
    ~ExCairo();
    ExCairo(const ExCanvas* canvas, const ExRegion* damage);
public:
    operator cr_t* const () const;

    void fill_rect_rgba(const Rect& r, const Color& c);
    void fill_rect_rgba(float64 x, float64 y, float64 w, float64 h, const Color& c);

    static void text_extent(cr_t* cr, cr_font_face_t* crf, float64 size,
                            const char* utf8, cr_text_extents_t* te);

    enum {
        Left    = 1 << 0,
        Right   = 2 << 0,
        Center  = 0 << 0,
        Top     = 1 << 2,
        Bottom  = 2 << 2,
        VCenter = 0 << 2,
    };
    static Point text_align(const cr_font_extents_t& fe, const cr_text_extents_t& te,
                            const Rect& r, uint32 align = 0);

    Point text_align(const char* utf8, const Rect& r, uint32 align = 0);

    void show_text(const char* utf8, const Color& c, const Rect& r, uint32 align = 0);

    void show_text(const char* utf8, const Color& c, const Point& p);

    void show_text(const char* utf8, float64 r, float64 g, float64 b, float64 x, float64 y);

    void set_font(cr_font_face_t* font, float64 size);
};

#pragma pack(pop)

#endif//__excairo_h__
