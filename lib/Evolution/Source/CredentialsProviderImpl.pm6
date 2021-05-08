use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::CredentialsProviderImpl;

use Evolution::Extension;
use Evolution::Source::CredentialsProvider;

our subset ESourceCredentialsProviderImplAncestry is export of Mu
  where ESourceCredentialsProviderImpl | EExtensionAncestry;

class Evolution::Source::CredentialsProviderImpl is Evolution::Extension {
  has ESourceCredentialsProviderImpl $!escpi;

  submethod BUILD (:$services) {
    self.setESourceCredentialsProviderImpl($services) if $services;
  }

  method setESourceCredentialsProviderImpl (
    ESourceCredentialsProviderImplAncestry $_
  ) {
    my $to-parent;

    $!escpi = do {
      when ESourceCredentialsProviderImpl {
        $to-parent = cast(EExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceCredentialsProviderImpl, $_);
      }
    }
    self.setEExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceCredentialsProviderImpl
  { $!escpi }

  method new (
    ESourceCredentialsProviderImplAncestry $services,
                                           :$ref      = True
  ) {
    return Nil unless $services;

    my $o = self.bless( :$services );
    $o.ref if $ref;
    $o;
  }

  method can_process (ESource() $source) {
    so e_source_credentials_provider_impl_can_process($!escpi, $source);
  }

  method can_prompt {
    so e_source_credentials_provider_impl_can_prompt($!escpi);
  }

  method can_store {
    so e_source_credentials_provider_impl_can_store($!escpi);
  }

  method delete_sync (
    ESource()               $source,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_source_credentials_provider_impl_delete_sync(
      $!escpi,
      $source,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method get_provider (:$raw = False) {
    my $cp = e_source_credentials_provider_impl_get_provider($!escpi);

    $cp ??
      ( $raw ?? $cp !! Evolution::Source::CredentialsProvider.new($cp, :!ref) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_credentials_provider_impl_get_type,
      $n,
      $t
    )

  }

  method lookup_sync (
    ESource                  $source,
    GCancellable             $cancellable,
    CArray[ENamedParameters] $out_credentials,
    CArray[Pointer[GError]]  $error,
                             :$all             = False,
                             :$raw             = False
  ) {
    clear_error;
    my $rv = e_source_credentials_provider_impl_lookup_sync(
      $!escpi,
      $source,
      $cancellable,
      $out_credentials,
      $error
    );
    set_error($ERROR);

    return $rv unless $all;

    ( $rv, ppr($out_credentials) );
  }

  method store_sync (
    ESource()               $source,
    ENamedParameters()      $credentials,
    Int()                   $permanently,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my gboolean $p = $permanently.so.Int;

    clear_error;
    my $rv = so e_source_credentials_provider_impl_store_sync(
      $!escpi,
      $source,
      $credentials,
      $p,
      $cancellable,
      $error;
    );
    set_error($error);
    $rv;
  }

}
