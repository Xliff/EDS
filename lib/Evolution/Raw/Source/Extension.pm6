use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Extension;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-extension.h

sub e_source_extension_get_source (ESourceExtension $extension)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_extension_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_extension_property_lock (ESourceExtension $extension)
  is native(eds)
  is export
{ * }

sub e_source_extension_property_unlock (ESourceExtension $extension)
  is native(eds)
  is export
{ * }

sub e_source_extension_ref_source (ESourceExtension $extension)
  returns ESource
  is native(eds)
  is export
{ * }
