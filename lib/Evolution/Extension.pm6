use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use GLib::Roles::Object;
use Evolution::Roles::Extensible;

our subset EExtensionAncestry is export of Mu
  where EExtension | GObject;

class Evolution::Extension {
  also does GLib::Roles::Object;

  has EExtension $!ee;

  submethod BUILD (:$extension) {
    self.setEExtension($extension) if $extension;
  }

  method setEExtension (EExtensionAncestry $_) {
    my $to-parent;

    $!ee = do {
      when EExtension {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EExtension, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Structs::EExtension
  { $!ee }

  method new (EExtensionAncestry $extension, :$ref = True) {
    return Nil unless $extension;

    my $o = self.bless( :$extension );
    $o.ref if $ref;
    $o;
  }

  method get_extensible (:$raw = False) {
    my $ex = e_extension_get_extensible($!ee);

    # Transfer: none
    $ex ??
      ( $raw ?? $ex !! Evolution::Extensible($ex) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_extension_get_type, $n, $t );
  }

}


### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-extension.h

sub e_extension_get_extensible (EExtension $extension)
  returns EExtensible
  is native(eds)
  is export
{ * }

sub e_extension_get_type ()
  returns GType
  is native(eds)
  is export
{ * }
