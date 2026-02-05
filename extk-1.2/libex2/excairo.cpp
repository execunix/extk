/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "excairo.h"
#include "excanvas.h"
#include <ft2build.h>
#include <cairo/cairo-ft.h>
#include <cairo/cairo.h>
#include FT_FREETYPE_H

cr_t* cr_create(cr_surface_t* target)
{
    return cairo_create(target);
}

cr_t* cr_reference(cr_t* cr)
{
    return cairo_reference(cr);
}

void cr_destroy(cr_t* cr)
{
    cairo_destroy(cr);
}

uint32 cr_get_reference_count(cr_t* cr)
{
    return cairo_get_reference_count(cr);
}

void* cr_get_user_data(cr_t* cr, const cr_user_data_key_t* key)
{
    return cairo_get_user_data(cr, reinterpret_cast<const cairo_user_data_key_t*>(key));
}

cr_status_t cr_set_user_data(cr_t* cr, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy)
{
    cairo_status_t status;
    status = cairo_set_user_data(cr, reinterpret_cast<const cairo_user_data_key_t*>(key), user_data, destroy);
    return static_cast<cr_status_t>(status);
}

void cr_save(cr_t* cr)
{
    cairo_save(cr);
}

void cr_restore(cr_t* cr)
{
    cairo_restore(cr);
}

void cr_push_group(cr_t* cr)
{
    cairo_push_group(cr);
}

void cr_push_group_with_content(cr_t* cr, cr_content_t content)
{
    cairo_push_group_with_content(cr, static_cast<cairo_content_t>(content));
}

cr_pattern_t* cr_pop_group(cr_t* cr)
{
    return cairo_pop_group(cr);
}

void cr_pop_group_to_source(cr_t* cr)
{
    cairo_pop_group_to_source(cr);
}

void cr_set_operator(cr_t* cr, cr_operator_t op)
{
    cairo_set_operator(cr, static_cast<cairo_operator_t>(op));
}

void cr_set_source(cr_t* cr, cr_pattern_t* source)
{
    cairo_set_source(cr, source);
}

void cr_set_source_rgb(cr_t* cr, float64 red, float64 green, float64 blue)
{
    cairo_set_source_rgb(cr, red, green, blue);
}

void cr_set_source_rgba(cr_t* cr, float64 red, float64 green, float64 blue, float64 alpha)
{
    cairo_set_source_rgba(cr, red, green, blue, alpha);
}

void cr_set_source_surface(cr_t* cr, cr_surface_t* surface, float64 x, float64 y)
{
    cairo_set_source_surface(cr, surface, x, y);
}

void cr_set_tolerance(cr_t* cr, float64 tolerance)
{
    cairo_set_tolerance(cr, tolerance);
}

void cr_set_antialias(cr_t* cr, cr_antialias_t antialias)
{
    cairo_set_antialias(cr, static_cast<cairo_antialias_t>(antialias));
}

void cr_set_fill_rule(cr_t* cr, cr_fill_rule_t fill_rule)
{
    cairo_set_fill_rule(cr, static_cast<cairo_fill_rule_t>(fill_rule));
}

void cr_set_line_width(cr_t* cr, float64 width)
{
    cairo_set_line_width(cr, width);
}

void cr_set_line_cap(cr_t* cr, cr_line_cap_t line_cap)
{
    cairo_set_line_cap(cr, static_cast<cairo_line_cap_t>(line_cap));
}

void cr_set_line_join(cr_t* cr, cr_line_join_t line_join)
{
    cairo_set_line_join(cr, static_cast<cairo_line_join_t>(line_join));
}

void cr_set_dash(cr_t* cr, const float64* dashes, int32 num_dashes, float64 offset)
{
    cairo_set_dash(cr, dashes, num_dashes, offset);
}

void cr_set_miter_limit(cr_t* cr, float64 limit)
{
    cairo_set_miter_limit(cr, limit);
}

void cr_translate(cr_t* cr, float64 tx, float64 ty)
{
    cairo_translate(cr, tx, ty);
}

void cr_scale(cr_t* cr, float64 sx, float64 sy)
{
    cairo_scale(cr, sx, sy);
}

void cr_rotate(cr_t* cr, float64 angle)
{
    cairo_rotate(cr, angle);
}

void cr_transform(cr_t* cr, const cr_matrix_t* matrix)
{
    cairo_transform(cr, reinterpret_cast<const cairo_matrix_t*>(matrix));
}

void cr_set_matrix(cr_t* cr, const cr_matrix_t* matrix)
{
    cairo_set_matrix(cr, reinterpret_cast<const cairo_matrix_t*>(matrix));
}

void cr_identity_matrix(cr_t* cr)
{
    cairo_identity_matrix(cr);
}

void cr_user_to_device(cr_t* cr, float64* x, float64* y)
{
    cairo_user_to_device(cr, x, y);
}

void cr_user_to_device_distance(cr_t* cr, float64* dx, float64* dy)
{
    cairo_user_to_device_distance(cr, dx, dy);
}

void cr_device_to_user(cr_t* cr, float64* x, float64* y)
{
    cairo_device_to_user(cr, x, y);
}

void cr_device_to_user_distance(cr_t* cr, float64* dx, float64* dy)
{
    cairo_device_to_user_distance(cr, dx, dy);
}

void cr_new_path(cr_t* cr)
{
    cairo_new_path(cr);
}

void cr_move_to(cr_t* cr, float64 x, float64 y)
{
    cairo_move_to(cr, x, y);
}

void cr_new_sub_path(cr_t* cr)
{
    cairo_new_sub_path(cr);
}

void cr_line_to(cr_t* cr, float64 x, float64 y)
{
    cairo_line_to(cr, x, y);
}

void cr_curve_to(cr_t* cr, float64 x1, float64 y1, float64 x2, float64 y2, float64 x3, float64 y3)
{
    cairo_curve_to(cr, x1, y1, x2, y2, x3, y3);
}

void cr_arc(cr_t* cr, float64 xc, float64 yc, float64 radius, float64 angle1, float64 angle2)
{
    cairo_arc(cr, xc, yc, radius, angle1, angle2);
}

void cr_arc_negative(cr_t* cr, float64 xc, float64 yc, float64 radius, float64 angle1, float64 angle2)
{
    cairo_arc_negative(cr, xc, yc, radius, angle1, angle2);
}

void cr_rel_move_to(cr_t* cr, float64 dx, float64 dy)
{
    cairo_rel_move_to(cr, dx, dy);
}

void cr_rel_line_to(cr_t* cr, float64 dx, float64 dy)
{
    cairo_rel_line_to(cr, dx, dy);
}

void cr_rel_curve_to(cr_t* cr, float64 dx1, float64 dy1, float64 dx2, float64 dy2, float64 dx3, float64 dy3)
{
    cairo_rel_curve_to(cr, dx1, dy1, dx2, dy2, dx3, dy3);
}

void cr_rectangle(cr_t* cr, float64 x, float64 y, float64 width, float64 height)
{
    cairo_rectangle(cr, x, y, width, height);
}

void cr_close_path(cr_t* cr)
{
    cairo_close_path(cr);
}

void cr_path_extents(cr_t* cr, float64* x1, float64* y1, float64* x2, float64* y2)
{
    cairo_path_extents(cr, x1, y1, x2, y2);
}

void cr_paint(cr_t* cr)
{
    cairo_paint(cr);
}

void cr_paint_with_alpha(cr_t* cr, float64 alpha)
{
    cairo_paint_with_alpha(cr, alpha);
}

void cr_mask(cr_t* cr, cr_pattern_t* pattern)
{
    cairo_mask(cr, pattern);
}

void cr_mask_surface(cr_t* cr, cr_surface_t* surface, float64 surface_x, float64 surface_y)
{
    cairo_mask_surface(cr, surface, surface_x, surface_y);
}

void cr_stroke(cr_t* cr)
{
    cairo_stroke(cr);
}

void cr_stroke_preserve(cr_t* cr)
{
    cairo_stroke_preserve(cr);
}

void cr_fill(cr_t* cr)
{
    cairo_fill(cr);
}

void cr_fill_preserve(cr_t* cr)
{
    cairo_fill_preserve(cr);
}

void cr_copy_page(cr_t* cr)
{
    cairo_copy_page(cr);
}

void cr_show_page(cr_t* cr)
{
    cairo_show_page(cr);
}

cr_bool_t cr_in_stroke(cr_t* cr, float64 x, float64 y)
{
    return cairo_in_stroke(cr, x, y);
}

cr_bool_t cr_in_fill(cr_t* cr, float64 x, float64 y)
{
    return cairo_in_fill(cr, x, y);
}

cr_bool_t cr_in_clip(cr_t* cr, float64 x, float64 y)
{
    return cairo_in_clip(cr, x, y);
}

void cr_stroke_extents(cr_t* cr, float64* x1, float64* y1, float64* x2, float64* y2)
{
    cairo_stroke_extents(cr, x1, y1, x2, y2);
}

void cr_fill_extents(cr_t* cr, float64* x1, float64* y1, float64* x2, float64* y2)
{
    cairo_fill_extents(cr, x1, y1, x2, y2);
}

void cr_reset_clip(cr_t* cr)
{
    cairo_reset_clip(cr);
}

void cr_clip(cr_t* cr)
{
    cairo_clip(cr);
}

void cr_clip_preserve(cr_t* cr)
{
    cairo_clip_preserve(cr);
}

void cr_clip_extents(cr_t* cr, float64* x1, float64* y1, float64* x2, float64* y2)
{
    cairo_clip_extents(cr, x1, y1, x2, y2);
}

cr_rectangle_list_t* cr_copy_clip_rectangle_list(cr_t* cr)
{
    cairo_rectangle_list_t* rectangle_list;
    rectangle_list = cairo_copy_clip_rectangle_list(cr);
    return reinterpret_cast<cr_rectangle_list_t*>(rectangle_list);
}

void cr_rectangle_list_destroy(cr_rectangle_list_t* rectangle_list)
{
    cairo_rectangle_list_destroy(reinterpret_cast<cairo_rectangle_list_t*>(rectangle_list));
}

cr_glyph_t* cr_glyph_allocate(int32 num_glyphs)
{
    cairo_glyph_t* glyph;
    glyph = cairo_glyph_allocate(num_glyphs);
    return reinterpret_cast<cr_glyph_t*>(glyph);
}

void cr_glyph_free(cr_glyph_t* glyphs)
{
    cairo_glyph_free(reinterpret_cast<cairo_glyph_t*>(glyphs));
}

cr_text_cluster_t* cr_text_cluster_allocate(int32 num_clusters)
{
    cairo_text_cluster_t* text_cluster;
    text_cluster = cairo_text_cluster_allocate(num_clusters);
    return reinterpret_cast<cr_text_cluster_t*>(text_cluster);
}

void cr_text_cluster_free(cr_text_cluster_t* clusters)
{
    cairo_text_cluster_free(reinterpret_cast<cairo_text_cluster_t*>(clusters));
}

cr_font_options_t* cr_font_options_create(void)
{
    return cairo_font_options_create();
}

cr_font_options_t* cr_font_options_copy(const cr_font_options_t* original)
{
    return cairo_font_options_copy(original);
}

void cr_font_options_destroy(cr_font_options_t* options)
{
    cairo_font_options_destroy(options);
}

cr_status_t cr_font_options_status(cr_font_options_t* options)
{
    cairo_status_t status;
    status = cairo_font_options_status(options);
    return static_cast<cr_status_t>(status);
}

void cr_font_options_merge(cr_font_options_t* options, const cr_font_options_t* other)
{
    cairo_font_options_merge(options, other);
}

cr_bool_t cr_font_options_equal(const cr_font_options_t* options, const cr_font_options_t* other)
{
    return cairo_font_options_equal(options, other);
}

uint64 cr_font_options_hash(const cr_font_options_t* options)
{
    return cairo_font_options_hash(options);
}

void cr_font_options_set_antialias(cr_font_options_t* options, cr_antialias_t antialias)
{
    cairo_font_options_set_antialias(options, static_cast<cairo_antialias_t>(antialias));
}

cr_antialias_t cr_font_options_get_antialias(const cr_font_options_t* options)
{
    cairo_antialias_t antialias;
    antialias = cairo_font_options_get_antialias(options);
    return static_cast<cr_antialias_t>(antialias);
}

void cr_font_options_set_subpixel_order(cr_font_options_t* options, cr_subpixel_order_t subpixel_order)
{
    cairo_font_options_set_subpixel_order(options, static_cast<cairo_subpixel_order_t>(subpixel_order));
}

cr_subpixel_order_t cr_font_options_get_subpixel_order(const cr_font_options_t* options)
{
    cairo_subpixel_order_t subpixel_order;
    subpixel_order = cairo_font_options_get_subpixel_order(options);
    return static_cast<cr_subpixel_order_t>(subpixel_order);
}

void cr_font_options_set_hint_style(cr_font_options_t* options, cr_hint_style_t hint_style)
{
    cairo_font_options_set_hint_style(options, static_cast<cairo_hint_style_t>(hint_style));
}

cr_hint_style_t cr_font_options_get_hint_style(const cr_font_options_t* options)
{
    cairo_hint_style_t hint_style;
    hint_style = cairo_font_options_get_hint_style(options);
    return static_cast<cr_hint_style_t>(hint_style);
}

void cr_font_options_set_hint_metrics(cr_font_options_t* options, cr_hint_metrics_t hint_metrics)
{
    cairo_font_options_set_hint_metrics(options, static_cast<cairo_hint_metrics_t>(hint_metrics));
}

cr_hint_metrics_t cr_font_options_get_hint_metrics(const cr_font_options_t* options)
{
    cairo_hint_metrics_t hint_metrics;
    hint_metrics = cairo_font_options_get_hint_metrics(options);
    return static_cast<cr_hint_metrics_t>(hint_metrics);
}
void cr_select_font_face(cr_t* cr, const char* family, cr_font_slant_t slant, cr_font_weight_t weight)
{
    cairo_select_font_face(cr, family, static_cast<cairo_font_slant_t>(slant), static_cast<cairo_font_weight_t>(weight));
}

void cr_set_font_size(cr_t* cr, float64 size)
{
    cairo_set_font_size(cr, size);
}

void cr_set_font_matrix(cr_t* cr, const cr_matrix_t* matrix)
{
    cairo_set_font_matrix(cr, reinterpret_cast<const cairo_matrix_t*>(matrix));
}

void cr_get_font_matrix(cr_t* cr, cr_matrix_t* matrix)
{
    cairo_get_font_matrix(cr, reinterpret_cast<cairo_matrix_t*>(matrix));
}

void cr_set_font_options(cr_t* cr, const cr_font_options_t* options)
{
    cairo_set_font_options(cr, options);
}

void cr_get_font_options(cr_t* cr, cr_font_options_t* options)
{
    cairo_get_font_options(cr, options);
}

void cr_set_font_face(cr_t* cr, cr_font_face_t* font_face)
{
    cairo_set_font_face(cr, font_face);
}

cr_font_face_t* cr_get_font_face(cr_t* cr)
{
    return cairo_get_font_face(cr);
}

void cr_set_scaled_font(cr_t* cr, const cr_scaled_font_t* scaled_font)
{
    cairo_set_scaled_font(cr, scaled_font);
}

cr_scaled_font_t* cr_get_scaled_font(cr_t* cr)
{
    return cairo_get_scaled_font(cr);
}

void cr_show_text(cr_t* cr, const char* utf8)
{
    cairo_show_text(cr, utf8);
}

void cr_show_glyphs(cr_t* cr, const cr_glyph_t* glyphs, int32 num_glyphs)
{
    cairo_show_glyphs(cr, reinterpret_cast<const cairo_glyph_t*>(glyphs), num_glyphs);
}

void cr_text_path(cr_t* cr, const char* utf8)
{
    cairo_text_path(cr, utf8);
}

void cr_glyph_path(cr_t* cr, const cr_glyph_t* glyphs, int32 num_glyphs)
{
    cairo_glyph_path(cr, reinterpret_cast<const cairo_glyph_t*>(glyphs), num_glyphs);
}

void cr_text_extents(cr_t* cr, const char* utf8, cr_text_extents_t* extents)
{
    cairo_text_extents(cr, utf8, reinterpret_cast<cairo_text_extents_t*>(extents));
}

void cr_glyph_extents(cr_t* cr, const cr_glyph_t* glyphs, int32 num_glyphs, cr_text_extents_t* extents)
{
    cairo_glyph_extents(cr, reinterpret_cast<const cairo_glyph_t*>(glyphs), num_glyphs, reinterpret_cast<cairo_text_extents_t*>(extents));
}

void cr_font_extents(cr_t* cr, cr_font_extents_t* extents)
{
    cairo_font_extents(cr, reinterpret_cast<cairo_font_extents_t*>(extents));
}

cr_font_face_t* cr_font_face_reference(cr_font_face_t* font_face)
{
    return cairo_font_face_reference(font_face);
}

void cr_font_face_destroy(cr_font_face_t* font_face)
{
    cairo_font_face_destroy(font_face);
}

uint32 cr_font_face_get_reference_count(cr_font_face_t* font_face)
{
    return cairo_font_face_get_reference_count(font_face);
}

cr_status_t cr_font_face_status(cr_font_face_t* font_face)
{
    cairo_status_t status;
    status = cairo_font_face_status(font_face);
    return static_cast<cr_status_t>(status);
}

cr_font_type_t cr_font_face_get_type(cr_font_face_t* font_face)
{
    cairo_font_type_t font_type;
    font_type = cairo_font_face_get_type(font_face);
    return static_cast<cr_font_type_t>(font_type);
}

void* cr_font_face_get_user_data(cr_font_face_t* font_face, const cr_user_data_key_t* key)
{
    return cairo_font_face_get_user_data(font_face, reinterpret_cast<const cairo_user_data_key_t*>(key));
}

cr_status_t cr_font_face_set_user_data(cr_font_face_t* font_face, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy)
{
    cairo_status_t status;
    status = cairo_font_face_set_user_data(font_face, reinterpret_cast<const cairo_user_data_key_t*>(key), user_data, destroy);
    return static_cast<cr_status_t>(status);
}

cr_scaled_font_t* cr_scaled_font_create(cr_font_face_t* font_face, const cr_matrix_t* font_matrix, const cr_matrix_t* ctm, const cr_font_options_t* options)
{
    return cairo_scaled_font_create(font_face, reinterpret_cast<const cairo_matrix_t*>(font_matrix), reinterpret_cast<const cairo_matrix_t*>(ctm), options);
}

cr_scaled_font_t* cr_scaled_font_reference(cr_scaled_font_t* scaled_font)
{
    return cairo_scaled_font_reference(scaled_font);
}

void cr_scaled_font_destroy(cr_scaled_font_t* scaled_font)
{
    cairo_scaled_font_destroy(scaled_font);
}

uint32 cr_scaled_font_get_reference_count(cr_scaled_font_t* scaled_font)
{
    return cairo_scaled_font_get_reference_count(scaled_font);
}

cr_status_t cr_scaled_font_status(cr_scaled_font_t* scaled_font)
{
    cairo_status_t status;
    status = cairo_scaled_font_status(scaled_font);
    return static_cast<cr_status_t>(status);
}

cr_font_type_t cr_scaled_font_get_type(cr_scaled_font_t* scaled_font)
{
    cairo_font_type_t font_type;
    font_type = cairo_scaled_font_get_type(scaled_font);
    return static_cast<cr_font_type_t>(font_type);
}

void* cr_scaled_font_get_user_data(cr_scaled_font_t* scaled_font, const cr_user_data_key_t* key)
{
    return cairo_scaled_font_get_user_data(scaled_font, reinterpret_cast<const cairo_user_data_key_t*>(key));
}

cr_status_t cr_scaled_font_set_user_data(cr_scaled_font_t* scaled_font, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy)
{
    cairo_status_t status;
    status = cairo_scaled_font_set_user_data(scaled_font, reinterpret_cast<const cairo_user_data_key_t*>(key), user_data, destroy);
    return static_cast<cr_status_t>(status);
}

void cr_scaled_font_extents(cr_scaled_font_t* scaled_font, cr_font_extents_t* extents)
{
    cairo_scaled_font_extents(scaled_font, reinterpret_cast<cairo_font_extents_t*>(extents));
}

void cr_scaled_font_text_extents(cr_scaled_font_t* scaled_font, const char* utf8, cr_text_extents_t* extents)
{
    cairo_scaled_font_text_extents(scaled_font, utf8, reinterpret_cast<cairo_text_extents_t*>(extents));
}

void cr_scaled_font_glyph_extents(cr_scaled_font_t* scaled_font, const cr_glyph_t* glyphs, int32 num_glyphs, cr_text_extents_t* extents)
{
    cairo_scaled_font_glyph_extents(scaled_font, reinterpret_cast<const cairo_glyph_t*>(glyphs),
            num_glyphs, reinterpret_cast<cairo_text_extents_t*>(extents));
}

cr_status_t cr_scaled_font_text_to_glyphs (cr_scaled_font_t* scaled_font, float64 x, float64 y,
                    const char* utf8, int32 utf8_len, cr_glyph_t** glyphs, int32* num_glyphs)
{
    return static_cast<cr_status_t>(cairo_scaled_font_text_to_glyphs(scaled_font, x, y,
                                        utf8, utf8_len, reinterpret_cast<cairo_glyph_t**>(glyphs), num_glyphs, NULL, NULL, NULL));
}

cr_font_face_t* cr_scaled_font_get_font_face(cr_scaled_font_t* scaled_font)
{
    return cairo_scaled_font_get_font_face(scaled_font);
}

void cr_scaled_font_get_font_matrix(cr_scaled_font_t* scaled_font, cr_matrix_t* font_matrix)
{
    cairo_scaled_font_get_font_matrix(scaled_font, reinterpret_cast<cairo_matrix_t*>(font_matrix));
}

void cr_scaled_font_get_ctm(cr_scaled_font_t* scaled_font, cr_matrix_t* ctm)
{
    cairo_scaled_font_get_ctm(scaled_font, reinterpret_cast<cairo_matrix_t*>(ctm));
}

void cr_scaled_font_get_scale_matrix(cr_scaled_font_t* scaled_font, cr_matrix_t* scale_matrix)
{
    cairo_scaled_font_get_scale_matrix(scaled_font, reinterpret_cast<cairo_matrix_t*>(scale_matrix));
}

void cr_scaled_font_get_font_options(cr_scaled_font_t* scaled_font, cr_font_options_t* options)
{
    cairo_scaled_font_get_font_options(scaled_font, options);
}

cr_operator_t cr_get_operator(cr_t* cr)
{
    cairo_operator_t cr_operator;
    cr_operator = cairo_get_operator(cr);
    return static_cast<cr_operator_t>(cr_operator);
}

cr_pattern_t* cr_get_source(cr_t* cr)
{
    return cairo_get_source(cr);
}

float64 cr_get_tolerance(cr_t* cr)
{
    return cairo_get_tolerance(cr);
}

cr_antialias_t cr_get_antialias(cr_t* cr)
{
    cairo_antialias_t antialias;
    antialias = cairo_get_antialias(cr);
    return static_cast<cr_antialias_t>(antialias);
}

cr_bool_t cr_has_current_point(cr_t* cr)
{
    return cairo_has_current_point(cr);
}

void cr_get_current_point(cr_t* cr, float64* x, float64* y)
{
    cairo_get_current_point(cr, x, y);
}

cr_fill_rule_t cr_get_fill_rule(cr_t* cr)
{
    cairo_fill_rule_t fill_rule;
    fill_rule = cairo_get_fill_rule(cr);
    return static_cast<cr_fill_rule_t>(fill_rule);
}

float64 cr_get_line_width(cr_t* cr)
{
    return cairo_get_line_width(cr);
}

cr_line_cap_t cr_get_line_cap(cr_t* cr)
{
    cairo_line_cap_t line_cap;
    line_cap = cairo_get_line_cap(cr);
    return static_cast<cr_line_cap_t>(line_cap);
}

cr_line_join_t cr_get_line_join(cr_t* cr)
{
    cairo_line_join_t line_join;
    line_join = cairo_get_line_join(cr);
    return static_cast<cr_line_join_t>(line_join);
}

float64 cr_get_miter_limit(cr_t* cr)
{
    return cairo_get_miter_limit(cr);
}

int32 cr_get_dash_count(cr_t* cr)
{
    return cairo_get_dash_count(cr);
}

void cr_get_dash(cr_t* cr, float64* dashes, float64* offset)
{
    cairo_get_dash(cr, dashes, offset);
}

void cr_get_matrix(cr_t* cr, cr_matrix_t* matrix)
{
    cairo_get_matrix(cr, reinterpret_cast<cairo_matrix_t*>(matrix));
}

cr_surface_t* cr_get_target(cr_t* cr)
{
    return cairo_get_target(cr);
}

cr_surface_t* cr_get_group_target(cr_t* cr)
{
    return cairo_get_group_target(cr);
}

cr_path_t* cr_copy_path(cr_t* cr)
{
    return reinterpret_cast<cr_path_t*>(cairo_copy_path(cr));
}

cr_path_t* cr_copy_path_flat(cr_t* cr)
{
    return reinterpret_cast<cr_path_t*>(cairo_copy_path_flat(cr));
}

void cr_append_path(cr_t* cr, const cr_path_t* path)
{
    cairo_append_path(cr, reinterpret_cast<const cairo_path_t*>(path));
}

void cr_path_destroy(cr_path_t* path)
{
    cairo_path_destroy(reinterpret_cast<cairo_path_t*>(path));
}

cr_status_t cr_status(cr_t* cr)
{
    return static_cast<cr_status_t>(cairo_status(cr));
}

const char* cr_status_to_string(cr_status_t status)
{
    return cairo_status_to_string(static_cast<cairo_status_t>(status));
}

cr_surface_t* cr_surface_create_similar(cr_surface_t* other, cr_content_t content, int32 width, int32 height)
{
    return cairo_surface_create_similar(other, static_cast<cairo_content_t>(content), width, height);
}

cr_surface_t* cr_surface_create_similar_image(cr_surface_t* other, cr_format_t format, int32 width, int32 height)
{
    return cairo_surface_create_similar_image(other, static_cast<cairo_format_t>(format), width, height);
}

cr_surface_t* cr_surface_map_to_image(cr_surface_t* surface, const cr_rectangle_int_t* extents)
{
    return cairo_surface_map_to_image(surface, reinterpret_cast<const cairo_rectangle_int_t*>(extents));
}

void cr_surface_unmap_image(cr_surface_t* surface, cr_surface_t* image)
{
    cairo_surface_unmap_image(surface, image);
}

cr_surface_t* cr_surface_create_for_rectangle(cr_surface_t* target,
    float64 x, float64 y, float64 width, float64 height)
{
    return cairo_surface_create_for_rectangle(target, x, y, width, height);
}

cr_surface_t* cr_surface_reference(cr_surface_t* surface)
{
    return cairo_surface_reference(surface);
}

void cr_surface_finish(cr_surface_t* surface)
{
    cairo_surface_finish(surface);
}

void cr_surface_destroy(cr_surface_t* surface)
{
    cairo_surface_destroy(surface);
}

cr_device_t* cr_surface_get_device(cr_surface_t* surface)
{
    return cairo_surface_get_device(surface);
}

uint32 cr_surface_get_reference_count(cr_surface_t* surface)
{
    return cairo_surface_get_reference_count(surface);
}

cr_status_t cr_surface_status(cr_surface_t* surface)
{
    return static_cast<cr_status_t>(cairo_surface_status(surface));
}

cr_surface_type_t cr_surface_get_type(cr_surface_t* surface)
{
    return static_cast<cr_surface_type_t>(cairo_surface_get_type(surface));
}

cr_content_t cr_surface_get_content(cr_surface_t* surface)
{
    return static_cast<cr_content_t>(cairo_surface_get_content(surface));
}

cr_status_t cr_surface_write_to_png(cr_surface_t* surface, const char* filename)
{
    return static_cast<cr_status_t>(cairo_surface_write_to_png(surface, filename));
}

void* cr_surface_get_user_data(cr_surface_t* surface, const cr_user_data_key_t* key)
{
    return cairo_surface_get_user_data(surface, reinterpret_cast<const cairo_user_data_key_t*>(key));
}

cr_status_t cr_surface_set_user_data(cr_surface_t* surface, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy)
{
    return static_cast<cr_status_t>(cairo_surface_set_user_data(surface, reinterpret_cast<const cairo_user_data_key_t*>(key), user_data, destroy));
}

cr_surface_t* cr_image_surface_create(cr_format_t format, int32 width, int32 height)
{
    return cairo_image_surface_create(static_cast<cairo_format_t>(format), width, height);
}

int32 cr_format_stride_for_width(cr_format_t format, int32 width)
{
    return cairo_format_stride_for_width(static_cast<cairo_format_t>(format), width);
}

cr_surface_t* cr_image_surface_create_for_data(uint8* data,
    cr_format_t format, int32 width, int32 height, int32 stride)
{
    return cairo_image_surface_create_for_data(data, static_cast<cairo_format_t>(format), width, height, stride);
}

uint8* cr_image_surface_get_data(cr_surface_t* surface)
{
    return cairo_image_surface_get_data(surface);
}

cr_format_t cr_image_surface_get_format(cr_surface_t* surface)
{
    return static_cast<cr_format_t>(cairo_image_surface_get_format(surface));
}

int32 cr_image_surface_get_width(cr_surface_t* surface)
{
    return cairo_image_surface_get_width(surface);
}

int32 cr_image_surface_get_height(cr_surface_t* surface)
{
    return cairo_image_surface_get_height(surface);
}

int32 cr_image_surface_get_stride(cr_surface_t* surface)
{
    return cairo_image_surface_get_stride(surface);
}

cr_pattern_t* cr_pattern_create_rgb(float64 red, float64 green, float64 blue)
{
    return cairo_pattern_create_rgb(red, green, blue);
}

cr_pattern_t* cr_pattern_create_rgba(float64 red, float64 green, float64 blue, float64 alpha)
{
    return cairo_pattern_create_rgba(red, green, blue, alpha);
}

cr_pattern_t* cr_pattern_create_for_surface(cr_surface_t* surface)
{
    return cairo_pattern_create_for_surface(surface);
}

cr_pattern_t* cr_pattern_create_linear(float64 x0, float64 y0, float64 x1, float64 y1)
{
    return cairo_pattern_create_linear(x0, y0, x1, y1);
}

cr_pattern_t* cr_pattern_create_radial(float64 cx0, float64 cy0, float64 radius0, float64 cx1, float64 cy1, float64 radius1)
{
    return cairo_pattern_create_radial(cx0, cy0, radius0, cx1, cy1, radius1);
}

cr_pattern_t* cr_pattern_create_mesh(void)
{
    return cairo_pattern_create_mesh();
}

cr_pattern_t* cr_pattern_reference(cr_pattern_t* pattern)
{
    return cairo_pattern_reference(pattern);
}

void cr_pattern_destroy(cr_pattern_t* pattern)
{
    cairo_pattern_destroy(pattern);
}

uint32 cr_pattern_get_reference_count(cr_pattern_t* pattern)
{
    return cairo_pattern_get_reference_count(pattern);
}

cr_status_t cr_pattern_status(cr_pattern_t* pattern)
{
    return static_cast<cr_status_t>(cairo_pattern_status(pattern));
}

void* cr_pattern_get_user_data(cr_pattern_t* pattern, const cr_user_data_key_t* key)
{
    return cairo_pattern_get_user_data(pattern, reinterpret_cast<const cairo_user_data_key_t*>(key));
}

cr_status_t cr_pattern_set_user_data(cr_pattern_t* pattern, const cr_user_data_key_t* key, void* user_data, cr_destroy_func_t destroy)
{
    return static_cast<cr_status_t>(cairo_pattern_set_user_data(pattern, reinterpret_cast<const cairo_user_data_key_t*>(key), user_data, destroy));
}

cr_pattern_type_t cr_pattern_get_type(cr_pattern_t* pattern)
{
    return static_cast<cr_pattern_type_t>(cairo_pattern_get_type(pattern));
}

void cr_pattern_add_color_stop_rgb(cr_pattern_t* pattern, float64 offset, float64 red, float64 green, float64 blue)
{
    cairo_pattern_add_color_stop_rgb(pattern, offset, red, green, blue);
}

void cr_pattern_add_color_stop_rgba(cr_pattern_t* pattern, float64 offset, float64 red, float64 green, float64 blue, float64 alpha)
{
    cairo_pattern_add_color_stop_rgba(pattern, offset, red, green, blue, alpha);
}

void cr_pattern_set_matrix(cr_pattern_t* pattern, const cr_matrix_t* matrix)
{
    cairo_pattern_set_matrix(pattern, reinterpret_cast<const cairo_matrix_t*>(matrix));
}

void cr_pattern_get_matrix(cr_pattern_t* pattern, cr_matrix_t* matrix)
{
    cairo_pattern_get_matrix(pattern, reinterpret_cast<cairo_matrix_t*>(matrix));
}

void cr_pattern_set_extend(cr_pattern_t* pattern, cr_extend_t extend)
{
    cairo_pattern_set_extend(pattern, static_cast<cairo_extend_t>(extend));
}

cr_extend_t cr_pattern_get_extend(cr_pattern_t* pattern)
{
    return static_cast<cr_extend_t>(cairo_pattern_get_extend(pattern));
}

void cr_matrix_init(cr_matrix_t* matrix, float64 xx, float64 yx, float64 xy, float64 yy, float64 x0, float64 y0)
{
    cairo_matrix_init(reinterpret_cast<cairo_matrix_t*>(matrix), xx, yx, xy, yy, x0, y0);
}

void cr_matrix_init_identity(cr_matrix_t* matrix)
{
    cairo_matrix_init_identity(reinterpret_cast<cairo_matrix_t*>(matrix));
}

void cr_matrix_init_translate(cr_matrix_t* matrix, float64 tx, float64 ty)
{
    cairo_matrix_init_translate(reinterpret_cast<cairo_matrix_t*>(matrix), tx, ty);
}

void cr_matrix_init_scale(cr_matrix_t* matrix, float64 sx, float64 sy)
{
    cairo_matrix_init_scale(reinterpret_cast<cairo_matrix_t*>(matrix), sx, sy);
}

void cr_matrix_init_rotate(cr_matrix_t* matrix, float64 radians)
{
    cairo_matrix_init_rotate(reinterpret_cast<cairo_matrix_t*>(matrix), radians);
}

void cr_matrix_translate(cr_matrix_t* matrix, float64 tx, float64 ty)
{
    cairo_matrix_translate(reinterpret_cast<cairo_matrix_t*>(matrix), tx, ty);
}

void cr_matrix_scale(cr_matrix_t* matrix, float64 sx, float64 sy)
{
    cairo_matrix_scale(reinterpret_cast<cairo_matrix_t*>(matrix), sx, sy);
}

void cr_matrix_rotate(cr_matrix_t* matrix, float64 radians)
{
    cairo_matrix_rotate(reinterpret_cast<cairo_matrix_t*>(matrix), radians);
}

cr_status_t cr_matrix_invert(cr_matrix_t* matrix)
{
    return static_cast<cr_status_t>(cairo_matrix_invert(reinterpret_cast<cairo_matrix_t*>(matrix)));
}

void cairo_matrix_multiply(cr_matrix_t* result, const cr_matrix_t* a, const cr_matrix_t* b)
{
    cairo_matrix_multiply(reinterpret_cast<cairo_matrix_t*>(result), reinterpret_cast<const cairo_matrix_t*>(a), reinterpret_cast<const cairo_matrix_t*>(b));
}

void cr_matrix_transform_distance(const cr_matrix_t* matrix, float64* dx, float64* dy)
{
    cairo_matrix_transform_distance(reinterpret_cast<const cairo_matrix_t*>(matrix), dx, dy);
}

void cr_matrix_transform_point(const cr_matrix_t* matrix, float64* x, float64* y)
{
    cairo_matrix_transform_point(reinterpret_cast<const cairo_matrix_t*>(matrix), x, y);
}

cr_region_t* cr_region_create(void)
{
    return cairo_region_create();
}

cr_region_t* cr_region_create_rectangle(const cr_rectangle_int_t* rectangle)
{
    return cairo_region_create_rectangle(reinterpret_cast<const cairo_rectangle_int_t*>(rectangle));
}

cr_region_t* cr_region_create_rectangles(const cr_rectangle_int_t* rects, int32 count)
{
    return cairo_region_create_rectangles(reinterpret_cast<const cairo_rectangle_int_t*>(rects), count);
}

cr_region_t* cr_region_copy(const cr_region_t* original)
{
    return cairo_region_copy(original);
}

cr_region_t* cr_region_reference(cr_region_t* region)
{
    return cairo_region_reference(region);
}

void cr_region_destroy(cr_region_t* region)
{
    cairo_region_destroy(region);
}

cr_bool_t cr_region_equal(const cr_region_t* a, const cr_region_t* b)
{
    return cairo_region_equal(a, b);
}

cr_status_t cr_region_status(const cr_region_t* region)
{
    return static_cast<cr_status_t>(cairo_region_status(region));
}

void cr_region_get_extents(const cr_region_t* region, cr_rectangle_int_t* extents)
{
    cairo_region_get_extents(region, reinterpret_cast<cairo_rectangle_int_t*>(extents));
}

int32 cr_region_num_rectangles(const cr_region_t* region)
{
    return cairo_region_num_rectangles(region);
}

void cr_region_get_rectangle(const cr_region_t* region, int32 nth, cr_rectangle_int_t* rectangle)
{
    cairo_region_get_rectangle(region, nth, reinterpret_cast<cairo_rectangle_int_t*>(rectangle));
}

cr_bool_t cr_region_is_empty(const cr_region_t* region)
{
    return cairo_region_is_empty(region);
}

cr_region_overlap_t cr_region_contains_rectangle(const cr_region_t* region, const cr_rectangle_int_t* rectangle)
{
    return static_cast<cr_region_overlap_t>(cairo_region_contains_rectangle(region, reinterpret_cast<const cairo_rectangle_int_t*>(rectangle)));
}

cr_bool_t cr_region_contains_point(const cr_region_t* region, int32 x, int32 y)
{
    return cairo_region_contains_point(region, x, y);
}

void cr_region_translate(cr_region_t* region, int32 dx, int32 dy)
{
    cairo_region_translate(region, dx, dy);
}

cr_status_t cr_region_subtract(cr_region_t* dst, const cr_region_t* other)
{
    return static_cast<cr_status_t>(cairo_region_subtract(dst, other));
}

cr_status_t cr_region_subtract_rectangle(cr_region_t* dst, const cr_rectangle_int_t* rectangle)
{
    return static_cast<cr_status_t>(cairo_region_subtract_rectangle(dst, reinterpret_cast<const cairo_rectangle_int_t*>(rectangle)));
}

cr_status_t cr_region_intersect(cr_region_t* dst, const cr_region_t* other)
{
    return static_cast<cr_status_t>(cairo_region_intersect(dst, other));
}

cr_status_t cr_region_intersect_rectangle(cr_region_t* dst, const cr_rectangle_int_t* rectangle)
{
    return static_cast<cr_status_t>(cairo_region_intersect_rectangle(dst, reinterpret_cast<const cairo_rectangle_int_t*>(rectangle)));
}

cr_status_t cr_region_union(cr_region_t* dst, const cr_region_t* other)
{
    return static_cast<cr_status_t>(cairo_region_union(dst, other));
}

cr_status_t cr_region_union_rectangle(cr_region_t* dst, const cr_rectangle_int_t* rectangle)
{
    return static_cast<cr_status_t>(cairo_region_union_rectangle(dst, reinterpret_cast<const cairo_rectangle_int_t*>(rectangle)));
}

cr_status_t cr_region_xor(cr_region_t* dst, const cr_region_t* other)
{
    return static_cast<cr_status_t>(cairo_region_xor(dst, other));
}

cr_status_t cr_region_xor_rectangle(cr_region_t* dst, const cr_rectangle_int_t* rectangle)
{
    return static_cast<cr_status_t>(cairo_region_xor_rectangle(dst, reinterpret_cast<const cairo_rectangle_int_t*>(rectangle)));
}

void cr_debug_reset_static_data(void)
{
    cairo_debug_reset_static_data();
}

bool cr_write_to_png(cr_t* cr, const char* filename)
{
    cr_surface_t* crs = cairo_get_target(cr);
    cairo_status_t status = cairo_surface_write_to_png(crs, filename);
    if (status != CAIRO_STATUS_SUCCESS) {
        dprint("cr_write_to_png(%s) fail. %s\n", filename, cairo_status_to_string(status));
        return false;
    }
    return true;
}

// ExCairo::Face
//
static FT_Library ftLib;

void ExCairo::Face::finiFtLib()
{
    exassert(ftLib != NULL);
    FT_Done_FreeType(ftLib);
    ftLib = NULL;
}

void ExCairo::Face::initFtLib()
{
    exassert(ftLib == NULL);
    FT_Init_FreeType(&ftLib);
}

bool ExCairo::Face::load(const char* path, const char* name)
{
    exassert(ftLib != NULL);

    char faceName[256];
    snprintf(faceName, 256, "%s/%s", path, name);

    if (FT_New_Face(ftLib, faceName, 0, &ftFace) != FT_Err_Ok) {
        dprint1("%s(%s) FT_New_Face fail\n", __func__, faceName);
        return false;
    }
    // create cairo font
	crf = cairo_ft_font_face_create_for_ft_face(ftFace, FT_LOAD_DEFAULT | FT_LOAD_NO_BITMAP);
    if (crf == NULL) {
        dprint1("%s(%s) cairo_ft_font_face_create_for_ft_face fail\n", __func__, faceName);
        return false;
    }
    return true;
}

void ExCairo::Face::free()
{
    exassert(ftLib != NULL);

    if (crf != NULL) {
        cairo_font_face_destroy(crf);
        crf = NULL;
    }
    if (ftFace != NULL) {
        FT_Done_Face(ftFace);
        ftFace = NULL;
    }
}

// ExCairo
//
ExCairo::~ExCairo()
{
    cairo_restore(canvas->cr);
}

ExCairo::ExCairo(const ExCanvas* canvas, const ExRegion* damage) : canvas(canvas)
{
    cairo_save(canvas->cr);
    set_region(damage);
    cairo_clip(canvas->cr);
}

void ExCairo::set_region(const ExRegion* srcrgn)
{
    cr_t* cr = canvas->cr;
    //cairo_reset_clip(cr); // tbd
    exassert(!srcrgn->empty());
    if (srcrgn->empty()) {
        dprint("srcrgn empty\n");
        cairo_rectangle(cr,
                        -1, -1, 1, 1);
        return;
    }
    for (int32 i = 0; i < srcrgn->n_boxes; i++) {
        cairo_rectangle(cr,
                        (float64)srcrgn->boxes[i].u.ul.x,
                        (float64)srcrgn->boxes[i].u.ul.y,
                        (float64)srcrgn->boxes[i].width(),
                        (float64)srcrgn->boxes[i].height());
    }
    // usage-1: paint
    //      cairo_save(cr);
    //      set_region(rgn);
    //      cairo_clip(cr); // all clipped out
    //      cairo_set_source...(cr, ...);
    //      cairo_paint(cr);
    //      cairo_restore(cr);
    // usage-2: fill
    //      cairo_save(cr);
    //      set_region(cr, rgn);
    //      cairo_set_source...(cr, ...);
    //      cairo_fill(cr);
    //      cairo_clip(cr); // all clipped out
    //      cairo_restore(cr);
    // should call "cairo_restore(cr);" at application side
}

void ExCairo::fill_rect_rgba(const Rect& r, const Color& c)
{
    cr_t* cr = canvas->cr;
    cairo_set_source_rgba(cr, c.r, c.g, c.b, c.a);
    cairo_rectangle(cr, r.x, r.y, r.w, r.h);
    cairo_fill(cr);
}

void ExCairo::fill_rect_rgba(float64 x, float64 y, float64 w, float64 h, const Color& c)
{
    cr_t* cr = canvas->cr;
    cairo_set_source_rgba(cr, c.r, c.g, c.b, c.a);
    cairo_rectangle(cr, x, y, w, h);
    cairo_fill(cr);
}

void // static
ExCairo::text_extent(cr_t* cr, cr_font_face_t* crf, float64 size,
                     const char* utf8, cr_text_extents_t* te)
{
    cairo_set_font_face(cr, crf);
    cairo_set_font_size(cr, size);
    cairo_text_extents(cr, utf8, reinterpret_cast<cairo_text_extents_t*>(te));
}

ExCairo::Point // static
ExCairo::text_align(const cr_font_extents_t& fe, const cr_text_extents_t& te, const Rect& r, uint32 align)
{
    Point p;
    switch (align & 0x3) {
        case Center: p.x = r.x + (r.w - te.width) / 2.; break;
        case Right: p.x = r.x + r.w - te.width; break;
        default: p.x = r.x;
    }
    switch (align & (0x3 << 2)) {
        case VCenter: p.y = r.y + (r.h + fe.height) / 2.; break;
        case Bottom: p.y = r.y + r.h; break;
        default: p.y = r.y + fe.height;
    }
    p.x -= te.x_bearing;
    p.y -= fe.descent;
    return p;
}

ExCairo::Point
ExCairo::text_align(const char* utf8, const Rect& r, uint32 align)
{
    cr_t* cr = canvas->cr;
    cr_text_extents_t te;
    cairo_text_extents(cr, utf8, reinterpret_cast<cairo_text_extents_t*>(&te));
    return text_align(canvas->fe, te, r, align);
}

void ExCairo::show_text(const char* utf8, const Color& c, const Rect& r, uint32 align)
{
    cr_t* cr = canvas->cr;
    ExCairo::Point p(text_align(utf8, r, align));
    cairo_set_source_rgb(cr, c.r, c.g, c.b);
    cairo_move_to(cr, p.x, p.y);
    cairo_show_text(cr, utf8);
}

void ExCairo::show_text(const char* utf8, const Color& c, const Point& p)
{
    cr_t* cr = canvas->cr;
    cairo_set_source_rgb(cr, c.r, c.g, c.b);
    cairo_move_to(cr, p.x, p.y);
    cairo_show_text(cr, utf8);
}

void ExCairo::show_text(const char* utf8, float64 r, float64 g, float64 b, float64 x, float64 y)
{
    cr_t* cr = canvas->cr;
    cairo_set_source_rgb(cr, r, g, b);
    cairo_move_to(cr, x, y);
    cairo_show_text(cr, utf8);
}

void ExCairo::set_font(cr_font_face_t* font, float64 size)
{
    cr_t* cr = canvas->cr;
    cairo_set_font_face(cr, font);
    cairo_set_font_size(cr, size);
    cairo_font_extents(cr, reinterpret_cast<cairo_font_extents_t*>(&canvas->fe));
}

#if defined(EXAPITEST)
void
excairo_apitest()
{
}
#endif
