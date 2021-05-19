use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Backend::Sync;

### /usr/include/evolution-data-server/libedata-cal/e-cal-backend-sync.h

sub e_cal_backend_sync_add_timezone (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  Str                     $tzobject,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_create_objects (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  GSList                  $calobjs,
  guint32                 $opflags,
  GSList                  $uids,
  GSList                  $new_components,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_discard_alarm (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  Str                     $uid,
  Str                     $rid,
  Str                     $auid,
  guint32                 $opflags,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_get_attachment_uris (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  Str                     $uid,
  Str                     $rid,
  GSList                  $attachments,
  CArray[Pointer[GError]] $error
  )
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_get_free_busy (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  GSList                  $users,
  time_t                  $start,
  time_t                  $end,
  GSList                  $freebusyobjects,
  CArray[Pointer[GError]] $error
  )
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_get_object (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  Str                     $uid,
  Str                     $rid,
  Str                     $calobj,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_get_object_list (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  Str                     $sexp,
  GSList                  $calobjs,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_get_timezone (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  Str                     $tzid,
  Str                     $tzobject,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_get_type ()
  returns GType
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_modify_objects (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  GSList                  $calobjs,
  ECalObjModType          $mod,
  guint32                 $opflags,
  GSList                  $old_components,
  GSList                  $new_components,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_open (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
 )
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_receive_objects (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  Str                     $calobj,
  guint32                 $opflags,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_refresh (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_remove_objects (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  GSList                  $ids,
  ECalObjModType          $mod,
  guint32                 $opflags,
  GSList                  $old_components,
  GSList                  $new_components,
  CArray[Pointer[GError]] $error
 )
  is native(edata-cal)
  is export
{ * }

sub e_cal_backend_sync_send_objects (
  ECalBackendSync         $backend,
  EDataCal                $cal,
  GCancellable            $cancellable,
  Str                     $calobj,
  guint32                 $opflags,
  GSList                  $users,
  Str                     $modified_calobj,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }
