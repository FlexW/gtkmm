/* Copyright 2002      The gtkmm Development Team
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

#include <gdkmm/general.h>
#include <gdkmm/color.h>
#include <gdk/gdk.h>


namespace Gdk
{

#ifndef GDKMM_DISABLE_DEPRECATED
G_GNUC_BEGIN_IGNORE_DEPRECATIONS
int screen_width()
{
  return gdk_screen_width();
}

int screen_height()
{
  return gdk_screen_height();
}

int screen_width_mm()
{
  return gdk_screen_width_mm();
}

int screen_height_mm()
{
  return gdk_screen_height_mm();
}

void flush()
{
  gdk_flush();
}
G_GNUC_END_IGNORE_DEPRECATIONS
#endif //GDKMM_DISABLE_DEPRECATED

namespace Cairo
{

#ifndef GDKMM_DISABLE_DEPRECATED
G_GNUC_BEGIN_IGNORE_DEPRECATIONS
void set_source_color(const ::Cairo::RefPtr< ::Cairo::Context >& context, const Gdk::Color& color)
{
  gdk_cairo_set_source_color(context->cobj(), const_cast<GdkColor*>(color.gobj()));
}
G_GNUC_END_IGNORE_DEPRECATIONS
#endif //GDKMM_DISABLE_DEPRECATED

void set_source_rgba(const ::Cairo::RefPtr< ::Cairo::Context >& context, const Gdk::RGBA& color)
{
  gdk_cairo_set_source_rgba(context->cobj(), const_cast<GdkRGBA*>(color.gobj()));
}

void set_source_pixbuf(const ::Cairo::RefPtr< ::Cairo::Context >& context, const Glib::RefPtr<Gdk::Pixbuf>& pixbuf, double pixbuf_x, double pixbuf_y)
{
  gdk_cairo_set_source_pixbuf(context->cobj(), pixbuf->gobj(), pixbuf_x, pixbuf_y);
}


void add_rectangle_to_path(const ::Cairo::RefPtr< ::Cairo::Context >& context, const Gdk::Rectangle& rectangle)
{
  gdk_cairo_rectangle(context->cobj(), const_cast<GdkRectangle*>(rectangle.gobj()));
}

void add_region_to_path(const ::Cairo::RefPtr< ::Cairo::Context >& context, const ::Cairo::RefPtr< ::Cairo::Region>& region)
{
  gdk_cairo_region(context->cobj(), (region ? region->cobj() : nullptr));
}

} //namespace Cairo

} //namespace Gdk
