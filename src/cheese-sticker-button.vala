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

public class Cheese.StickerButton : Gtk.Bin
{
	private Gtk.Overlay overlay;
	private Gtk.Image image;
	private Gtk.ToggleButton toggle_button;
	private string filename;

	private static int DEFAULT_PIXEL_SIZE = 116;

	private bool _active;

	public signal void toggled (Cheese.StickerButton button);

	public StickerButton.from_file (string image_filepath)
	{
		Gtk.StyleContext style_context;
		Gtk.StyleContext toggle_style_context;

		overlay = new Gtk.Overlay();
		this.add(overlay);

		toggle_button = new Gtk.ToggleButton();
		toggle_button.toggled.connect (() => {
			this.toggled (this);
		});
		toggle_style_context = toggle_button.get_style_context();
		toggle_style_context.add_class("cheese-sticker-toggle-button");


		/* Set thumbnail image */
		image = this.create_image_from_file (image_filepath);

		overlay.add (image);
		overlay.add_overlay (toggle_button);

		set_size_request (DEFAULT_PIXEL_SIZE, DEFAULT_PIXEL_SIZE);
		overlay.set_size_request (DEFAULT_PIXEL_SIZE, DEFAULT_PIXEL_SIZE);
		/*
		try
		{
			Gdk.Pixbuf pixbuf;
			pixbuf = new Gdk.Pixbuf.from_file_at_size(filename,
				DEFAULT_WIDTH, DEFAULT_HEIGHT);
			image = new Gtk.Image.from_pixbuf(pixbuf);

			image_style_context = image.get_style_context();
			image_style_context.add_class("cheese-sticker-button-image");

			overlay.add(image);
		}
		catch (FileError e)
		{
			stderr.printf(e.message);
		}
		finally
		{
			overlay.add_overlay(toggle_button);
		}
		*/
	}

	public bool active
	{
		get
		{
			return toggle_button.active;
		}
		set
		{
			toggle_button.active = value;
			_active = toggle_button.active;
		}
	}

	/*
	public Gtk.Image image
	{
		get
		{
			return _image;
		}
	}
	*/

	private Gtk.Image create_image_from_file (string filepath)
	{
		Gtk.Image image;
		Gtk.StyleContext image_style_context;

		try
		{
			Gdk.Pixbuf pixbuf;
			pixbuf = new Gdk.Pixbuf.from_file_at_size(filepath,
				DEFAULT_PIXEL_SIZE, DEFAULT_PIXEL_SIZE);
			image = new Gtk.Image.from_pixbuf(pixbuf);
		}
		catch (Error err)
		{
			image = new Gtk.Image.from_icon_name ("gtk-missing-image",
												  IconSize.BUTTON);
			image.set_pixel_size (DEFAULT_PIXEL_SIZE);
		}

		image_style_context = image.get_style_context();
		image_style_context.add_class("cheese-sticker-button-image");
		return image;
	}

	/*
	private Gtk.Image create_image (string filepath = null)
	{
		Gtk.Image image;
		image = new Gtk.Image.from_file (filepath);
		image_style_context = image.get_style_context();
		image_style_context.add_class("cheese-sticker-button-image");
		return image;
	}
	*/

	/*
	private void set_thumbnail (string filepath = null)
	{
		try
		{
			Gdk.Pixbuf pixbuf;
			pixbuf = new Gdk.Pixbuf.from_file_at_size(filename,
				DEFAULT_WIDTH, DEFAULT_HEIGHT);
			image = new Gtk.Image.from_pixbuf(pixbuf);

			image_style_context = image.get_style_context();
			image_style_context.add_class("cheese-sticker-button-image");

			overlay.add(image);
		}
		catch (Error err)
		{
			warning ("Unable to load thumbnail: %s", err.message);
		}
	}
	*/
}

/*
public class Cheese.StickerButton : Gtk.Bin
{
	private Gtk.Overlay overlay;
	private Gtk.Image image;
	private Gtk.ToggleButton toggle_button;
	private string filename;

	private static int DEFAULT_WIDTH = 116;
	private static int DEFAULT_HEIGHT = 116;

	public StickerButton(string filename)
	{
		Gtk.StyleContext style_context;
		Gtk.StyleContext image_style_context;
		Gtk.StyleContext toggle_style_context;

		overlay = new Gtk.Overlay();
		this.add(overlay);

		// style_context = this.get_style_context();
		//style_context.add_class("cheese-sticker-button");
		//this.margin_left = 6;
		//this.margin_bottom = 6;
		//this.margin_right = 6;
		//this.margin_top = 6;

		toggle_button = new Gtk.ToggleButton();
		toggle_style_context = toggle_button.get_style_context();
		toggle_style_context.add_class("cheese-sticker-toggle-button");

		try
		{
			Gdk.Pixbuf pixbuf;
			pixbuf = new Gdk.Pixbuf.from_file_at_size(filename,
				DEFAULT_WIDTH, DEFAULT_HEIGHT);
			image = new Gtk.Image.from_pixbuf(pixbuf);

			image_style_context = image.get_style_context();
			image_style_context.add_class("cheese-sticker-button-image");

			overlay.add(image);
		} catch (FileError e)
		{
		}
		finally
		{
			overlay.add_overlay(toggle_button);
		}

	}
}
*/
