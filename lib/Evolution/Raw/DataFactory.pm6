use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::DataFactory;

### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-data-factory.h

sub e_data_factory_backend_closed (EDataFactory $data_factory, EBackend $backend)
  is native(ebackend)
  is export
{ * }

sub e_data_factory_backend_closed_by_sender (
  EDataFactory $data_factory,
  EBackend     $backend,
  Str          $sender
)
  is native(ebackend)
  is export
{ * }

sub e_data_factory_construct_path (EDataFactory $data_factory)
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_data_factory_create_backend (
  EDataFactory    $data_factory,
  EBackendFactory $backend_factory,
  ESource         $source
)
  returns EBackend
  is native(ebackend)
  is export
{ * }

sub e_data_factory_get_backend_per_process (EDataFactory $data_factory)
  returns gint
  is native(ebackend)
  is export
{ * }

sub e_data_factory_get_registry (EDataFactory $data_factory)
  returns ESourceRegistry
  is native(ebackend)
  is export
{ * }

sub e_data_factory_get_reload_supported (EDataFactory $data_factory)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_data_factory_get_type ()
  returns GType
  is native(ebackend)
  is export
{ * }

sub e_data_factory_list_opened_backends (EDataFactory $data_factory)
  returns GSList
  is native(ebackend)
  is export
{ * }

sub e_data_factory_open_backend (
  EDataFactory            $data_factory,
  EBackend                $backend ,
  GDBusConnection         $connection,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_data_factory_ref_backend_factory (
  EDataFactory $data_factory,
  Str          $backend_name,
  Str          $extension_name
)
  returns EBackendFactory
  is native(ebackend)
  is export
{ * }

sub e_data_factory_spawn_subprocess_backend (
  EDataFactory          $data_factory,
  GDBusMethodInvocation $invocation,
  Str                   $uid,
  Str                   $extension_name,
  Str                   $subprocess_path
)
  is native(ebackend)
  is export
{ * }

sub e_data_factory_use_backend_per_process (EDataFactory $data_factory)
  returns uint32
  is native(ebackend)
  is export
{ * }
