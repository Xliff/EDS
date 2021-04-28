use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Component;

### /usr/include/evolution-data-server/libecal/e-cal-component-text.h

sub e_cal_component_text_copy (ECalComponentText $text)
  returns ECalComponentText
  is native(ecal)
  is export
{ * }

sub e_cal_component_text_free (ECalComponentText $text)
  is native(ecal)
  is export
{ * }

sub e_cal_component_text_get_altrep (ECalComponentText $text)
  returns Str
  is native(ecal)
  is export
{ * }

sub e_cal_component_text_get_type ()
  returns GType
  is native(ecal)
  is export
{ * }

sub e_cal_component_text_get_value (ECalComponentText $text)
  returns Str
  is native(ecal)
  is export
{ * }

sub e_cal_component_text_new (Str $value, Str $altrep)
  returns ECalComponentText
  is native(ecal)
  is export
{ * }

sub e_cal_component_text_set_altrep (ECalComponentText $text, Str $altrep)
  is native(ecal)
  is export
{ * }

sub e_cal_component_text_set_value (ECalComponentText $text, Str $value)
  is native(ecal)
  is export
{ * }
