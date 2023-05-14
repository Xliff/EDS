use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use SOUP::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::OAuth2::Service;

### /usr/src/evolution-data-server-3.48.0/src/libeds/e-oauth2-service.h

sub e_oauth2_service_can_process (EOAuth2Service $service, ESource $source)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_service_delete_token_sync (
  EOAuth2Service          $service,
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_service_extract_authorization_code (
  EOAuth2Service $service,
  ESource        $source,
  Str            $page_title,
  Str            $page_uri,
  Str            $page_content,
  Str            $out_authorization_code
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_access_token_sync (
  EOAuth2Service          $service,
  ESource                 $source,
                          &ref_source (gpointer, Str),
  gpointer                $ref_source_user_data,
  CArray[Str]             $out_access_token,
  gint                    $out_expires_in is rw,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_authentication_policy (
  EOAuth2Service $service,
  ESource        $source,
  Str            $uri
)
  returns EOAuth2ServiceNavigationPolicy
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_authentication_uri (
  EOAuth2Service $service,
  ESource        $source
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_client_id (EOAuth2Service $service, ESource $source)
  returns Str
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_client_secret (
  EOAuth2Service $service,
  ESource        $source
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_display_name (EOAuth2Service $service)
  returns Str
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_flags (EOAuth2Service $service)
  returns guint32
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_name (EOAuth2Service $service)
  returns Str
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_redirect_uri (EOAuth2Service $service, ESource $source)
  returns Str
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_refresh_uri (EOAuth2Service $service, ESource $source)
  returns Str
  is native(eds)
  is export
{ * }

sub e_oauth2_service_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_oauth2_service_guess_can_process (
  EOAuth2Service $service,
  Str            $protocol,
  Str            $hostname
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_service_prepare_authentication_uri_query (
  EOAuth2Service $service,
  ESource        $source,
  GHashTable     $uri_query
)
  is native(eds)
  is export
{ * }

sub e_oauth2_service_prepare_get_token_form (
  EOAuth2Service $service,
  ESource        $source,
  Str            $authorization_code,
  GHashTable     $form
)
  is native(eds)
  is export
{ * }

sub e_oauth2_service_prepare_get_token_message (
  EOAuth2Service $service,
  ESource        $source,
  SoupMessage    $message
)
  is native(eds)
  is export
{ * }

sub e_oauth2_service_prepare_refresh_token_form (
  EOAuth2Service $service,
  ESource        $source,
  Str            $refresh_token,
  GHashTable     $form
)
  is native(eds)
  is export
{ * }

sub e_oauth2_service_prepare_refresh_token_message (
  EOAuth2Service $service,
  ESource        $source,
  SoupMessage    $message
)
  is native(eds)
  is export
{ * }

sub e_oauth2_service_receive_and_store_token_sync (
  EOAuth2Service          $service,
  ESource                 $source,
  Str                     $authorization_code,
                          &ref_source (gpointer, Str),
  gpointer                $ref_source_user_data,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_service_refresh_and_store_token_sync (
  EOAuth2Service          $service,
  ESource                 $source,
  Str                     $refresh_token,
                          &ref_source (gpointer, Str),
  gpointer                $ref_source_user_data,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_service_util_set_to_form (GHashTable $form, Str $name, Str $value)
  is native(eds)
  is export
{ * }

sub e_oauth2_service_util_take_to_form (GHashTable $form, Str $name, Str $value)
  is native(eds)
  is export
{ * }
