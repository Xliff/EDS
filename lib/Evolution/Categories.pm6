use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Categories;

use GLib::GList;

use GLib::Roles::StaticClass;

class Evolution::Categories {
  also does GLib::Roles::StaticClass;

  multi method add (
    Str() $category,
    Str() $icon_file,
    Int() $searchable
  ) {
    samewith($category, '', $icon_file, $searchable);
  }
  multi method add (
    Str() $category,
    Str() $unused,
    Str() $icon_file,
    Int() $searchable
  ) {
    my gboolean $s = $searchable.so.Int;

    e_categories_add($category, $unused, $icon_file, $s);
  }

  method dup_icon_file_for (Str() $category, :$raw = False, :$glist = False) {
    returnGList(
      e_categories_dup_icon_file_for($category),
      $raw,
      $glist,
      Str
    );
  }

  method dup_list ( :$raw = False, :$glist = False ) {
    returnGList(
      e_categories_dup_list(),
      $raw,
      $glist,
      Str
    );
  }

  method exist (Str() $category) {
    so e_categories_exist($category);
  }

  method is_searchable (Str() $category) {
    so e_categories_is_searchable($category);
  }

  method register_change_listener (
             &listener,
    gpointer $user_data = gpointer
  ) {
    e_categories_register_change_listener(&listener, $user_data);
  }

  method remove (Str() $category) {
    e_categories_remove($category);
  }

  method set_icon_file_for (Str() $category, Str() $icon_file) {
    e_categories_set_icon_file_for($category, $icon_file);
  }

  method unregister_change_listener (
             &listener,
    gpointer $user_data = gpointer
  ) {
    e_categories_unregister_change_listener(&listener, $user_data);
  }

}
