use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Selectable;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-selectable.h

sub e_source_selectable_dup_color (ESourceSelectable $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_selectable_get_color (ESourceSelectable $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_selectable_get_selected (ESourceSelectable $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_selectable_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_selectable_set_color (ESourceSelectable $extension, Str $color)
  is native(eds)
  is export
{ * }

sub e_source_selectable_set_selected (
  ESourceSelectable $extension,
  gboolean          $selected
)
  is native(eds)
  is export
{ * }
