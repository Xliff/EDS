use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Source::ServerSide;


### /usr/include/evolution-data-server/libebackend/e-server-side-source.h

sub e_server_side_source_get_exported (EServerSideSource $source)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_get_file (EServerSideSource $source)
  returns GFile
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_get_node (EServerSideSource $source)
  returns GNode
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_get_server (EServerSideSource $source)
  returns ESourceRegistryServer
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_get_type ()
  returns GType
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_get_user_dir ()
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_get_write_directory (EServerSideSource $source)
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_load (
  EServerSideSource       $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_new (
  ESourceRegistryServer   $server,
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns ESource
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_new_memory_only (
  ESourceRegistryServer   $server, 
  Str                     $uid,
  CArray[Pointer[GError]] $error
)
  returns ESource
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_new_user_file (Str $uid)
  returns GFile
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_ref_oauth2_support (EServerSideSource $source)
  returns EOAuth2Support
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_set_oauth2_support (
  EServerSideSource $source,
  EOAuth2Support    $oauth2_support
)
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_set_remote_creatable (
  EServerSideSource $source,
  gboolean          $remote_creatable
)
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_set_remote_deletable (
  EServerSideSource $source,
  gboolean          $remote_deletable
)
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_set_removable (
  EServerSideSource $source,
  gboolean          $removable
)
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_set_writable (
  EServerSideSource $source,
  gboolean          $writable
)
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_set_write_directory (
  EServerSideSource $source,
  Str               $write_directory
)
  is native(ebackend)
  is export
{ * }

sub e_server_side_source_uid_from_file (
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(ebackend)
  is export
{ * }
