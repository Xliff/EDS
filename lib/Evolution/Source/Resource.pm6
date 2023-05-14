use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Extension;

our subset ESourceResourceAncestry is export of Mu
  where ESourceResource | ESourceExtensionAncestry;

class Evolution::Source::Resource is Evolution::Source::Extension {
  has ESourceResource $!esr;

  submethod BUILD (:$Resource) {
    self.setESourceResource($Resource) if $Resource;
  }

  method setESourceResource (ESourceResourceAncestry $_) {
    my $to-parent;

    $!esr = do {
      when ESourceResource {
        $to-parent = cast(ESourceExtension, $_);
          $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceResource, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceResource
  { $!esr }

  method new (
    ESourceResourceAncestry $Resource,
                            :$ref   = True
  ) {
    return Nil unless $Resource;

    my $o = self.bless( :$Resource );
    $o.ref if $ref;
    $o;
  }

  method identity is rw {
    Proxy.new:
      FETCH => -> $     { self.get_identity    },
      STORE => -> $, \v { self.set_identity(v) }
  }

  method dup_identity {
    e_source_resource_dup_identity($!esr);
  }

  method get_identity {
    e_source_resource_get_identity($!esr);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_resource_get_type,
      $n,
      $t
    )
  }

  method set_identity (Str $identity) {
    e_source_resource_set_identity($!esr, $identity);
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-resource.h

sub e_source_resource_dup_identity (ESourceResource $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_resource_get_identity (ESourceResource $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_resource_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_resource_set_identity (ESourceResource $extension, Str $identity)
  is native(eds)
  is export
{ * }
