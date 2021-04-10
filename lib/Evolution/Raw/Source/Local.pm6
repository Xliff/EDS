use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Local;

### /usr/include/evolution-data-server/libedataserver/e-source-local.h

sub e_source_local_dup_custom_file (ESourceLocal $extension)
  returns GFile
  is native(eds)
  is export
{ * }

sub e_source_local_get_custom_file (ESourceLocal $extension)
  returns GFile
  is native(eds)
  is export
{ * }

sub e_source_local_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_local_get_writable (ESourceLocal $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_local_set_custom_file (ESourceLocal $extension, GFile $custom_file)
  is native(eds)
  is export
{ * }

sub e_source_local_set_writable (ESourceLocal $extension, gboolean $writable)
  is native(eds)
  is export
{ * }
