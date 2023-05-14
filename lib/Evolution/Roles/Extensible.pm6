use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use GLib::GList;

use GLib::Roles::Object;

role Evolution::Roles::Extensible {
  has EExtensible $!eex;

  method Evolution::Raw::Structs::EExtensible
  { $!eex }

  method roleInit-EExtension {
    return if $!eex;

    my \i = findProperImplementor(self.^attributes);
    $!eex = cast( EExtensible, i.get_value(self) );
  }

  method eextensible_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_extensible_get_type, $n, $t );
  }

  method list_extensions (
    Int() $extension_type,
          :$glist          = False,
          :$raw            = False
  ) {
    my GType $e = $extension_type;

    # Use late binding to avoid a circularity.
    returnGList(
      e_extensible_list_extensions($!eex, $extension_type),
      $glist,
      $raw,
      EExtension,
      ::('Evolution::Extension')
    );
  }

  method load_extensions {
    e_extensible_load_extensions($!eex);
  }

}

our subset EExtensibleAncestry is export of Mu
  where EExtensible | GObject;

class Evolution::Extensible {
  also does GLib::Roles::Object;
  also does Evolution::Roles::Extensible;

  submethod BUILD (:$extensible) {
    self.setEExtensible($extensible) if $extensible;
  }

  method setEExtensible (EExtensibleAncestry $_) {
    my $to-parent;

    $!eex = do {
      when EExtensible {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EExtensible, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Structs::EExtensible
  { $!eex }

  method new (EExtensibleAncestry $extensible, :$ref = True) {
    return Nil unless $extensible;

    my $o = self.bless( :$extensible );
    $o.ref if $ref;
    $o;
  }
}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-extensible.h

sub e_extensible_get_type ()
  returns GType
  is native(eds)
  is export
{ * }


sub e_extensible_list_extensions (EExtensible $extensible, GType $extension_type)
  returns GList
  is native(eds)
  is export
{ * }

sub e_extensible_load_extensions (EExtensible $extensible)
  is native(eds)
  is export
{ * }
