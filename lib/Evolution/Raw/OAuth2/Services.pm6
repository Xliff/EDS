use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::OAuth2::Services;

### /usr/include/evolution-data-server/libeds/e-oauth2-services.h

sub e_oauth2_services_add (EOAuth2Services $services, EOAuth2Service $service)
  is native(eds)
  is export
{ * }

sub e_oauth2_services_find (EOAuth2Services $services, ESource $source)
  returns EOAuth2Service
  is native(eds)
  is export
{ * }

sub e_oauth2_services_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_oauth2_services_guess (
  EOAuth2Services $services,
  Str             $protocol,
  Str             $hostname
)
  returns EOAuth2Service
  is native(eds)
  is export
{ * }

sub e_oauth2_services_is_oauth2_alias (
  EOAuth2Services $services,
  Str             $auth_method
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_services_is_oauth2_alias_static (Str $auth_method)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_services_is_supported ()
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_services_list (EOAuth2Services $services)
  returns GSList
  is native(eds)
  is export
{ * }

sub e_oauth2_services_new ()
  returns EOAuth2Services
  is native(eds)
  is export
{ * }

sub e_oauth2_services_remove (
  EOAuth2Services $services,
  EOAuth2Service  $service
)
  is native(eds)
  is export
{ * }
