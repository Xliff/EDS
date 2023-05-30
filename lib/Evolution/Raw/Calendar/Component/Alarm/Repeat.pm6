use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Calendar::Component::Alarm::Repeat;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-alarm-repeat.h

sub e_cal_component_alarm_repeat_copy (ECalComponentAlarmRepeat $repeat)
  returns ECalComponentAlarmRepeat
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_free (ECalComponentAlarmRepeat $repeat)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_get_interval (
  ECalComponentAlarmRepeat $repeat
)
  returns ICalDuration
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_get_interval_seconds (
  ECalComponentAlarmRepeat $repeat
)
  returns gint
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_get_repetitions (
  ECalComponentAlarmRepeat $repeat
)
  returns gint
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_new (
  gint         $repetitions,
  ICalDuration $interval
)
  returns ECalComponentAlarmRepeat
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_new_seconds (
  gint $repetitions,
  gint $interval_seconds
)
  returns ECalComponentAlarmRepeat
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_set_interval (
  ECalComponentAlarmRepeat $repeat,
  ICalDuration             $interval
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_set_interval_seconds (
  ECalComponentAlarmRepeat $repeat,
  gint                     $interval_seconds
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_repeat_set_repetitions (
  ECalComponentAlarmRepeat $repeat,
  gint                     $repetitions
)
  is      native(eds)
  is      export
{ * }
