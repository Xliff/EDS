use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Selectable;

use Evolution::Source::Backend;

class Evolution::Source::Selectable is Evolution::Source::Backend {
  has ESourceSelectable $!ess;

  method dup_color {
    e_source_selectable_dup_color($!ess);
  }

  method get_color {
    e_source_selectable_get_color($!ess);
  }

  method get_selected {
    so e_source_selectable_get_selected($!ess);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_selectable_get_type, $n, $t );
  }

  method set_color (Str() $color) {
    e_source_selectable_set_color($!ess, $color);
  }

  method set_selected (Int() $selected) {
    my gboolean $s = $selected.so.Int;

    e_source_selectable_set_selected($!ess, $selected);
  }

}
