use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Object;
use GIO::Raw::Definitions;
use ICal::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar;

### /usr/include/evolution-data-server/libecal/e-cal-client.h

sub e_cal_client_add_timezone (
  ECalClient   $client,
  icaltimezone $zone,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_add_timezone_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_add_timezone_sync (
  ECalClient              $client,
  icaltimezone            $zone,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_check_one_alarm_only (ECalClient $client)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_check_organizer_must_accept (ECalClient $client)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_check_organizer_must_attend (ECalClient $client)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_check_recurrences_no_master (ECalClient $client)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_check_save_schedules (ECalClient $client)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_connect (
  ESource              $source,
  ECalClientSourceType $source_type,
  guint32              $wait_for_connected_seconds,
  GCancellable         $cancellable,
                       &callback (GObject, GAsyncResult, gpointer),
  gpointer             $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_connect_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns EClient
  is native(ecal)
  is export
{ * }

sub e_cal_client_connect_sync (
  ESource                 $source,
  ECalClientSourceType    $source_type,
  guint32                 $wait_for_connected_seconds,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns EClient
  is native(ecal)
  is export
{ * }

sub e_cal_client_create_object (
  ECalClient    $client,
  icalcomponent $icalcomp,
  guint32       $opflags,
  GCancellable  $cancellable,
                &callback (GObject, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_create_object_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Str]             $out_uid,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_create_object_sync (
  ECalClient              $client,
  icalcomponent           $icalcomp,
  guint32                 $opflags,
  CArray[Str]             $out_uid,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_create_objects (
  ECalClient   $client,
  GSList       $icalcomps,
  guint32      $opflags,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_create_objects_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GSList]] $out_uids,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_create_objects_sync (
  ECalClient              $client,
  GSList                  $icalcomps,
  guint32                 $opflags,
  CArray[Pointer[GSList]] $out_uids,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_discard_alarm (
  ECalClient   $client,
  Str          $uid,
  Str          $rid,
  Str          $auid,
  guint32      $opflags,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_discard_alarm_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_discard_alarm_sync (
  ECalClient              $client,
  Str                     $uid,
  Str                     $rid,
  Str                     $auid,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_error_create (ECalClientError $code, Str $custom_msg)
  returns GError
  is native(ecal)
  is export
{ * }

# sub e_cal_client_error_create_fmt (ECalClientError $code, Str $format, ...)
#   returns GError
#   is native(ecal)
#   is export
# { * }

sub e_cal_client_error_to_string (ECalClientError $code)
  returns Str
  is native(ecal)
  is export
{ * }

sub e_cal_client_generate_instances (
  ECalClient   $client,
  time_t       $start,
  time_t       $end,
  GCancellable $cancellable,
               &cb (ECalComponent, time_t, time_t, gpointer --> gboolean),
  gpointer     $cb_data,
               &notify (gpointer)
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_generate_instances_for_object (
  ECalClient    $client,
  icalcomponent $icalcomp,
  time_t        $start,
  time_t        $end,
  GCancellable  $cancellable,
                &cb (ECalComponent, time_t, time_t, gpointer --> gboolean),
  gpointer      $cb_data,
                &notify (gpointer)
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_generate_instances_for_object_sync (
  ECalClient    $client,
  icalcomponent $icalcomp,
  time_t        $start,
  time_t        $end,
  GCancellable  $cancellable,
                &cb (ECalComponent, time_t, time_t, gpointer --> gboolean),
  gpointer      $cb_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_generate_instances_sync (
  ECalClient   $client,
  time_t       $start,
  time_t       $end,
  GCancellable $cancellable,
               &cb (ECalComponent, time_t, time_t, gpointer --> gboolean),
  gpointer     $cb_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_attachment_uris (
  ECalClient   $client,
  Str          $uid,
  Str          $rid,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_attachment_uris_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GSList]] $out_attachment_uris,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_attachment_uris_sync (
  ECalClient              $client,
  Str                     $uid,
  Str                     $rid,
  CArray[Pointer[GSList]] $out_attachment_uris,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_component_as_string (
  ECalClient $client,
  icalcomponent $icalcomp
)
  returns Str
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_default_object (ECalClient $client,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_default_object_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[icalcomponent]   $out_icalcomp,
  CArray[Pointer[GError]] $error
  )
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_default_object_sync (
  ECalClient              $client,
  CArray[icalcomponent]   $out_icalcomp,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_default_timezone (ECalClient $client)
  returns icaltimezone
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_free_busy (
  ECalClient   $client,
  time_t       $start,
  time_t       $end,
  GSList       $users,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_free_busy_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GSList]] $out_freebusy,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_free_busy_sync (
  ECalClient              $client,
  time_t                  $start,
  time_t                  $end,
  GSList                  $users,
  CArray[Pointer[GSList]] $out_freebusy,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_local_attachment_store (ECalClient $client)
  returns Str
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_object (
  ECalClient   $client,
  Str          $uid,
  Str          $rid,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal
)
  is export
{ * }

sub e_cal_client_get_object_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[icalcomponent]   $out_icalcomp,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_object_list (
  ECalClient   $client,
  Str          $sexp,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_object_list_as_comps (
  ECalClient   $client,
  Str          $sexp,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_object_list_as_comps_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GSList]] $out_ecalcomps,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_object_list_as_comps_sync (
  ECalClient              $client,
  Str                     $sexp,
  CArray[Pointer[GSList]] $out_ecalcomps,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_object_list_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GSList]] $out_icalcomps,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_object_list_sync (
  ECalClient              $client,
  Str                     $sexp,
  CArray[Pointer[GSList]] $out_icalcomps,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_object_sync (
  ECalClient                     $client,
  Str                            $uid,
  Str                            $rid,
  CArray[icalcomponent]          $out_icalcomp,
  GCancellable                   $cancellable,
  CArray[Pointer[GError]]        $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_objects_for_uid (
  ECalClient   $client,
  Str          $uid,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_objects_for_uid_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GSList]] $out_ecalcomps,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_objects_for_uid_sync (
  ECalClient              $client,
  Str                     $uid,
  CArray[Pointer[GSList]] $out_ecalcomps,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_source_type (ECalClient $client)
  returns ECalClientSourceType
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_timezone (
  ECalClient   $client,
  Str          $tzid,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_timezone_finish (
  ECalClient                    $client,
  GAsyncResult                  $result,
  CArray[Pointer[icaltimezone]] $out_zone,
  CArray[Pointer[GError]]       $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_timezone_sync (
  ECalClient                    $client,
  Str                           $tzid,
  CArray[Pointer[icaltimezone]] $out_zone,
  GCancellable                  $cancellable,
  CArray[Pointer[GError]]       $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_type ()
  returns GType
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_view (
  ECalClient   $client,
  Str          $sexp,
  GCancellable $cancellable,
               &callback (GObject, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_view_finish (
  ECalClient                      $client,
  GAsyncResult                    $result,
  CArray[Pointer[ECalClientView]] $out_view,
  CArray[Pointer[GError]]         $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_get_view_sync (
  ECalClient                      $client,
  Str                             $sexp,
  CArray[Pointer[ECalClientView]] $out_view,
  GCancellable                    $cancellable,
  CArray[Pointer[GError]]         $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_modify_object (
  ECalClient     $client,
  icalcomponent  $icalcomp,
  ECalObjModType $mod,
  guint32        $opflags,
  GCancellable   $cancellable,
                 &callback (GObject, GAsyncResult, gpointer),
  gpointer       $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_modify_object_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_modify_object_sync (
  ECalClient              $client,
  icalcomponent           $icalcomp,
  ECalObjModType          $mod,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_modify_objects (
  ECalClient     $client,
  GSList         $icalcomps,
  ECalObjModType $mod,
  guint32        $opflags,
  GCancellable   $cancellable,
                 &callback (GObject, GAsyncResult, gpointer),
  gpointer       $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_modify_objects_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_modify_objects_sync (
  ECalClient              $client,
  GSList                  $icalcomps,
  ECalObjModType          $mod,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_receive_objects (
  ECalClient    $client,
  icalcomponent $icalcomp,
  guint32       $opflags,
  GCancellable  $cancellable,
                &callback (GObject, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_receive_objects_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_receive_objects_sync (
  ECalClient              $client,
  icalcomponent           $icalcomp,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_remove_object (
  ECalClient     $client,
  Str            $uid,
  Str            $rid,
  ECalObjModType $mod,
  guint32        $opflags,
  GCancellable   $cancellable,
                 &callback (GObject, GAsyncResult, gpointer),
  gpointer       $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_remove_object_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_remove_object_sync (
  ECalClient              $client,
  Str                     $uid,
  Str                     $rid,
  ECalObjModType          $mod,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_remove_objects (
  ECalClient     $client,
  GSList         $ids,
  ECalObjModType $mod,
  guint32        $opflags,
  GCancellable   $cancellable,
                 &callback (GObject, GAsyncResult, gpointer),
  gpointer       $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_remove_objects_finish (
  ECalClient              $client,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_remove_objects_sync (
  ECalClient              $client,
  GSList                  $ids,
  ECalObjModType          $mod,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_send_objects (
  ECalClient    $client,
  icalcomponent $icalcomp,
  guint32       $opflags,
  GCancellable  $cancellable,
                &callback (GObject, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(ecal)
  is export
{ * }

sub e_cal_client_send_objects_finish (
  ECalClient                     $client,
  GAsyncResult                   $result,
  CArray[Pointer[GSList]]        $out_users,
  CArray[icalcomponent]          $out_modified_icalcomp,
  CArray[Pointer[GError]]        $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_send_objects_sync (
  ECalClient                     $client,
  icalcomponent                  $icalcomp,
  guint32                        $opflags,
  CArray[Pointer[GSList]]        $out_users,
  CArray[icalcomponent]          $out_modified_icalcomp,
  GCancellable                   $cancellable,
  CArray[Pointer[GError]]        $error
)
  returns uint32
  is native(ecal)
  is export
{ * }

sub e_cal_client_set_default_timezone (ECalClient $client, icaltimezone $zone)
  is native(ecal)
  is export
{ * }
