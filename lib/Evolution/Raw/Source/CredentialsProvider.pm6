use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::CredentialsProvider;

### /usr/include/evolution-data-server/libeds/e-source-credentials-provider.h

sub e_source_credentials_provider_can_prompt (
  ESourceCredentialsProvider $provider,
  ESource                    $source
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_can_store (
  ESourceCredentialsProvider $provider,
  ESource                    $source
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_delete (
  ESourceCredentialsProvider $provider,
  ESource                    $source,
  GCancellable               $cancellable,
                             &callback (
                               ESourceCredentialsProvider,
                               GAsyncResult,
                               gpointer
                             ),
  gpointer                   $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_delete_finish (
  ESourceCredentialsProvider $provider,
  GAsyncResult               $result,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_delete_sync (
  ESourceCredentialsProvider $provider,
  ESource                    $source,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_lookup (
  ESourceCredentialsProvider $provider,
  ESource                    $source,
  GCancellable               $cancellable,
                             &callback (
                               ESourceCredentialsProvider,
                               GAsyncResult,
                               gpointer
                             ),
  gpointer                   $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_lookup_finish (
  ESourceCredentialsProvider $provider,
  GAsyncResult               $result,
  ENamedParameters           $out_credentials,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_lookup_sync (
  ESourceCredentialsProvider $provider,
  ESource                    $source,
  GCancellable               $cancellable,
  ENamedParameters           $out_credentials,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_new (ESourceRegistry $registry)
  returns ESourceCredentialsProvider
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_ref_credentials_source (
  ESourceCredentialsProvider $provider,
  ESource                    $source
)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_ref_registry (
  ESourceCredentialsProvider $provider
)
  returns GObject
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_ref_source (
  ESourceCredentialsProvider $provider,
  Str                        $uid
)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_register_impl (
  ESourceCredentialsProvider     $provider,
  ESourceCredentialsProviderImpl $provider_impl
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_store (
  ESourceCredentialsProvider $provider,
  ESource                    $source,
  ENamedParameters           $credentials,
  gboolean                   $permanently,
  GCancellable               $cancellable,
                             &callback (
                               ESourceCredentialsProvider,
                               GAsyncResult,
                               gpointer
                             ),
  gpointer                   $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_store_finish (
  ESourceCredentialsProvider $provider,
  GAsyncResult               $result,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_store_sync (
  ESourceCredentialsProvider $provider,
  ESource                    $source,
  ENamedParameters           $credentials,
  gboolean                   $permanently,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_credentials_provider_unregister_impl (
  ESourceCredentialsProvider     $provider,
  ESourceCredentialsProviderImpl $provider_impl
)
  is native(eds)
  is export
{ * }
