use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Recur;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-recur.h

sub e_cal_recur_describe_recurrence (
  ICalComponent $icalcomp,
  GDateWeekday  $week_start_day,
  guint32       $flags
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_recur_describe_recurrence_ex (
  ICalComponent               $icalcomp,
  GDateWeekday                $week_start_day,
  guint32                     $flags,
                              &datetime_fmt_func (ICalTime, Str, gint)
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_recur_ensure_end_dates (
  ECalComponent              $comp,
  gboolean                   $refresh,
                             &tz_cb (
                               Str,
                               gpointer,
                               GCancellable,
                               CArray[Pointer[GError]]
                               --> ICalTimezone
                             ),
  gpointer                   $tz_cb_data,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_cal_recur_generate_instances_sync (
  ICalComponent              $icalcomp,
  ICalTime                   $interval_start,
  ICalTime                   $interval_end,
                             &callback (
                               ICalComponent,
                               ICalTime,
                               ICalTime,
                               gpointer,
                               GCancellable,
                               CArray[Pointer[GError]]
                               --> gboolean
                             ),
  gpointer                   $callback_user_data,
                             &get_tz_callback (
                               Str,
                               gpointer,
                               GCancellable,
                               CArray[Pointer[GError]]
                               --> ICalTimezone
                             ),
  gpointer                   $get_tz_callback_user_data,
  ICalTimezone               $default_timezone,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_cal_recur_get_localized_nth (gint $nth)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_recur_obtain_enddate (
  ICalRecurrence $ir,
  ICalProperty   $prop,
  ICalTimezone   $zone,
  gboolean       $convert_end_date
)
  returns time_t
  is      native(eds)
  is      export
{ * }
