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

	public StickersPopover(Gtk.Widget widget)
	{
		GLib.Object (relative_to: widget);
		print ("POPOVER CLICKED\n");
	}

	[GtkCallback]
	private void on_search_button_clicked(Gtk.Button search_button)
	{
		//bool reveal = this.search_bar_revealer.reveal_child;
		//this.search_bar_revealer.reveal_child = !reveal;
		bool reveal = this.search_bar.search_mode_enabled;
		this.search_bar.search_mode_enabled = !reveal;
	}

	/*
	private Gtk.Box box;
	private Gtk.Box faces_presets_box;
	private Gtk.SearchBar search_bar;
	private Gtk.SearchEntry search_entry;
	private Gtk.Stack stack;
	private Gtk.StackSwitcher stack_switcher;

	public StickersPopover(Gtk.Widget widget, HashTable<string, string> categories)
	{
		Cheese.StickersGrid stickers_grid;
		Gtk.ScrolledWindow scrolled_window;
		Gtk.Stack stack;
		Gtk.StackSwitcher stack_switcher;

		Gtk.ListStore list_store;
		Gtk.TreeIter iter;
		Gtk.CellRendererText renderer_text;
		//Gtk.ComboBox combo_box;
		GLib.Object (relative_to: widget);

		box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

		stack = new Gtk.Stack();
		stack_switcher = new Gtk.StackSwitcher();
		stack_switcher.set_stack(stack);


		// this.set_size_request(300, 600);

		// list_store = new Gtk.ListStore(2, typeof(string), typeof(int));
		// list_store.append(out iter);
		// list_store.set(iter, 0, "All", 1, 1);
		// list_store.append(out iter);
		// list_store.set(iter, 0, "Masks", 2, 2);
		// list_store.append(out iter);
		// list_store.set(iter, 0, "Stickers", 3, 3);

		faces_presets_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 10);
		//combo_box = new Gtk.ComboBox.with_model(list_store);

		renderer_text = new Gtk.CellRendererText();
        //combo_box.pack_start(renderer_text, true);
        //combo_box.add_attribute(renderer_text, "text", 0);
        //combo_box.active = 0;

		//stack = new Gtk.Stack();
		//stack_switcher = new Gtk.StackSwitcher();
		//stack_switcher.set_stack(stack);

		faces_presets_box.homogeneous = false;

		stickers_grid = new Cheese.StickersGrid("masks");
		scrolled_window = new Gtk.ScrolledWindow(null, null);
		scrolled_window.min_content_height = 300;
		scrolled_window.vscrollbar_policy = Gtk.PolicyType.ALWAYS;
		scrolled_window.hscrollbar_policy = Gtk.PolicyType.NEVER;
		scrolled_window.add_with_viewport(stickers_grid);

		Gtk.Box search_bar_container;
		search_bar = new Gtk.SearchBar();
		search_bar_container = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 6);
		search_entry = new Gtk.SearchEntry();
		search_bar_container.pack_start(search_entry, true, true, 0);
		search_bar.add(search_bar_container);
		search_bar.search_mode_enabled = true;
		//box.pack_start(stack_switcher, true, true, 0);
		//box.pack_start(stack, true, true, 0);
		// box.pack_start(combo_box, true, true, 0);
		faces_presets_box.pack_start(scrolled_window, true, true, 0);
		//faces_presets_box.pack_start(search_entry, true, true, 0);

		stack.add_titled(faces_presets_box, "faces-presets", "Faces presets");


		this.box.pack_start(stack_switcher, true, true, 0);
		this.box.pack_start(search_bar, true, true, 0);
		this.box.pack_start(stack, true, true, 0);

		this.add(box);
	}
	*/

}
