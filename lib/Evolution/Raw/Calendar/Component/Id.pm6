use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Calendar::Component::Id;

### /usr/src/evolution-data-server-3.48.0/src/calendar/libecal/e-cal-component-id.h

sub e_cal_component_id_copy (ECalComponentId $id)
  returns ECalComponentId
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_equal (ECalComponentId $id1, ECalComponentId $id2)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_free (ECalComponentId $id)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_get_rid (ECalComponentId $id)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_get_uid (ECalComponentId $id)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_hash (ECalComponentId $id)
  returns guint
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_new (Str $uid, Str $rid)
  returns ECalComponentId
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_new_take (Str $uid, Str $rid)
  returns ECalComponentId
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_set_rid (ECalComponentId $id, Str $rid)
  is      native(eds)
  is      export
{ * }

sub e_cal_component_id_set_uid (ECalComponentId $id, Str $uid)
  is      native(eds)
  is      export
{ * }
