use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use ICal::GLib::Raw::Enums;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Calendar::Component::ParameterBag;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-parameter-bag.h

sub e_cal_component_parameter_bag_add (
  ECalComponentParameterBag $bag,
  ICalParameter             $param
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_assign (
  ECalComponentParameterBag $bag,
  ECalComponentParameterBag $src_bag
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_clear (ECalComponentParameterBag $bag)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_copy (ECalComponentParameterBag $bag)
  returns ECalComponentParameterBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_fill_property (
  ECalComponentParameterBag $bag,
  ICalProperty              $property
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_free (ECalComponentParameterBag $bag)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_get (
  ECalComponentParameterBag $bag,
  guint                     $index
)
  returns ICalParameter
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_get_count (ECalComponentParameterBag $bag)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_get_first_by_kind (
  ECalComponentParameterBag $bag,
  ICalParameterKind         $kind
)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_new
  returns ECalComponentParameterBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_new_from_property (
  ICalProperty $property,
               &func (ICalParameter, gpointer --> gboolean),
  gpointer     $user_data
)
  returns ECalComponentParameterBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_remove (
  ECalComponentParameterBag $bag,
  guint                     $index
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_remove_by_kind (
  ECalComponentParameterBag $bag,
  ICalParameterKind         $kind,
  gboolean                  $all
)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_set_from_property (
  ECalComponentParameterBag $bag,
  ICalProperty              $property,
                            &func (ICalParameter, gpointer --> gboolean),
  gpointer                  $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_parameter_bag_take (
  ECalComponentParameterBag $bag,
  ICalParameter             $param
)
  is      native(eds)
  is      export
{ * }
