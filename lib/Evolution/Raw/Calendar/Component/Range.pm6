use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Calendar::Component::Range;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-range.h

sub e_cal_component_range_copy (ECalComponentRange $range)
  returns ECalComponentRange
  is      native(ecal)
  is      export
{ * }

sub e_cal_component_range_free (ECalComponentRange $range)
  is      native(ecal)
  is      export
{ * }

sub e_cal_component_range_get_datetime (ECalComponentRange $range)
  returns ECalComponentDateTime
  is      native(ecal)
  is      export
{ * }

sub e_cal_component_range_get_kind (ECalComponentRange $range)
  returns ECalComponentRangeKind
  is      native(ecal)
  is      export
{ * }

sub e_cal_component_range_get_type
  returns GType
  is      native(ecal)
  is      export
{ * }

sub e_cal_component_range_new (
  ECalComponentRangeKind $kind,
  ECalComponentDateTime  $datetime
)
  returns ECalComponentRange
  is      native(ecal)
  is      export
{ * }

sub e_cal_component_range_new_take (
  ECalComponentRangeKind $kind,
  ECalComponentDateTime  $datetime
)
  returns ECalComponentRange
  is      native(ecal)
  is      export
{ * }

sub e_cal_component_range_set_datetime (
  ECalComponentRange    $range,
  ECalComponentDateTime $datetime
)
  is      native(ecal)
  is      export
{ * }

sub e_cal_component_range_set_kind (
  ECalComponentRange     $range,
  ECalComponentRangeKind $kind
)
  is      native(ecal)
  is      export
{ * }

sub e_cal_component_range_take_datetime (
  ECalComponentRange    $range,
  ECalComponentDateTime $datetime
)
  is      native(ecal)
  is      export
{ * }
