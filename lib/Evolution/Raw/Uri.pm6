use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::URI;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-url.h

sub e_uri_copy (EUri $uri)
  returns EUri
  is      native(eds)
  is      export
{ * }

sub e_uri_free (EUri $uri)
  is      native(eds)
  is      export
{ * }

sub e_uri_get_param (
  EUri $uri,
  Str  $name
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_uri_new (Str $uri_string)
  returns EUri
  is      native(eds)
  is      export
{ * }

sub e_uri_to_string (
  EUri     $uri,
  gboolean $show_password
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_url_equal (Str $url1, Str $url2)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_url_shroud (Str $url)
  returns Str
  is      native(eds)
  is      export
{ * }
