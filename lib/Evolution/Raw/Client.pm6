use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Object;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Client;

### /usr/include/evolution-data-server/libedataserver/e-client.h

sub e_client_cancel_all (EClient $client)
  is native(eds)
  is export
{ * }

sub e_client_check_capability (EClient $client, Str $capability)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_check_refresh_supported (EClient $client)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_dup_bus_name (EClient $client)
  returns Str
  is native(eds)
  is export
{ * }

sub e_client_error_create (EClientError $code, Str $custom_msg)
  returns GError
  is native(eds)
  is export
{ * }

# sub e_client_error_create_fmt (EClientError $code, Str $format, ...)
#   returns GError
#   is native(eds)
#   is export
# { * }

sub e_client_error_to_string (EClientError $code)
  returns Str
  is native(eds)
  is export
{ * }

sub e_client_get_backend_property (
  EClient      $client,
  Str          $prop_name,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_client_get_backend_property_finish (
  EClient                 $client,
  GAsyncResult            $result,
  Str                     $prop_value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_get_backend_property_sync (
  EClient                 $client,
  Str                     $prop_name,
  Str                     $prop_value,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_get_capabilities (EClient $client)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_client_get_source (EClient $client)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_client_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_client_is_online (EClient $client)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_is_opened (EClient $client)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_is_readonly (EClient $client)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_open (
  EClient      $client,
  gboolean     $only_if_exists,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_client_open_finish (
  EClient                 $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
 )
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_open_sync (
  EClient                 $client,
  gboolean                $only_if_exists,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
 )
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_ref_main_context (EClient $client)
  returns GMainContext
  is native(eds)
  is export
{ * }

sub e_client_refresh (
  EClient      $client,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_client_refresh_finish (
  EClient                 $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_refresh_sync (
  EClient                 $client,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_remove (
  EClient      $client,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_client_remove_finish (
  EClient                 $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_remove_sync (
  EClient                 $client,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_retrieve_capabilities (
  EClient      $client,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_client_retrieve_capabilities_finish (
  EClient                  $client,
  GAsyncResult             $result,
  Str                      $capabilities,
  CArray[Pointer[GError]]  $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_retrieve_capabilities_sync (
  EClient                 $client,
  Str                     $capabilities,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_retrieve_properties (
  EClient      $client,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_client_retrieve_properties_finish (
  EClient                 $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_retrieve_properties_sync (
  EClient                 $client,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_set_backend_property (
  EClient      $client,
  Str          $prop_name,
  Str          $prop_value,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_client_set_backend_property_finish (
  EClient                 $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_set_backend_property_sync (
  EClient                 $client,
  Str                     $prop_name,
  Str                     $prop_value,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_set_bus_name (EClient $client, Str $bus_name)
  is native(eds)
  is export
{ * }

sub e_client_unwrap_dbus_error (
  EClient                 $client,
  GError                  $dbus_error,
  CArray[Pointer[GError]] $out_error
)
  is native(eds)
  is export
{ * }

sub e_client_util_copy_object_slist (GSList $copy_to, GSList $objects)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_client_util_copy_string_slist (GSList $copy_to, GSList $strings)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_client_util_free_object_slist (GSList $objects)
  is native(eds)
  is export
{ * }

sub e_client_util_free_string_slist (GSList $strings)
  is native(eds)
  is export
{ * }

sub e_client_util_parse_comma_strings (Str $strings)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_client_util_slist_to_strv (GSList $strings)
  returns Str
  is native(eds)
  is export
{ * }

sub e_client_util_strv_to_slist (Str $strv)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_client_util_unwrap_dbus_error (
  GError                  $dbus_error,
  CArray[Pointer[GError]] $client_error,
  EClientErrorsList       $known_errors,
  guint                   $known_errors_count,
  GQuark                  $known_errors_domain,
  gboolean                $fail_when_none_matched
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_wait_for_connected (
  EClient      $client,
  guint32      $timeout_seconds,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_client_wait_for_connected_finish (
  EClient                 $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_client_wait_for_connected_sync (
  EClient                 $client,
  guint32                 $timeout_seconds,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }
