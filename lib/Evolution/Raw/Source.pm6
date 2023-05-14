use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Enums;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source.h

sub e_source_changed (ESource $source)
  is native(eds)
  is export
{ * }

sub e_source_delete_password (
  ESource      $source,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_delete_password_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_delete_password_sync (
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_dup_parent (ESource $source)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_dup_secret_label (ESource $source)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_dup_uid (ESource $source)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_emit_credentials_required (
  ESource                  $source,
  ESourceCredentialsReason $reason,
  Str                      $certificate_pem,
  GTlsCertificateFlags     $certificate_errors,
  CArray[Pointer[GError]]  $op_error
)
  is native(eds)
  is export
{ * }

sub e_source_get_enabled (ESource $source)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_get_extension (ESource $source, Str $extension_name)
  returns Pointer
  is native(eds)
  is export
{ * }

sub e_source_get_last_credentials_required_arguments (
  ESource      $source,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_get_last_credentials_required_arguments_finish (
  ESource                  $source,
  GAsyncResult             $result,
  ESourceCredentialsReason $out_reason             is rw,
  CArray[Str]              $out_certificate_pem,
  GTlsCertificateFlags     $out_certificate_errors is rw,
  CArray[Pointer[GError]]  $out_op_error,
  CArray[Pointer[GError]]  $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_get_last_credentials_required_arguments_sync (
  ESource                  $source,
  ESourceCredentialsReason $out_reason             is rw,
  CArray[Str]              $out_certificate_pem,
  GTlsCertificateFlags     $out_certificate_errors is rw,
  CArray[Pointer[GError]]  $out_op_error,
  GCancellable             $cancellable,
  CArray[Pointer[GError]]  $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_get_oauth2_access_token (
  ESource      $source,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_get_oauth2_access_token_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Str]             $out_access_token,
  gint                    $out_expires_in    is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_get_oauth2_access_token_sync (
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Str]             $out_access_token,
  gint                    $out_expires_in is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_get_remote_creatable (ESource $source)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_get_writable (ESource $source)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_has_extension (ESource $source, Str $extension_name)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_hash (ESource $source)
  returns guint
  is native(eds)
  is export
{ * }

sub e_source_invoke_authenticate (
  ESource          $source,
  ENamedParameters $credentials,
  GCancellable     $cancellable,
                   &callback (GObject, GAsyncResult, gpointer),
  gpointer         $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_invoke_authenticate_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_invoke_authenticate_sync (
  ESource                 $source,
  ENamedParameters        $credentials,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_invoke_credentials_required (
  ESource                  $source,
  ESourceCredentialsReason $reason,
  Str                      $certificate_pem,
  GTlsCertificateFlags     $certificate_errors,
  CArray[Pointer[GError]]  $op_error,
  GCancellable             $cancellable,
                           &callback (GObject, GAsyncResult, gpointer),
  gpointer                 $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_invoke_credentials_required_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_invoke_credentials_required_sync (
  ESource                  $source,
  ESourceCredentialsReason $reason,
  Str                      $certificate_pem,
  GTlsCertificateFlags     $certificate_errors,
  CArray[Pointer[GError]]  $op_error,
  GCancellable             $cancellable,
  CArray[Pointer[GError]]  $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_lookup_password (
  ESource      $source,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_lookup_password_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Str]             $out_password,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_lookup_password_sync (
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Str]             $out_password,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_new_with_uid (
  Str                     $uid,
  GMainContext            $main_context,
  CArray[Pointer[GError]] $error
)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_parameter_to_key (Str $param_name)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_ref_dbus_object (ESource $source)
  returns GDBusObject
  is native(eds)
  is export
{ * }

sub e_source_remote_create (
  ESource      $source,
  ESource      $scratch_source,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_remote_create_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_remote_create_sync (
  ESource                 $source,
  ESource                 $scratch_source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_remote_delete (
  ESource      $source,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
               gpointer $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_remote_delete_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_remote_delete_sync (
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_remove (
  ESource      $source,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_remove_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_remove_sync (
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_set_connection_status (
  ESource $source,
  ESourceConnectionStatus $connection_status
)
  is native(eds)
  is export
{ * }

sub e_source_store_password (
  ESource      $source,
  Str          $password,
  gboolean     $permanently,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_store_password_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_store_password_sync (
  ESource                 $source,
  Str                     $password,
  gboolean                $permanently,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_to_string (ESource $source, gsize $length)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_unset_last_credentials_required_arguments (
  ESource      $source,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_unset_last_credentials_required_arguments_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_unset_last_credentials_required_arguments_sync (
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_write (
  ESource      $source,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_write_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_write_sync (
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_get_display_name (ESource $source)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_set_display_name (ESource $source, Str $display_name)
  is native(eds)
  is export
{ * }
