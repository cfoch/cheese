/*
 * Copyright © 2017 Cesar Fabian Orccon Chipana <cfoch.fabian@gmail.com>
 *
 * Licensed under the GNU General Public License Version 2
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using GLib;

[GtkTemplate (ui = "/org/gnome/Cheese/cheese-stickers-popover.ui")]
public class Cheese.StickersPopover : Gtk.Popover {
	[GtkChild]
	private Gtk.SearchBar search_bar;
	//[GtkChild]
	//private Gtk.Revealer search_bar_revealer;
	[GtkChild]
	private Gtk.StackSwitcher stack_switcher;
	[GtkChild]
	private Gtk.Button apply_button;
	[GtkChild]
	private Gtk.Box box;

	/* properties not defined in ui file */
	private Gtk.Stack stack;
	private Cheese.FacePresetGrid page_face_preset;

	public StickersPopover(Gtk.Widget widget)
	{
		Gtk.StyleContext search_bar_style_context;


		GLib.Object (relative_to: widget);

        stack = new Gtk.Stack ();
        stack_switcher.set_stack (stack);

        // Design
		search_bar_style_context = search_bar.get_style_context();
		search_bar_style_context.add_class("cheese-sticker-popup-searchbar");

		// Add pages to stack.
		page_face_preset = new Cheese.FacePresetGrid ();
		page_face_preset.effect_available.connect (on_effect_available);
		page_face_preset.effect_unavailable.connect (on_effect_unavailable);
    	stack.add_titled (page_face_preset, "faces-presets", "Faces presets");

		box.pack_start(stack, true, true, 0);
	}

	[GtkCallback]
	private void on_search_button_clicked (Gtk.Button search_button)
	{
		bool reveal = this.search_bar.search_mode_enabled;
		this.search_bar.search_mode_enabled = !reveal;
	}

	private void on_effect_available ()
	{
		apply_button.sensitive = true;
	}

	private void on_effect_unavailable ()
	{
		apply_button.sensitive = false;
	}
}
