use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Definitions;

unit package Evolution::Raw::Calendar::Component::Datetime;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-datetime.h

sub e_cal_component_datetime_copy (ECalComponentDateTime $dt)
  returns ECalComponentDateTime
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_free (ECalComponentDateTime $dt)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_get_tzid (ECalComponentDateTime $dt)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_get_value (ECalComponentDateTime $dt)
  returns ICalTime
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_new (
  ICalTime $value,
  Str      $tzid
)
  returns ECalComponentDateTime
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_new_take (
  ICalTime $value,
  Str      $tzid
)
  returns ECalComponentDateTime
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_set (
  ECalComponentDateTime $dt,
  ICalTime              $value,
  Str                   $tzid
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_set_tzid (
  ECalComponentDateTime $dt,
  Str                   $tzid
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_set_value (
  ECalComponentDateTime $dt,
  ICalTime              $value
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_take_tzid (
  ECalComponentDateTime $dt,
  Str                   $tzid
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_datetime_take_value (
  ECalComponentDateTime $dt,
  ICalTime              $value
)
  is      native(eds)
  is      export
{ * }
