use v6.c;

use NativeCall;

use ICal::Raw::Enums;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Backend;

### /usr/include/evolution-data-server/libedata-cal/e-cal-backend.h

sub e_cal_backend_add_timezone (
  ECalBackend  $backend,
  Str          $tzobject,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_add_timezone_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_add_timezone_sync (
  ECalBackend             $backend,
  Str                     $tzobject,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_add_view (ECalBackend $backend, EDataCalView $view)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_create_cache_filename (
  ECalBackend $backend,
  Str         $uid,
  Str         $filename,
  gint        $fileindex
)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_create_objects (
  ECalBackend  $backend,
  Str          $calobjs,
  guint32      $opflags,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_create_objects_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GQueue]] $out_uids,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_create_objects_sync (
  ECalBackend             $backend,
  Str                     $calobjs,
  guint32                 $opflags,
  CArray[Pointer[GQueue]] $out_uids,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_discard_alarm (
  ECalBackend  $backend,
  Str          $uid,
  Str          $rid,
  Str          $alarm_uid,
  guint32      $opflags,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_discard_alarm_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_discard_alarm_sync (
  ECalBackend             $backend,
  Str                     $uid,
  Str                     $rid,
  Str                     $alarm_uid,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_dup_cache_dir (ECalBackend $backend)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_foreach_view (
  ECalBackend $backend,
              &func (ECalBackend, EDataCalView, gpointer),
  gpointer    $user_data
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_foreach_view_notify_progress (
  ECalBackend $backend,
  gboolean $only_completed_views, gint $percent, Str $message)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_attachment_uris (
  ECalBackend  $backend,
  Str          $uid,
  Str          $rid,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_attachment_uris_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GQueue]] $out_attachment_uris,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_attachment_uris_sync (
  ECalBackend             $backend,
  Str                     $uid,
  Str                     $rid,
  CArray[Pointer[GQueue]] $out_attachment_uris,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_backend_property (ECalBackend $backend, Str $prop_name)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_cache_dir (ECalBackend $backend)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_free_busy (
  ECalBackend  $backend,
  time_t       $start,
  time_t       $end,
  Str          $users,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_free_busy_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GSList]] $out_freebusy,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_free_busy_sync (
  ECalBackend             $backend,
  time_t                  $start,
  time_t                  $end,
  Str                     $users,
  CArray[Pointer[GSList]] $out_freebusy,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_kind (ECalBackend $backend)
  returns icalcomponent_kind
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_object (
  ECalBackend  $backend,
  Str          $uid,
  Str          $rid,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_object_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_object_list (
  ECalBackend  $backend,
  Str          $query,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_object_list_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GQueue]] $out_objects,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_object_list_sync (
  ECalBackend             $backend,
  Str                     $query,
  CArray[Pointer[GQueue]] $out_objects,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_object_sync (
  ECalBackend             $backend,
  Str                     $uid,
  Str                     $rid,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_registry (ECalBackend $backend)
  returns ESourceRegistry
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_timezone (
  ECalBackend  $backend,
  Str          $tzid,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_timezone_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_timezone_sync (
  ECalBackend             $backend,
  Str                     $tzid,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_type ()
  returns GType
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_get_writable (ECalBackend $backend)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_is_opened (ECalBackend $backend)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_is_readonly (ECalBackend $backend)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_list_views (ECalBackend $backend)
  returns GList
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_modify_objects (
  ECalBackend    $backend,
  Str            $calobjs,
  ECalObjModType $mod,
  guint32        $opflags,
  GCancellable   $cancellable,
                 &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer       $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_modify_objects_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_modify_objects_sync (
  ECalBackend             $backend,
  Str                     $calobjs,
  ECalObjModType          $mod,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_notify_component_created (
  ECalBackend   $backend,
  ECalComponent $component
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_notify_component_modified (
  ECalBackend   $backend,
  ECalComponent $old_component,
  ECalComponent $new_component
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_notify_component_removed (
  ECalBackend     $backend,
  ECalComponentId $id,
  ECalComponent   $old_component,
  ECalComponent   $new_component
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_notify_error (ECalBackend $backend, Str $message)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_notify_property_changed (
  ECalBackend $backend,
  Str         $prop_name,
  Str         $prop_value
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_open (
  ECalBackend  $backend,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_open_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_open_sync (
  ECalBackend             $backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_prepare_for_completion (
  ECalBackend $backend,
  guint       $opid,
  GQueue      $result_queue
)
  returns GSimpleAsyncResult
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_receive_objects (
  ECalBackend  $backend,
  Str          $calobj,
  guint32      $opflags,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_receive_objects_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_receive_objects_sync (
  ECalBackend             $backend,
  Str                     $calobj,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_ref_data_cal (ECalBackend $backend)
  returns EDataCal
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_ref_proxy_resolver (ECalBackend $backend)
  returns GProxyResolver
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_refresh (
  ECalBackend  $backend,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_refresh_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_refresh_sync (
  ECalBackend             $backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_remove_objects (
  ECalBackend    $backend,
  GList          $component_ids,
  ECalObjModType $mod,
  guint32        $opflags,
  GCancellable   $cancellable,
                 &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer       $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_remove_objects_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_remove_objects_sync (
  ECalBackend             $backend,
  GList                   $component_ids,
  ECalObjModType          $mod,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_remove_view (ECalBackend $backend, EDataCalView $view)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_schedule_custom_operation (
  ECalBackend    $cal_backend,
  GCancellable   $use_cancellable,
                 &func (
                   ECalBackend,
                   gpointer,
                   GCancellable,
                   CArray[Pointer[GError]]
                 ),
  gpointer       $user_data,
  GDestroyNotify $user_data_free
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_send_objects (
  ECalBackend  $backend,
  Str          $calobj,
  guint32      $opflags,
  GCancellable $cancellable,
               &callback (ECalBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_send_objects_finish (
  ECalBackend             $backend,
  GAsyncResult            $result,
  CArray[Pointer[GQueue]] $out_users,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_send_objects_sync (
  ECalBackend             $backend,
  Str                     $calobj,
  guint32                 $opflags,
  CArray[Pointer[GQueue]] $out_users,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_set_cache_dir (ECalBackend $backend, Str $cache_dir)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_set_data_cal (ECalBackend $backend, EDataCal $data_cal)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_set_writable (ECalBackend $backend, gboolean $writable)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_start_view (ECalBackend $backend, EDataCalView $view)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_stop_view (ECalBackend $backend, EDataCalView $view)
  is native(edata-cal)
  is export
{ * }
