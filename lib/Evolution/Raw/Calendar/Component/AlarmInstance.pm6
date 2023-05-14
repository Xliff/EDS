use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Component::AlarmInstance;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-alarm-instance.h

sub e_cal_component_alarm_instance_copy (ECalComponentAlarmInstance $instance)
  returns ECalComponentAlarmInstance
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_free (ECalComponentAlarmInstance $instance)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_get_component (
  ECalComponentAlarmInstance $instance
)
  returns ECalComponent
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_get_occur_end (
  ECalComponentAlarmInstance $instance
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_get_occur_start (
  ECalComponentAlarmInstance $instance
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_get_rid (
  ECalComponentAlarmInstance $instance
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_get_time (
  ECalComponentAlarmInstance $instance
)
  returns time_t
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_get_uid (
  ECalComponentAlarmInstance $instance
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_new (
  Str    $uid,
  time_t $instance_time,
  time_t $occur_start,
  time_t $occur_end
)
  returns ECalComponentAlarmInstance
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_set_component (
  ECalComponentAlarmInstance $instance,
  ECalComponent              $component
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_set_occur_end (
  ECalComponentAlarmInstance $instance,
  time_t                     $occur_end
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_set_occur_start (
  ECalComponentAlarmInstance $instance,
  time_t                     $occur_start
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_set_rid (
  ECalComponentAlarmInstance $instance,
  Str                        $rid
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_set_time (
  ECalComponentAlarmInstance $instance,
  time_t                     $instance_time
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarm_instance_set_uid (
  ECalComponentAlarmInstance $instance,
  Str                        $uid
)
  is      native(eds)
  is      export
{ * }
