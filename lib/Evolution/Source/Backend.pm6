use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::SourceExtension;

our subset ESourceBackendAncestry is export of Mu
  where ESourceBackend | ESourceExtensionAncestry;

class Evolution::Source::Backend is Evolution::SourceExtension {
  has ESourceBackend $!esb;

  submethod BUILD (:$backend) {
    self.setESourceBackend($backend) if $backend;
  }

  method setESourceBackend (ESourceBackendAncestry $_) {
    my $to-parent;

    $!esb = do {
      when ESourceBackend {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceBackend, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method EDS::Raw::Definitions::ESourceBackend
  { $!esb }

  multi method new (ESourceBackendAncestry $backend, :$ref = True) {
    return Nil unless $backend;

    my $o = self.bless( :$backend );
    $o.ref if $ref;
    $o;
  }

  method dup_backend_name {
    e_source_backend_dup_backend_name($!esb);
  }

  method get_backend_name {
    e_source_backend_get_backend_name($!esb);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_backend_get_type, $n, $t );
  }

  method set_backend_name (Str() $backend_name) {
    e_source_backend_set_backend_name($!esb, $backend_name);
  }

}

### /usr/include/evolution-data-server/libedataserver/e-source-backend.h

sub e_source_backend_dup_backend_name (ESourceBackend $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_backend_get_backend_name (ESourceBackend $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_backend_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_backend_set_backend_name (
  ESourceBackend $extension,
  Str            $backend_name
)
  is native(eds)
  is export
{ * }
