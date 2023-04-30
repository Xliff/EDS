use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Enums;
use SOUP::Raw::Definitions;
use SOUP::Raw::Enums;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Soup::Session;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-soup-session.h

sub e_soup_session_check_result (
  ESoupSession            $session,
  SoupMessage             $message,
  gpointer                $read_bytes,
  gsize                   $bytes_length,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_soup_session_dup_credentials (ESoupSession $session)
  returns ENamedParameters
  is      native(eds)
  is      export
{ * }

sub e_soup_session_error_quark
  returns GQuark
  is      native(eds)
  is      export
{ * }

sub e_soup_session_get_authentication_requires_credentials (ESoupSession $session)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_soup_session_get_force_http1 (ESoupSession $session)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_soup_session_get_log_level (ESoupSession $session)
  returns SoupLoggerLogLevel
  is      native(eds)
  is      export
{ * }

sub e_soup_session_get_source (ESoupSession $session)
  returns ESource
  is      native(eds)
  is      export
{ * }

sub e_soup_session_get_ssl_error_details (
  ESoupSession         $session,
  CArray[Str]          $out_certificate_pem,
  GTlsCertificateFlags $out_certificate_errors
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_soup_session_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_soup_session_handle_authentication_failure (
  ESoupSession                $session,
  ENamedParameters            $credentials,
  Pointer[GError]             $op_error,
  ESourceAuthenticationResult $out_auth_result,
  CArray[Str]                 $out_certificate_pem,
  GTlsCertificateFlags        $out_certificate_errors,
  CArray[Pointer[GError]]     $error
)
  is      native(eds)
  is      export
{ * }

sub e_soup_session_new (ESource $source)
  returns ESoupSession
  is      native(eds)
  is      export
{ * }

sub e_soup_session_new_message (
  ESoupSession            $session,
  Str                     $method,
  Str                     $uri_string,
  CArray[Pointer[GError]] $error
)
  returns SoupMessage
  is      native(eds)
  is      export
{ * }

sub e_soup_session_new_message_from_uri (
  ESoupSession            $session,
  Str                     $method,
  GUri                    $uri,
  CArray[Pointer[GError]] $error
)
  returns SoupMessage
  is      native(eds)
  is      export
{ * }

sub e_soup_session_prepare_message_send_sync (
  ESoupSession            $session,
  SoupMessage             $message,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Pointer
  is      native(eds)
  is      export
{ * }

sub e_soup_session_send_message (
  ESoupSession        $session,
  SoupMessage         $message,
  gint                $io_priority,
  gpointer            $prepare_data,
  GCancellable        $cancellable,
  GAsyncReadyCallback $callback,
  gpointer            $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_soup_session_send_message_finish (
  ESoupSession            $session,
  GAsyncResult            $result,
  CArray[Str]             $out_certificate_pem,
  GTlsCertificateFlags    $out_certificate_errors,
  CArray[Pointer[GError]] $error
)
  returns GInputStream
  is      native(eds)
  is      export
{ * }

sub e_soup_session_send_message_simple_sync (
  ESoupSession            $session,
  SoupMessage             $message,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GByteArray
  is      native(eds)
  is      export
{ * }

sub e_soup_session_send_message_sync (
  ESoupSession            $session,
  SoupMessage             $message,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GInputStream
  is      native(eds)
  is      export
{ * }

sub e_soup_session_set_credentials (
  ESoupSession     $session,
  ENamedParameters $credentials
)
  is      native(eds)
  is      export
{ * }

sub e_soup_session_set_force_http1 (
  ESoupSession $session,
  gboolean     $force_http1
)
  is      native(eds)
  is      export
{ * }

sub e_soup_session_setup_logging (
  ESoupSession $session,
  Str          $logging_level
)
  is      native(eds)
  is      export
{ * }

sub e_soup_session_util_get_force_http1_supported
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_soup_session_util_get_message_bytes (SoupMessage $message)
  returns GByteArray
  is      native(eds)
  is      export
{ * }

sub e_soup_session_util_normalize_uri_path (GUri $uri)
  returns GUri
  is      native(eds)
  is      export
{ * }

sub e_soup_session_util_ref_message_request_body (
  SoupMessage $message,
  gssize      $out_length
)
  returns GInputStream
  is      native(eds)
  is      export
{ * }

sub e_soup_session_util_set_message_request_body (
  SoupMessage  $message,
  Str          $content_type,
  GInputStream $input_stream,
  gssize       $length
)
  is      native(eds)
  is      export
{ * }

sub e_soup_session_util_set_message_request_body_from_data (
  SoupMessage    $message,
  gboolean       $create_copy,
  Str            $content_type,
  gpointer       $data,
  gssize         $length,
                 &free_func (gpointer)
)
  is      native(eds)
  is      export
{ * }

sub e_soup_session_util_status_to_string (
  guint $status_code,
  Str   $reason_phrase
)
  returns Str
  is      native(eds)
  is      export
{ * }
