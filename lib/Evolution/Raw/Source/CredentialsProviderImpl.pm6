use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::CredentialsProviderImpl;

### /usr/include/evolution-data-server/libeds/e-source-credentials-provider-impl.h

sub e_source_credentials_provider_impl_can_process (
  ESourceCredentialsProviderImpl $provider_impl,
  ESource                        $source
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_impl_can_prompt (
  ESourceCredentialsProviderImpl $provider_impl
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_impl_can_store (
  ESourceCredentialsProviderImpl $provider_impl
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_impl_delete_sync (
  ESourceCredentialsProviderImpl $provider_impl,
  ESource                        $source,
  GCancellable                   $cancellable,
  CArray[Pointer[GError]]        $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_impl_get_provider (
  ESourceCredentialsProviderImpl $provider_impl
)
  returns ESourceCredentialsProvider
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_impl_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_impl_lookup_sync (
  ESourceCredentialsProviderImpl $provider_impl,
  ESource                        $source,
  GCancellable                   $cancellable,
  CArray[ENamedParameters]       $out_credentials,
  CArray[Pointer[GError]]        $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_impl_store_sync (
  ESourceCredentialsProviderImpl $provider_impl,
  ESource                        $source,
  ENamedParameters               $credentials,
  gboolean                       $permanently,
  GCancellable                   $cancellable,
  CArray[Pointer[GError]]        $error
)
  returns uint32
  is native(eds)
  is export
{ * }
