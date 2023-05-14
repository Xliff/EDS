use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Camel;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-camel.h

sub e_source_camel_configure_service (ESource $source, CamelService $service)
  is native(eds)
  is export
{ * }

sub e_source_camel_generate_subtype (Str $protocol, GType $settings_type)
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_camel_get_extension_name (Str $protocol)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_camel_get_settings (ESourceCamel $extension)
  returns CamelSettings
  is native(eds)
  is export
{ * }

sub e_source_camel_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_camel_get_type_name (Str $protocol)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_camel_register_types ()
  is native(eds)
  is export
{ * }
