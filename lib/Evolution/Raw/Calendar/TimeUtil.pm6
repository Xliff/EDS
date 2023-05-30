use v6.c;

use NativeCall;

use GLib::Compat::Definitions;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-time-util.h

sub e_cal_util_icaltime_to_tm (ICalTime $itt)
  returns tm
  is      native(eds)
  is      export
{ * }

sub e_cal_util_icaltime_to_tm_with_zone (
  ICalTime     $itt,
  ICalTimezone $from_zone,
  ICalTimezone $to_zone
)
  returns tm
  is      native(eds)
  is      export
{ * }

sub e_cal_util_tm_to_icaltime (
  tm       $tm,
  gboolean $is_date
)
  returns ICalTime
  is      native(eds)
  is      export
{ * }

sub isodate_from_time_t (time_t $t)
  returns Str
  is      native(eds)
  is      export
{ * }

sub time_add_day (
  time_t $time,
  gint   $days
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_add_day_with_zone (
  time_t       $time,
  gint         $days,
  ICalTimezone $zone
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_add_month_with_zone (
  time_t       $time,
  gint         $months,
  ICalTimezone $zone
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_add_week (
  time_t $time,
  gint   $weeks
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_add_week_with_zone (
  time_t       $time,
  gint         $weeks,
  ICalTimezone $zone
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_day_begin (time_t $t)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_day_begin_with_zone (
  time_t       $time,
  ICalTimezone $zone
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_day_end (time_t $t)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_day_end_with_zone (
  time_t       $time,
  ICalTimezone $zone
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_day_of_week (
  gint $day,
  gint $month,
  gint $year
)
  returns gint
  is      native(eds)
  is      export
{ * }

sub time_day_of_year (
  gint $day,
  gint $month,
  gint $year
)
  returns gint
  is      native(eds)
  is      export
{ * }

sub time_days_in_month (
  gint $year,
  gint $month
)
  returns gint
  is      native(eds)
  is      export
{ * }

sub time_from_isodate (Str $str)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_is_leap_year (gint $year)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub time_leap_years_up_to (gint $year)
  returns gint
  is      native(eds)
  is      export
{ * }

sub time_month_begin_with_zone (
  time_t       $time,
  ICalTimezone $zone
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_to_gdate_with_zone (
  GDate        $date,
  time_t       $time,
  ICalTimezone $zone
)
  is      native(eds)
  is      export
{ * }

sub time_week_begin_with_zone (
  time_t       $time,
  gint         $week_start_day,
  ICalTimezone $zone
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub time_year_begin_with_zone (
  time_t       $time,
  ICalTimezone $zone
)
  returns time_t
  is      native(eds)
  is      export
{ * }
