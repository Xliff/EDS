use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Alarms;

### /usr/include/evolution-data-server/libedataserver/e-source-alarms.h

sub e_source_alarms_dup_last_notified (ESourceAlarms $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_alarms_get_include_me (ESourceAlarms $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_alarms_get_last_notified (ESourceAlarms $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_alarms_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_alarms_set_include_me (
  ESourceAlarms $extension,
  gboolean      $include_me
)
  is native(eds)
  is export
{ * }

sub e_source_alarms_set_last_notified (
  ESourceAlarms $extension,
  Str           $last_notified
)
  is native(eds)
  is export
{ * }
