use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use ICal::GLib::Raw::Enums;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Component::Attendee;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-attendee.h

sub e_cal_component_attendee_copy (ECalComponentAttendee $attendee)
  returns ECalComponentAttendee
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_fill_property (
  ECalComponentAttendee $attendee,
  ICalProperty          $property
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_free (ECalComponentAttendee $attendee)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_as_property (ECalComponentAttendee $attendee)
  returns ICalProperty
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_cn (ECalComponentAttendee $attendee)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_cutype (ECalComponentAttendee $attendee)
  returns ICalParameterCutype
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_delegatedfrom (ECalComponentAttendee $attendee)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_delegatedto (ECalComponentAttendee $attendee)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_language (ECalComponentAttendee $attendee)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_member (ECalComponentAttendee $attendee)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_parameter_bag (ECalComponentAttendee $attendee)
  returns ECalComponentParameterBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_partstat (ECalComponentAttendee $attendee)
  returns ICalParameterPartstat
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_role (ECalComponentAttendee $attendee)
  returns ICalParameterRole
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_rsvp (ECalComponentAttendee $attendee)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_sentby (ECalComponentAttendee $attendee)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_get_value (ECalComponentAttendee $attendee)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_new
  returns ECalComponentAttendee
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_new_from_property (ICalProperty $property)
  returns ECalComponentAttendee
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_new_full (
  Str                   $value,
  Str                   $member,
  ICalParameterCutype   $cutype,
  ICalParameterRole     $role,
  ICalParameterPartstat $partstat,
  gboolean              $rsvp,
  Str                   $delegatedfrom,
  Str                   $delegatedto,
  Str                   $sentby,
  Str                   $cn,
  Str                   $language
)
  returns ECalComponentAttendee
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_cn (
  ECalComponentAttendee $attendee,
  Str                   $cn
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_cutype (
  ECalComponentAttendee $attendee,
  ICalParameterCutype   $cutype
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_delegatedfrom (
  ECalComponentAttendee $attendee,
  Str                   $delegatedfrom
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_delegatedto (
  ECalComponentAttendee $attendee,
  Str                   $delegatedto
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_from_property (
  ECalComponentAttendee $attendee,
  ICalProperty          $property
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_language (
  ECalComponentAttendee $attendee,
  Str                   $language
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_member (
  ECalComponentAttendee $attendee,
  Str                   $member
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_partstat (
  ECalComponentAttendee $attendee,
  ICalParameterPartstat $partstat
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_role (
  ECalComponentAttendee $attendee,
  ICalParameterRole     $role
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_rsvp (
  ECalComponentAttendee $attendee,
  gboolean              $rsvp
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_sentby (
  ECalComponentAttendee $attendee,
  Str                   $sentby
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_attendee_set_value (
  ECalComponentAttendee $attendee,
  Str                   $value
)
  is      native(eds)
  is      export
{ * }
