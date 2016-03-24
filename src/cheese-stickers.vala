/*
 * Copyright © 2016 Fabian Orccon <cfoch.fabian@gmail.com>
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



[GtkTemplate (ui = "/org/gnome/Cheese/cheese-stickers.ui")]
public class Cheese.StickersDialog : Gtk.Window
{
  enum ColSticker {
    PIXBUF = 0,
    PATH,
    N_COLUMNS
  }

  private Cheese.Camera camera;
  private string stickers_dir;

  [GtkChild]
  private Gtk.IconView icon_view;
  [GtkChild]
  private Gtk.ListStore list_store;

  public StickersDialog (Cheese.Camera camera)
  {
    this.camera = camera;
    set_stickers_dir ();
    populate_list_store ();
    icon_view.set_pixbuf_column (ColSticker.PIXBUF);
    icon_view.set_text_column (ColSticker.PATH);
    icon_view.selection_changed.connect(selectionChangedCb);
  }

  private void set_stickers_dir ()
  {
    string datadir;
    char **datadirs;
    string path;
    int i;

    icon_view.set_item_width (128);

    datadirs = GLib.Environment.get_system_data_dirs ();


    for (i = 0; datadirs[i] != null; i++) {
      datadir = (string) datadirs[i];
      path = Path.build_filename (datadir,
          "icons/hicolor/scalable/cheese");
      if (FileUtils.test (path, FileTest.EXISTS | FileTest.IS_DIR))
      {
        stickers_dir = path;
        return;
      }
    }
  }

  private void selectionChangedCb ()
  {
    int i;
    List<Gtk.TreePath> selected_paths;
    Gtk.TreeModel model;
    Gtk.TreeIter iter;
    Value v_path;
    Cheese.Effect effect;
    string effect_desc;

    selected_paths = icon_view.get_selected_items ();
    model = icon_view.get_model ();


    for (i = 0; i < selected_paths.length (); i++) {      
      Gtk.TreePath selected_path;

      selected_path = selected_paths.nth_data (i);
      model.get_iter (out iter, selected_path);
      model.get_value (iter, ColSticker.PATH, out v_path);

      effect_desc = "faceoverlay location=" + (string) v_path;

      effect = new Cheese.Effect ("Faceoverlay", effect_desc);
      camera.set_effect (effect);
    }
  }

  private void populate_list_store ()
  {
    Error err;
    Gtk.TreeIter iter;
    Gdk.Pixbuf pixbuf_aux, pixbuf;
    string ?sticker_filename = null;
    string filepath;
    GLib.Dir dir;

    dir = GLib.Dir.open (stickers_dir, 0);

    try {
      while ((sticker_filename = dir.read_name ()) != null) {
        filepath = Path.build_filename (stickers_dir, sticker_filename);
        pixbuf_aux = new Gdk.Pixbuf.from_file (filepath);
        pixbuf = pixbuf_aux.scale_simple (128, 128, Gdk.InterpType.NEAREST);
        list_store.append (out iter);
        list_store.set (iter, ColSticker.PIXBUF, pixbuf,
            ColSticker.PATH, filepath, -1);
      }
    } catch (Error err) {
      message ("Error reading file: %s\n", err.message);
    }
  }


}
