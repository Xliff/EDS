use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

### /usr/include/evolution-data-server/libedataserver/e-source-authentication.h

sub e_source_authentication_dup_credential_name (
  ESourceAuthentication $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_dup_host (ESourceAuthentication $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_dup_method (ESourceAuthentication $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_dup_proxy_uid (ESourceAuthentication $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_dup_user (ESourceAuthentication $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_get_credential_name (
  ESourceAuthentication $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_get_host (ESourceAuthentication $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_get_is_external (
  ESourceAuthentication $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_authentication_get_method (ESourceAuthentication $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_get_port (ESourceAuthentication $extension)
  returns guint16
  is native(eds)
  is export
{ * }

sub e_source_authentication_get_proxy_uid (ESourceAuthentication $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_get_remember_password (
  ESourceAuthentication $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_authentication_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_authentication_get_user (ESourceAuthentication $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_authentication_ref_connectable (ESourceAuthentication $extension)
  returns GSocketConnectable
  is native(eds)
  is export
{ * }

sub e_source_authentication_required (ESourceAuthentication $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_authentication_set_credential_name (
  ESourceAuthentication $extension,
  Str                   $credential_name
)
  is native(eds)
  is export
{ * }

sub e_source_authentication_set_host (
  ESourceAuthentication $extension,
  Str                   $host
)
  is native(eds)
  is export
{ * }

sub e_source_authentication_set_is_external (
  ESourceAuthentication $extension,
  gboolean              $is_external
)
  is native(eds)
  is export
{ * }

sub e_source_authentication_set_method (
  ESourceAuthentication $extension,
  Str                   $method
)
  is native(eds)
  is export
{ * }

sub e_source_authentication_set_port (
  ESourceAuthentication $extension,
  guint16               $port
)
  is native(eds)
  is export
{ * }

sub e_source_authentication_set_proxy_uid (
  ESourceAuthentication $extension,
  Str                   $proxy_uid
)
  is native(eds)
  is export
{ * }

sub e_source_authentication_set_remember_password (
  ESourceAuthentication $extension,
  gboolean              $remember_password
)
  is native(eds)
  is export
{ * }

sub e_source_authentication_set_user (
  ESourceAuthentication $extension,
  Str                   $user
)
  is native(eds)
  is export
{ * }
