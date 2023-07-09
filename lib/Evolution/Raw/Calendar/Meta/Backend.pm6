use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Enums;
use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Meta::Backend;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libedata-cal/e-cal-meta-backend.h

sub e_cal_meta_backend_connect_sync (
  ECalMetaBackend             $meta_backend,
  ENamedParameters            $credentials,
  ESourceAuthenticationResult $out_auth_result,
  CArray[Str]                 $out_certificate_pem,
  GTlsCertificateFlags        $out_certificate_errors,
  GCancellable                $cancellable,
  CArray[Pointer[GError]]     $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_disconnect_sync (
  ECalMetaBackend         $meta_backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_dup_sync_tag (ECalMetaBackend $meta_backend)
  returns Str
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_empty_cache_sync (
  ECalMetaBackend         $meta_backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_ensure_connected_sync (
  ECalMetaBackend         $meta_backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_gather_timezones_sync (
  ECalMetaBackend         $meta_backend,
  ICalComponent           $vcalendar,
  gboolean                $remove_existing,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_get_capabilities (ECalMetaBackend $meta_backend)
  returns Str
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_get_changes_sync (
  ECalMetaBackend         $meta_backend,
  Str                     $last_sync_tag,
  gboolean                $is_repeat,
  CArray[Str]             $out_new_sync_tag,
  gboolean                $out_repeat,
  CArray[GSList]          $out_created_objects,
  CArray[GSList]          $out_modified_objects,
  CArray[GSList]          $out_removed_objects,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_get_connected_writable (ECalMetaBackend $meta_backend)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_get_ever_connected (ECalMetaBackend $meta_backend)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_get_ssl_error_details (
  ECalMetaBackend      $meta_backend,
  CArray[Str]          $out_certificate_pem,
  GTlsCertificateFlags $out_certificate_errors
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_get_type
  returns GType
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_info_copy (ECalMetaBackendInfo $src)
  returns ECalMetaBackendInfo
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_info_free (ECalMetaBackendInfo $ptr)
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_info_new (
  Str $uid,
  Str $revision,
  Str $object,
  Str $extra
)
  returns ECalMetaBackendInfo
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_inline_local_attachments_sync (
  ECalMetaBackend         $meta_backend,
  ICalComponent           $component,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_list_existing_sync (
  ECalMetaBackend         $meta_backend,
  CArray[Str]             $out_new_sync_tag,
  CArray[GSList]          $out_existing_objects,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_load_component_sync (
  ECalMetaBackend         $meta_backend,
  Str                     $uid,
  Str                     $extra,
  CArray[ICalComponent]   $out_component,
  CArray[Str]             $out_extra,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_merge_instances (
  ECalMetaBackend $meta_backend,
  GSList          $instances,
  gboolean        $replace_tzid_with_location
)
  returns ICalComponent
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_process_changes_sync (
  ECalMetaBackend         $meta_backend,
  GSList                  $created_objects,
  GSList                  $modified_objects,
  GSList                  $removed_objects,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_ref_cache (ECalMetaBackend $meta_backend)
  returns ECalCache
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_refresh_sync (
  ECalMetaBackend         $meta_backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_remove_component_sync (
  ECalMetaBackend         $meta_backend,
  EConflictResolution     $conflict_resolution,
  Str                     $uid,
  Str                     $extra,
  Str                     $object,
  ECalOperationFlags      $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_requires_reconnect (ECalMetaBackend $meta_backend)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_save_component_sync (
  ECalMetaBackend         $meta_backend,
  gboolean                $overwrite_existing,
  EConflictResolution     $conflict_resolution,
  GSList                  $instances,
  Str                     $extra,
  ECalOperationFlags      $opflags,
  CArray[Str]             $out_new_uid,
  CArray[Str]             $out_new_extra,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_schedule_refresh (ECalMetaBackend $meta_backend)
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_search_components_sync (
  ECalMetaBackend         $meta_backend,
  Str                     $expr,
  CArray[GSList]          $out_components,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_search_sync (
  ECalMetaBackend         $meta_backend,
  Str                     $expr,
  CArray[GSList]          $out_icalstrings,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_set_cache (
  ECalMetaBackend $meta_backend,
  ECalCache       $cache
)
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_set_connected_writable (
  ECalMetaBackend $meta_backend,
  gboolean        $value
)
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_set_ever_connected (
  ECalMetaBackend $meta_backend,
  gboolean        $value
)
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_split_changes_sync (
  ECalMetaBackend         $meta_backend,
  GSList                  $objects,
  CArray[GSList]          $out_created_objects,
  CArray[GSList]          $out_modified_objects,
  CArray[GSList]          $out_removed_objects,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }

sub e_cal_meta_backend_store_inline_attachments_sync (
  ECalMetaBackend         $meta_backend,
  ICalComponent           $component,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(edata-cal)
  is      export
{ * }
