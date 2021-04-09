use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Extension;

our subset ESourceAutocompleteAncestry is export of Mu
  where ESourceAutocomplete | ESourceExtensionAncestry;

class Evolution::Source::Autocomplete is Evolution::Source::Extension {
  has ESourceAutocomplete $!esa;

  submethod BUILD (:$auto-complete) {
    self.setESourceAutocomplete($auto-complete) if $auto-complete;
  }

  method setESourceAutocomplete (ESourceAutocompleteAncestry $_) {
    my $to-parent;

    $!esa = do {
      when ESourceAutocomplete {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceAutocomplete, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceAutocomplete
  { $!esa }

  multi method new (ESourceAutocompleteAncestry $auto-complete, :$ref = True) {
    return Nil unless $auto-complete;

    my $o = self.bless( :$auto-complete );
    $o.ref if $ref;
    $o;
  }

  method include_me is rw {
    Proxy.new:
      FETCH => -> $     { self.get_include_me    },
      STORE => -> $, \i { self.set_include_me(i) };
  }

  method get_include_me {
    so e_source_autocomplete_get_include_me($!esa);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_autocomplete_get_type, $n, $t );
  }

  method set_include_me (Int() $include_me) {
    my gboolean $i = $include_me.so.Int;

    e_source_autocomplete_set_include_me($!esa, $i);
  }

}

### /usr/include/evolution-data-server/libedataserver/e-source-autocomplete.h

sub e_source_autocomplete_get_include_me (ESourceAutocomplete $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_autocomplete_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_autocomplete_set_include_me (
  ESourceAutocomplete $extension,
  gboolean $include_me
)
  is native(eds)
  is export
{ * }
