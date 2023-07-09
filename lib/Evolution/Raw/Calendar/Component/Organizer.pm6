use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use ICal::GLib::Raw::Definitions;
use Evolution::Raw::Definitions;

unit package Evolution::Raw::Calendar::Component::Organizer;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-organizer.h

sub e_cal_component_organizer_copy (ECalComponentOrganizer $organizer)
  returns ECalComponentOrganizer
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_fill_property (
  ECalComponentOrganizer $organizer,
  ICalProperty           $property
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_free (ECalComponentOrganizer $organizer)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_get_as_property (
  ECalComponentOrganizer $organizer
)
  returns ICalProperty
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_get_cn (ECalComponentOrganizer $organizer)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_get_language (
  ECalComponentOrganizer $organizer
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_get_parameter_bag (
  ECalComponentOrganizer $organizer
)
  returns ECalComponentParameterBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_get_sentby (ECalComponentOrganizer $organizer)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_get_value (ECalComponentOrganizer $organizer)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_new
  returns ECalComponentOrganizer
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_new_from_property (ICalProperty $property)
  returns ECalComponentOrganizer
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_new_full (
  Str $value,
  Str $sentby,
  Str $cn,
  Str $language
)
  returns ECalComponentOrganizer
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_set_cn (
  ECalComponentOrganizer $organizer,
  Str                    $cn
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_set_from_property (
  ECalComponentOrganizer $organizer,
  ICalProperty           $property
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_set_language (
  ECalComponentOrganizer $organizer,
  Str                    $language
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_set_sentby (
  ECalComponentOrganizer $organizer,
  Str                    $sentby
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_organizer_set_value (
  ECalComponentOrganizer $organizer,
  Str                    $value
)
  is      native(eds)
  is      export
{ * }
