use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;

unit package Evolution::Raw::Categories;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-categories.h

sub e_categories_add (
  Str      $category,
  Str      $unused,
  Str      $icon_file,
  gboolean $searchable
)
  is      native(eds)
  is      export
{ * }

sub e_categories_dup_icon_file_for (Str $category)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_categories_dup_list
  returns GList
  is      native(eds)
  is      export
{ * }

sub e_categories_exist (Str $category)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_categories_is_searchable (Str $category)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_categories_register_change_listener (
           &listener (gpointer),
  gpointer $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_categories_remove (Str $category)
  is      native(eds)
  is      export
{ * }

sub e_categories_set_icon_file_for (Str $category, Str $icon_file)
  is      native(eds)
  is      export
{ * }

sub e_categories_unregister_change_listener (
           &listener (gpointer),
  gpointer $user_data
)
  is      native(eds)
  is      export
{ * }
