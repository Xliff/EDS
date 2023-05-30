use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Calendar::Component::Alarm;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-alarm.h

sub e_cal_component_alarm_copy (ECalComponentAlarm $alarm)
  returns ECalComponentAlarm
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_fill_component (
  ECalComponentAlarm $alarm,
  ICalComponent      $component
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_free (ECalComponentAlarm $alarm)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_acknowledged (ECalComponentAlarm $alarm)
  returns ICalTime
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_action (ECalComponentAlarm $alarm)
  returns ECalComponentAlarmAction
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_as_component (ECalComponentAlarm $alarm)
  returns ICalComponent
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_attachments (ECalComponentAlarm $alarm)
  returns GSList
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_attendees (ECalComponentAlarm $alarm)
  returns GSList
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_description (ECalComponentAlarm $alarm)
  returns ECalComponentText
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_property_bag (ECalComponentAlarm $alarm)
  returns ECalComponentPropertyBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_repeat (ECalComponentAlarm $alarm)
  returns ECalComponentAlarmRepeat
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_summary (ECalComponentAlarm $alarm)
  returns ECalComponentText
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_trigger (ECalComponentAlarm $alarm)
  returns ECalComponentAlarmTrigger
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_get_uid (ECalComponentAlarm $alarm)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_has_attachments (ECalComponentAlarm $alarm)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_has_attendees (ECalComponentAlarm $alarm)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_new
  returns ECalComponentAlarm
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_new_from_component (ICalComponent $component)
  returns ECalComponentAlarm
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_acknowledged (
  ECalComponentAlarm $alarm,
  ICalTime           $when
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_action (
  ECalComponentAlarm       $alarm,
  ECalComponentAlarmAction $action
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_attachments (
  ECalComponentAlarm $alarm,
  GSList             $attachments
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_attendees (
  ECalComponentAlarm $alarm,
  GSList             $attendees
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_description (
  ECalComponentAlarm $alarm,
  ECalComponentText  $description
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_from_component (
  ECalComponentAlarm $alarm,
  ICalComponent      $component
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_repeat (
  ECalComponentAlarm       $alarm,
  ECalComponentAlarmRepeat $repeat
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_summary (
  ECalComponentAlarm $alarm,
  ECalComponentText  $summary
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_trigger (
  ECalComponentAlarm        $alarm,
  ECalComponentAlarmTrigger $trigger
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_set_uid (
  ECalComponentAlarm $alarm,
  Str                $uid
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_take_acknowledged (
  ECalComponentAlarm $alarm,
  ICalTime           $when
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_take_attachments (
  ECalComponentAlarm $alarm,
  GSList             $attachments
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_take_attendees (
  ECalComponentAlarm $alarm,
  GSList             $attendees
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_take_description (
  ECalComponentAlarm $alarm,
  ECalComponentText  $description
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_take_repeat (
  ECalComponentAlarm       $alarm,
  ECalComponentAlarmRepeat $repeat
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_take_summary (
  ECalComponentAlarm $alarm,
  ECalComponentText  $summary
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_take_trigger (
  ECalComponentAlarm        $alarm,
  ECalComponentAlarmTrigger $trigger
)
  is      native(eds)
  is      export
{ * }
