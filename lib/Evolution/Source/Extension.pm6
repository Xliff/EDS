use v6.c;

use Method::Also;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Extension;

use GLib::Roles::Object;

our subset ESourceExtensionAncestry is export of Mu
  where ESourceExtension | GObject;

class Evolution::Source::Extension {
  also does GLib::Roles::Object;

  has ESourceExtension $!ese is implementor;

  submethod BUILD (:$extension) {
    self.setESourceExtension($extension) if $extension;
  }

  method setESourceExtension (ESourceExtensionAncestry $_) {
    my $to-parent;

    $!ese = do {
      when ESourceExtension {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceExtension, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceExtension
    is also<ESourceExtension>
  { $!ese }

  multi method new (ESourceExtensionAncestry $extension, :$ref = True) {
    return Nil unless $extension;

    my $o = self.bless( :$extension );
    $o.ref if $ref;
    $o;
  }

  method get_source (:$raw = False) is also<get-source> {
    my $s = e_source_extension_get_source($!ese);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_extension_get_type, $n, $t );
  }

  method property_lock is also<property-lock> {
    e_source_extension_property_lock($!ese);
  }

  method property_unlock is also<property-unlock> {
    e_source_extension_property_unlock($!ese);
  }

  method ref_source (:$raw = False) is also<ref-source> {
    my $s = e_source_extension_ref_source($!ese);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

}
