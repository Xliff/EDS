use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Calendar::Component::Alarm::Trigger;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-alarm-trigger.h

sub e_cal_component_alarm_trigger_copy (ECalComponentAlarmTrigger $trigger)
  returns ECalComponentAlarmTrigger
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_fill_property (
  ECalComponentAlarmTrigger $trigger,
  ICalProperty              $property
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_free (ECalComponentAlarmTrigger $trigger)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_get_absolute_time (
  ECalComponentAlarmTrigger $trigger
)
  returns ICalTime
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_get_as_property (
  ECalComponentAlarmTrigger $trigger
)
  returns ICalProperty
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_get_duration (
  ECalComponentAlarmTrigger $trigger
)
  returns ICalDuration
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_get_kind (
  ECalComponentAlarmTrigger $trigger
)
  returns ECalComponentAlarmTriggerKind
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_get_parameter_bag (
  ECalComponentAlarmTrigger $trigger
)
  returns ECalComponentParameterBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_new_absolute (ICalTime $absolute_time)
  returns ECalComponentAlarmTrigger
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_new_from_property (ICalProperty $property)
  returns ECalComponentAlarmTrigger
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_new_relative (
  ECalComponentAlarmTriggerKind $kind,
  ICalDuration                  $duration
)
  returns ECalComponentAlarmTrigger
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_set_absolute (
  ECalComponentAlarmTrigger $trigger,
  ICalTime                  $absolute_time
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_set_absolute_time (
  ECalComponentAlarmTrigger $trigger,
  ICalTime                  $absolute_time
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_set_duration (
  ECalComponentAlarmTrigger $trigger,
  ICalDuration              $duration
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_set_from_property (
  ECalComponentAlarmTrigger $trigger,
  ICalProperty              $property
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_set_kind (
  ECalComponentAlarmTrigger     $trigger,
  ECalComponentAlarmTriggerKind $kind
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_trigger_set_relative (
  ECalComponentAlarmTrigger     $trigger,
  ECalComponentAlarmTriggerKind $kind,
  ICalDuration                  $duration
)
  is      native(eds)
  is      export
{ * }
