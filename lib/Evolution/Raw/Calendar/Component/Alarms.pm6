use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Component::Alarms;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-alarms.h

sub e_cal_component_alarms_add_instance (
  ECalComponentAlarms        $alarms,
  ECalComponentAlarmInstance $instance
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_copy (ECalComponentAlarms $alarms)
  returns ECalComponentAlarms
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_free (ECalComponentAlarms $alarms)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_get_component (ECalComponentAlarms $alarms)
  returns ECalComponent
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_get_instances (ECalComponentAlarms $alarms)
  returns GSList
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_new (ECalComponent $comp)
  returns ECalComponentAlarms
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_remove_instance (
  ECalComponentAlarms        $alarms,
  ECalComponentAlarmInstance $instance
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_set_instances (
  ECalComponentAlarms $alarms,
  GSList              $instances
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_take_instance (
  ECalComponentAlarms        $alarms,
  ECalComponentAlarmInstance $instance
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_alarms_take_instances (
  ECalComponentAlarms $alarms,
  GSList              $instances
)
  is      native(eds)
  is      export
{ * }
