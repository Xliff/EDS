use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::DataCal::View;

### /usr/src/evolution-data-server-3.48.0/src/libedata-cal/e-data-cal-view.h

sub e_data_cal_view_component_matches (
  EDataCalView  $view,
  ECalComponent $component
)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_get_backend (EDataCalView $view)
  returns ECalBackend
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_get_component_string (
  EDataCalView  $view,
  ECalComponent $component
)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_get_connection (EDataCalView $view)
  returns GDBusConnection
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_get_fields_of_interest (EDataCalView $view)
  returns GHashTable
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_get_flags (EDataCalView $view)
  returns ECalClientViewFlags
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_get_object_path (EDataCalView $view)
  returns Str
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_get_sexp (EDataCalView $view)
  returns ECalBackendSExp
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_get_type ()
  returns GType
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_is_completed (EDataCalView $view)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_is_started (EDataCalView $view)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_is_stopped (EDataCalView $view)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_new (
  ECalBackend             $backend,
  ECalBackendSExp         $sexp,
  GDBusConnection         $connection,
  Str                     $object_path,
  CArray[Pointer[GError]] $error
)
  returns EDataCalView
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_notify_complete (
  EDataCalView            $view,
  CArray[Pointer[GError]] $error
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_notify_components_added (
  EDataCalView $view,
  GSList       $ecalcomponents
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_notify_components_added_1 (
  EDataCalView  $view,
  ECalComponent $component
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_notify_components_modified (
  EDataCalView $view,
  GSList       $ecalcomponents
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_notify_components_modified_1 (
  EDataCalView  $view,
  ECalComponent $component
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_notify_objects_removed (EDataCalView $view, GSList $ids)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_notify_objects_removed_1 (
  EDataCalView    $view,
  ECalComponentId $id
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_notify_progress (
  EDataCalView $view,
  gint         $percent,
  Str          $message
)
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_object_matches (EDataCalView $view, Str $object)
  returns uint32
  is native(edata-cal)
  is export
{ * }

sub e_data_cal_view_ref_backend (EDataCalView $view)
  returns ECalBackend
  is native(edata-cal)
  is export
{ * }
