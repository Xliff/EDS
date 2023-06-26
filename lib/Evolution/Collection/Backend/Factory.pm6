use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Backend::Factory;

use GLib::Roles::Implementor;

our subset ECollectionBackendFactoryAncestry is export of Mu
  where ECollectionBackendFactory | EBackendFactoryAncestry;

class Evolution::Collection::Backend::Factory is Evolution::Backend::Factory {
  has ECollectionBackendFactory $!eds-cbf is implementor;

  submethod BUILD ( :$e-collection-backend ) {
    self.setECollectionBackendFactory($e-collection-backend)
      if $e-collection-backend
  }

  method setECollectionBackendFactory (ECollectionBackendFactoryAncestry $_) {
    my $to-parent;

    $!eds-cbf = do {
      when ECollectionBackendFactory {
        $to-parent = cast(EBackendFactory, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECollectionBackendFactory, $_);
      }
    }
    self.setEBackendFactory($to-parent);
  }

  method Evolution::Raw::Definitions::ECollectionBackendFactory
    is also<ECollectionBackendFactory>
  { $!eds-cbf }

  proto method new (|)
  { * }

  multi method new (
    $e-collection-backend where * ~~ ECollectionBackendFactoryAncestry,

    :$ref = True
  ) {
    return unless $e-collection-backend;

    my $o = self.bless( :$e-collection-backend );
    $o.ref if $ref;
    $o;
  }

  method prepare_mail (
    ESource() $mail_account_source,
    ESource() $mail_identity_source,
    ESource() $mail_transport_source
  )
    is also<prepare-mail>
  {
    e_collection_backend_factory_prepare_mail(
      $!eds-cbf,
      $mail_account_source,
      $mail_identity_source,
      $mail_transport_source
    );
  }

}


### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-collection-backend-factory.h

sub e_collection_backend_factory_prepare_mail (
  ECollectionBackendFactory $factory,
  ESource                   $mail_account_source,
  ESource                   $mail_identity_source,
  ESource                   $mail_transport_source
)
  is      native(ebackend)
  is      export
{ * }
