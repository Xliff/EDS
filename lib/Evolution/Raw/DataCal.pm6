use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::DataCal;

### /usr/src/evolution-data-server-3.48.0/src/libedata-cal/e-data-cal.h

sub e_data_cal_get_connection (EDataCal $cal)
  returns GDBusConnection
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_get_object_path (EDataCal $cal)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_get_type ()
  returns GType
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_new (
  ECalBackend     $backend,
  GDBusConnection $connection,
  Str             $object_path,
  GError          $error
)
  returns EDataCal
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_ref_backend (EDataCal $cal)
  returns ECalBackend
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_report_backend_property_changed (
  EDataCal $cal,
  Str      $prop_name,
  Str      $prop_value
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_report_error (EDataCal $cal, Str $message)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_report_free_busy_data (EDataCal $cal, GSList $freebusy)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_add_timezone (
  EDataCal $cal,
  guint32  $opid,
  GError   $error
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_create_objects (
  EDataCal $cal,
  guint32 $opid,
  GError $error,
  GSList $uids,
  GSList $new_components
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_discard_alarm (
  EDataCal $cal,
  guint32  $opid,
  GError   $error
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_get_attachment_uris (
  EDataCal $cal,
  guint32  $opid,
  GError   $error,
  GSList   $attachment_uris
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_get_free_busy (
  EDataCal $cal,
  guint32  $opid,
  GError   $error,
  GSList   $freebusy
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_get_object (
  EDataCal $cal,
  guint32  $opid,
  GError   $error,
  Str      $object
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_get_object_list (
  EDataCal $cal,
  guint32  $opid,
  GError   $error,
  GSList   $objects
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_get_timezone (
  EDataCal $cal,
  guint32  $opid,
  GError   $error,
  Str      $tzobjet
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_modify_objects (
  EDataCal $cal,
  guint32  $opid,
  GError   $error,
  GSList   $old_components,
  GSList   $new_components
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_open (EDataCal $cal, guint32 $opid, GError $error)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_receive_objects (
  EDataCal $cal,
  guint32  $opid,
  GError   $error
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_refresh (EDataCal $cal, guint32 $opid, GError $error)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_remove_objects (
  EDataCal $cal,
  guint32  $opid,
  GError   $error,
  GSList   $ids,
  GSList   $old_components,
  GSList   $new_components
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_respond_send_objects (
  EDataCal $cal,
  guint32  $opid,
  GError   $error,
  GSList   $users,
  Str      $calobj
)
  is native(edata-cal)
  is export
{ * }
