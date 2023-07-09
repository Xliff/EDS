use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Calendar::Component::Period;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-period.h

sub e_cal_component_period_copy (ECalComponentPeriod $period)
  returns ECalComponentPeriod
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_free (ECalComponentPeriod $period)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_get_duration (ECalComponentPeriod $period)
  returns ICalDuration
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_get_end (ECalComponentPeriod $period)
  returns ICalTime
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_get_kind (ECalComponentPeriod $period)
  returns ECalComponentPeriodKind
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_get_start (ECalComponentPeriod $period)
  returns ICalTime
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_new_datetime (
  ICalTime $start,
  ICalTime $end
)
  returns ECalComponentPeriod
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_new_duration (
  ICalTime     $start,
  ICalDuration $duration
)
  returns ECalComponentPeriod
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_set_datetime_full (
  ECalComponentPeriod $period,
  ICalTime            $start,
  ICalTime            $end
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_set_duration (
  ECalComponentPeriod $period,
  ICalDuration        $duration
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_set_duration_full (
  ECalComponentPeriod $period,
  ICalTime            $start,
  ICalDuration        $duration
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_set_end (
  ECalComponentPeriod $period,
  ICalTime            $end
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_period_set_start (
  ECalComponentPeriod $period,
  ICalTime            $start
)
  is      native(eds)
  is      export
{ * }
