use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Backend::Factory;

use Evolution::Extension;

our subset EBackendFactoryAncestry is export of Mu
  where EBackendFactory | EExtensionAncestry;

class Evolution::Backend::Factory is Evolution::Extension {
  has EBackendFactory $!ebf;

  method setEBackendFactory (EBackendFactoryAncestry $_) {
    my $to-parent;

    $!ebf = do {
      when EBackendFactory {
        $to-parent = cast(EExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBackendFactory, $_);
      }
    }
    self.setEExtension($to-parent);
  }

  method Evolution::Raw::Structs::EBackendFactory
  { $!ebf }

  method new (EBackendFactoryAncestry $extension, :$ref = True) {
    return Nil unless $extension;

    my $o = self.bless( :$extension );
    $o.ref if $ref;
    $o;
  }

  method new_backend (ESource() $source, :$raw = False) {
    my $eb = e_backend_factory_new_backend($!ebf, $source);

    $eb ??
      ( $raw ?? $eb !! Evolution::Backend.new($eb), :!ref )
      !!
      Nil;
  }

  method get_hash_key {
    e_backend_factory_get_hash_key($!ebf);
  }

  method get_module_filename {
    e_backend_factory_get_module_filename($!ebf);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_backend_factory_get_type, $n, $t );
  }

  method share_subprocess {
    so e_backend_factory_share_subprocess($!ebf);
  }

}
