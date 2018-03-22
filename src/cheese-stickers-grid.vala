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
using Gdk;

public class Cheese.StickersGrid : Gtk.Grid {
	private string category;
	private static int WIDTH = 3;

	public StickersGrid(string category)
	{
		int image_path_i, r, c;
		List<string> image_paths;
		this.category = category;
		image_paths = get_image_paths();

		this.column_spacing = 6;
		this.row_spacing = 6;
		this.margin_bottom = 12;
		this.margin_left = 12;
		this.margin_right = 12;
		this.margin_top = 12;

		for (image_path_i = 0; image_path_i < image_paths.length(); image_path_i++)
		{
			string image_path;
			Cheese.StickersButton sticker_button;
			image_path = image_paths.nth_data(image_path_i);
			r = (image_path_i + 1) % WIDTH;
			c = image_path_i / WIDTH;
			sticker_button = new Cheese.StickersButton(image_path);
			this.attach(sticker_button, r, c, 1, 1);
			/*
			Gtk.StyleContext style_context;
			string image_path;
			Gtk.ToggleButton sticker_button;
			sticker_button = new Gtk.ToggleButton();
			style_context = sticker_button.get_style_context(sticker_button);
			style_context.add_class("sticker_button");
			// sticker_button.set_name("sticker-button");
			image_path = image_paths.nth_data(image_path_i);

			try
			{
				// Gdk.Pixbuf pixbuf;
				Gtk.Image image;
				// pixbuf = new Gdk.Pixbuf.from_file(image_path);
				// image = new Gtk.Image.from_pixbuf(pixbuf);
				//sticker_button.add(image);
				r = (image_path_i + 1) % WIDTH;
				c = image_path_i / WIDTH;
				this.attach(sticker_button, r, c, 1, 1);
			}
			catch (FileError e)
			{
			}
			*/
		}
	}

	private List<string> get_image_paths()
	{
		int i;
		List<string> paths = new List<string>();
		string datadir;
		char **datadirs;

		datadirs = GLib.Environment.get_system_data_dirs ();

		for (i = 0; (datadir = (string) datadirs[i]) != null; i++)
		{
			string category_path;
			GLib.Dir dir;
			category_path = Path.build_filename (datadir,
											 	 "pixmaps/cheese/stickers/",
											     category);
			try
			{
				dir = GLib.Dir.open(category_path);
				if (dir != null)
				{
					unowned string entry;
					while ((entry = dir.read_name()) != null)
					{
						string path;
						path = Path.build_filename (category_path, entry);
						paths.append(path);
					}
					if (paths.length() != 0)
					{
						return paths;
					}
				}
			} catch (FileError e)
			{

			}
		}
		return paths;
	}



}
