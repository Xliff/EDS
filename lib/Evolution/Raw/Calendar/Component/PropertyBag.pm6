use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use ICal::GLib::Raw::Definitions;
use ICal::GLib::Raw::Enums;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Calendar::Component::PropertyBag;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-property-bag.h

sub e_cal_component_property_bag_add (
  ECalComponentPropertyBag $bag,
  ICalProperty             $prop
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_assign (
  ECalComponentPropertyBag $bag,
  ECalComponentPropertyBag $src_bag
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_clear (ECalComponentPropertyBag $bag)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_copy (ECalComponentPropertyBag $bag)
  returns ECalComponentPropertyBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_fill_component (
  ECalComponentPropertyBag $bag,
  ICalComponent            $component
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_free (ECalComponentPropertyBag $bag)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_get (
  ECalComponentPropertyBag $bag,
  guint                    $index
)
  returns ICalProperty
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_get_count (ECalComponentPropertyBag $bag)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_get_first_by_kind (
  ECalComponentPropertyBag $bag,
  ICalPropertyKind         $kind
)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_new
  returns ECalComponentPropertyBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_new_from_component (
  ICalComponent $component,
                &func (
                  ICalProperty,
                  gpointer
                  --> gboolean
                ),
  gpointer      $user_data
)
  returns ECalComponentPropertyBag
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_remove (
  ECalComponentPropertyBag $bag,
  guint                    $index
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_remove_by_kind (
  ECalComponentPropertyBag $bag,
  ICalPropertyKind         $kind,
  gboolean                 $all
)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_set_from_component (
  ECalComponentPropertyBag           $bag,
  ICalComponent                      $component,
                                     &func (
                                       ICalProperty,
                                       gpointer
                                       --> gboolean
                                     ),
  gpointer                           $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_property_bag_take (
  ECalComponentPropertyBag $bag,
  ICalProperty             $prop
)
  is      native(eds)
  is      export
{ * }
