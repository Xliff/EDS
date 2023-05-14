use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Enums;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Backend;

### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-backend.h

sub e_backend_credentials_required (
  EBackend                 $backend,
  ESourceCredentialsReason $reason,
  Str                      $certificate_pem,
  GTlsCertificateFlags     $certificate_errors,
  CArray[Pointer[GError]]  $op_error,
  GCancellable             $cancellable,
                           &callback (EBackend, GAsyncResult, gpointer),
  gpointer                 $user_data
)
  is native(ebackend)
  is export
{ * }

sub e_backend_credentials_required_finish (
  EBackend                $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_backend_credentials_required_sync (
  EBackend                 $backend,
  ESourceCredentialsReason $reason,
  Str                      $certificate_pem,
  GTlsCertificateFlags     $certificate_errors,
  CArray[Pointer[GError]]  $op_error,
  GCancellable             $cancellable,
  CArray[Pointer[GError]]  $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_backend_ensure_online_state_updated (
  EBackend     $backend,
  GCancellable $cancellable
)
  is native(ebackend)
  is export
{ * }

sub e_backend_ensure_source_status_connected (EBackend $backend)
  is native(ebackend)
  is export
{ * }

sub e_backend_get_destination_address (
  EBackend    $backend,
  CArray[Str] $host,
  guint16     $port is rw
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_backend_get_online (EBackend $backend)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_backend_get_source (EBackend $backend)
  returns ESource
  is native(ebackend)
  is export
{ * }

sub e_backend_get_type ()
  returns GType
  is native(ebackend)
  is export
{ * }

sub e_backend_get_user_prompter (EBackend $backend)
  returns EUserPrompter
  is native(ebackend)
  is export
{ * }

sub e_backend_is_destination_reachable (
  EBackend                $backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_backend_prepare_shutdown (EBackend $backend)
  is native(ebackend)
  is export
{ * }

sub e_backend_ref_connectable (EBackend $backend)
  returns GSocketConnectable
  is native(ebackend)
  is export
{ * }

sub e_backend_ref_main_context (EBackend $backend)
  returns GMainContext
  is native(ebackend)
  is export
{ * }

sub e_backend_schedule_authenticate (
  EBackend         $backend,
  ENamedParameters $credentials
)
  is native(ebackend)
  is export
{ * }

sub e_backend_schedule_credentials_required (
  EBackend                 $backend,
  ESourceCredentialsReason $reason,
  Str                      $certificate_pem,
  GTlsCertificateFlags     $certificate_errors,
  GError                   $op_error,
  GCancellable             $cancellable,
  Str                      $who_calls
)
  is native(ebackend)
  is export
{ * }

sub e_backend_set_connectable (
  EBackend           $backend,
  GSocketConnectable $connectable
)
  is native(ebackend)
  is export
{ * }

sub e_backend_set_online (EBackend $backend, gboolean $online)
  is native(ebackend)
  is export
{ * }

sub e_backend_trust_prompt (
  EBackend         $backend,
  ENamedParameters $parameters,
  GCancellable     $cancellable,
                   &callback (EBackend, GAsyncResult, gpointer),
  gpointer         $user_data
)
  is native(ebackend)
  is export
{ * }

sub e_backend_trust_prompt_finish (
  EBackend                $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns ETrustPromptResponse
  is native(ebackend)
  is export
{ * }

sub e_backend_trust_prompt_sync (
  EBackend                $backend,
  ENamedParameters        $parameters,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns ETrustPromptResponse
  is native(ebackend)
  is export
{ * }
