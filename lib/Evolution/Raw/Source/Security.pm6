use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Security;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-security.h

sub e_source_security_dup_method (ESourceSecurity $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_security_get_method (ESourceSecurity $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_security_get_secure (ESourceSecurity $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_security_get_type ()
  returns GType
  is native(eds)\
  is export
{ * }

sub e_source_security_set_method (ESourceSecurity $extension, Str $method)
  is native(eds)
  is export
{ * }

sub e_source_security_set_secure (ESourceSecurity $extension, gboolean $secure)
  is native(eds)
  is export
{ * }
