#include "framework.h"
#include "common.h"

void STDCALL
onDrawBtns(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
{
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->calcRect());
    ExCairo::Point p2(rc.p2());

    cairo_new_path(cr);
    cairo_move_to(cr, rc.x + 4, rc.y + 1);
    cairo_line_to(cr, p2.x - 4, rc.y + 1);
    cairo_line_to(cr, p2.x - 1, rc.y + 4);
    cairo_line_to(cr, p2.x - 1, p2.y - 4);
    cairo_line_to(cr, p2.x - 4, p2.y - 1);
    cairo_line_to(cr, rc.x + 4, p2.y - 1);
    cairo_line_to(cr, rc.x + 1, p2.y - 4);
    cairo_line_to(cr, rc.x + 1, rc.y + 4);
    cairo_close_path(cr);

    ExCairo::Color* pc; // pattern color
    if (widget->getFlags(Ex_PtrEntered)) {
        pc = res.c.cbtn_pc_H;
    } else {
        pc = res.c.cbtn_pc_N;
    }
    cairo_pattern_t* crp = cairo_pattern_create_linear(rc.x, rc.y, p2.x, p2.y);
    cairo_pattern_add_color_stop_rgba(crp, 0.f, pc[0].r, pc[0].g, pc[0].b, pc[0].a);
    cairo_pattern_add_color_stop_rgba(crp, 1.f, pc[1].r, pc[1].g, pc[1].b, pc[1].a);
    cairo_set_source(cr, crp);
    cairo_fill_preserve(cr);

    ExCairo::Color* lc; // line color
    if (widget->getFlags(Ex_Focused)) {
        lc = &res.c.cbtn_lc_F;
    } else if (widget->getFlags(Ex_ButPressed)) {
        lc = &res.c.cbtn_lc_P;
    } else {
        lc = &res.c.cbtn_lc_N;
    }
    cairo_set_line_width(cr, widget->getFlags(Ex_Focused) ? 3.6f : 1.2f);
    cairo_set_line_join(cr, CAIRO_LINE_JOIN_ROUND);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
    cairo_set_antialias(cr, CAIRO_ANTIALIAS_GRAY);
    cairo_set_source_rgba(cr, lc->r, lc->g, lc->b, lc->a);
    cairo_stroke(cr);

    const wchar* text = widget->getName();
    cr.set_font(res.f.gothic.crf, 12.f);
    cr.show_text(text, ExCairo::Color(0.f), rc);

    cairo_pattern_destroy(crp);
}

