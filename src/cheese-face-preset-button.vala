/*
 * Copyright © 2018 Cesar Fabian Orccon Chipana <cfoch.fabian@gmail.com>
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

public class Cheese.FacePresetButton : Cheese.StickerButton
{
	private Json.Node _face_sprite_json;

	public FacePresetButton.from_file (string image_filepath)
	{
		base.from_file (image_filepath);
	}

	public Json.Node face_sprite_json
	{
		get
		{
			return _face_sprite_json;
		}
	}

	public static FacePresetButton new_from_keyfile(KeyFile file) throws Error {
		FacePresetButton button;
		Json.Node node;
		// FaceSprite sprite_frame;
		string @name, @json_path, @thumbnail_path;
		try
		{
			name = file.get_string ("Face", "Name");
			json_path = file.get_string ("Face", "Location");
			thumbnail_path = file.get_string ("Face", "Thumbnail");
		}
		catch (KeyFileError err)
		{
			throw err;
		}

		try
		{
			Json.Parser parser;
			parser = new Json.Parser ();
			parser.load_from_file (json_path);
			node = parser.get_root ();
			// sprite_frame = new Cheese.FaceSprite.from_location(json_path);
		}
		catch (Error err)
		{
			throw err;
		}

		debug ("Thumbnail path: %s\n", thumbnail_path);
		button = new FacePresetButton.from_file (thumbnail_path);
		button._face_sprite_json = node;
		return button;
	}
}
