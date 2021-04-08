use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Selectable;

use Evolution::Source::Backend;

our subset ESourceSelectableAncestry is export of Mu
  where ESourceSelectable | ESourceBackendAncestry;

class Evolution::Source::Selectable is Evolution::Source::Backend {
  has ESourceSelectable $!ess is implementor;

  submethod BUILD (:$selectable) {
    self.setESourceSelectable($selectable) if $selectable;
  }

  method setESourceSelectable (ESourceSelectableAncestry $_) {
    my $to-parent;

    $!ess = do {
      when ESourceSelectable {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceSelectable, $_);
      }
    }
    self.setESourceBackend($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceSelectable
  { $!ess }

  multi method new (ESourceSelectableAncestry $selectable, :$ref = True) {
    return Nil unless $selectable;

    my $o = self.bless( :$selectable );
    $o.ref if $ref;
    $o;
  }

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

# Barebones descendant wrappers
class Evolution::Source::Calendar is Evolution::Source::Selectable { }

class Evolution::Source::MemoList is Evolution::Source::Selectable { }

class Evolution::Source::TaskList is Evolution::Source::Selectable { }
