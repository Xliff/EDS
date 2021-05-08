use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Source::RegistryServer;

### /usr/include/evolution-data-server/libebackend/e-source-registry-server.h

sub e_source_registry_server_add_source (
  ESourceRegistryServer $server,
  ESource               $source
)
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_find_extension (
  ESourceRegistryServer $server,
  ESource               $source,
  Str                   $extension_name
)
  returns ESource
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_get_oauth2_services (
  ESourceRegistryServer $server
)
  returns EOAuth2Services
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_get_type ()
  returns GType
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_list_sources (
  ESourceRegistryServer $server,
  Str                   $extension_name
)
  returns GList
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_load_all (
  ESourceRegistryServer   $server,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_load_directory (
  ESourceRegistryServer   $server,
  Str                     $path,
  ESourcePermissionFlags  $flags,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_load_error (
  ESourceRegistryServer   $server,
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_load_file (
  ESourceRegistryServer   $server,
  GFile                   $file,
  ESourcePermissionFlags  $flags,
  CArray[Pointer[GError]] $error
)
  returns ESource
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_load_resource (
  ESourceRegistryServer   $server,
  GResource               $resource,
  Str                     $path,
  ESourcePermissionFlags  $flags,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_new ()
  returns ESourceRegistryServer
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_ref_backend (
  ESourceRegistryServer $server,
  ESource               $source
)
  returns ECollectionBackend
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_ref_backend_factory (
  ESourceRegistryServer $server,
  ESource               $source
)
  returns ECollectionBackendFactory
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_ref_credentials_provider (
  ESourceRegistryServer $server
)
  returns ESourceCredentialsProvider
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_ref_source (
  ESourceRegistryServer $server,
  Str                   $uid
)
  returns ESource
  is native(ebackend)
  is export
{ * }

sub e_source_registry_server_remove_source (
  ESourceRegistryServer $server,
  ESource               $source
)
  is native(ebackend)
  is export
{ * }
