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

errordomain ErrorType1 {
    CODE_1A
}

public class Cheese.FacePresetGrid :
	Cheese.StickersGrid, Cheese.FaceGridInterface, Cheese.StickersPageInterface
{
	private int MAX_COLS = 3;
	private string PRESETS_DIR = "cheese/stickers/sprites/face-presets/";
	private int count_active_buttons;
	private bool effects_available;
	private List<Cheese.FacePresetButton> selection;

	public FacePresetGrid ()
	{
		selection = new List<Cheese.FacePresetButton> ();
		set_max_children_per_line (MAX_COLS);
		set_min_children_per_line (MAX_COLS);
		load_buttons ();
	}

	public void load_buttons ()
	{
		int i;
		List<string> paths = new List<string> ();
		string datadir;
		char **datadirs;

		datadirs = GLib.Environment.get_system_data_dirs ();

		for (i = 0; (datadir = (string) datadirs[i]) != null; i++)
		{
			string sprites_path;
			string sprite_filename = null;
			string sprite_path;
			GLib.Dir sprites_dir;
			sprites_path = Path.build_filename (datadir, PRESETS_DIR);

			try
			{
				sprites_dir = Dir.open (sprites_path, 0);
				while ((sprite_filename = sprites_dir.read_name ()) != null) {
					KeyFile keyfile;
					Cheese.FacePresetButton preset_button;
					bool is_sprite;
					sprite_path =
						Path.build_filename (sprites_path, sprite_filename);
					is_sprite = sprite_path.has_suffix (".sprite") &&
						FileUtils.test (sprite_path, FileTest.IS_REGULAR);
					if (!is_sprite)
					{
						continue;
					}


					try
					{
						keyfile = new KeyFile ();
						keyfile.load_from_file (sprite_path, KeyFileFlags.NONE);
						preset_button =
							Cheese.FacePresetButton.new_from_keyfile (keyfile);
						preset_button.toggled.connect (this.on_preset_button_toggled);
						this.add (preset_button);
					}
					catch (Error err)
					{
						warning (_("Not possible to create a face preset for " +
								   "the following sprite: %s. Error: %s"),
								 sprite_path, err.message);
					}
				}
			}
			catch (FileError err)
			{
				info (err.message);
			}

		}
	}

	private void on_preset_button_toggled (Cheese.StickerButton but)
	{
		Cheese.FacePresetButton button;
		button = (Cheese.FacePresetButton) but;
		if (button.active)
		{
			selection.append (button);
		}
		else
		{
			selection.remove (button);
		}
		if (selection.length () == 0)
		{
			effect_unavailable ();
		}
		else if (selection.length () == 1)
		{
			effect_available ();
		}
	}

	private string selection_to_data ()
	{
		Json.Array array;
		Json.Node node;
		Json.Generator generator;

		generator = new Json.Generator ();
		node = new Json.Node (Json.NodeType.ARRAY);

		array = new Json.Array ();
		selection.foreach ((preset_button) => {
			array.add_element (preset_button.face_sprite_json);
		});

		node.set_array (array);
		generator.set_root (node);
		return generator.to_data (null);
	}

	public Cheese.Effect get_effect () throws Error
	{
		string landmark = "/home/cfoch/Documents/git/gst-plugins-cheese/shape_predictor_68_face_landmarks.dat";
		string facedetect_desc, overlay_desc, pipeline_desc;

		facedetect_desc = "cheesefacedetect display-landmark=false " +
					      "display-pose-estimation=false display-id=false " +
					      "display-bounding-box=false scale-factor=0.5 " +
					      "landmark=%s".printf (landmark);
		overlay_desc = "cheesefaceoverlay data=%s".printf (selection_to_data ());
		pipeline_desc = "%s ! videoconvert ! %s".printf (facedetect_desc,
														 overlay_desc);
		debug ("pipeline description: %s", pipeline_desc);
		return new Cheese.Effect ("cheesefaceoverlay", pipeline_desc);
	}

	public Cheese.MultifaceSprite create_multiface_frame () throws Error
	{
		Json.Array array;
		Json.Node node;
		Json.Generator generator;

		generator = new Json.Generator ();
		node = new Json.Node (Json.NodeType.ARRAY);

		array = new Json.Array ();
		selection.foreach ((preset_button) => {
			array.add_element (preset_button.face_sprite_json);
		});

		node.set_array (array);
		generator.set_root (node);

		print ("%s\n", generator.to_data (null));
		throw new ErrorType1.CODE_1A("Error");
	}
}
