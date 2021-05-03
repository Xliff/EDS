use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::SubprocessFactory;

### /usr/include/evolution-data-server/libebackend/e-subprocess-factory.h

sub e_subprocess_factory_call_backends_prepare_shutdown (
  ESubprocessFactory $subprocess_factory
)
  is native(ebackend)
  is export
{ * }

sub e_subprocess_factory_construct_path ()
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_subprocess_factory_get_backends_list (
  ESubprocessFactory $subprocess_factory
)
  returns GList
  is native(ebackend)
  is export
{ * }

sub e_subprocess_factory_get_registry (ESubprocessFactory $subprocess_factory)
  returns ESourceRegistry
  is native(ebackend)
  is export
{ * }

sub e_subprocess_factory_get_type ()
  returns GType
  is native(ebackend)
  is export
{ * }

sub e_subprocess_factory_open_backend (
  ESubprocessFactory      $subprocess_factory,
  GDBusConnection         $connection,
  Str                     $uid,
  Str                     $backend_factory_type_name,
  Str                     $module_filename,
  GDBusInterfaceSkeleton  $proxy,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_subprocess_factory_ref_initable_backend (
  ESubprocessFactory      $subprocess_factory,
  Str                     $uid,
  Str                     $backend_factory_type_name,
  Str                     $module_filename,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns EBackend
  is native(ebackend)
  is export
{ * }

sub e_subprocess_factory_set_backend_callbacks (
  ESubprocessFactory     $subprocess_factory,
  EBackend               $backend,
  GDBusInterfaceSkeleton $proxy
)
  is native(ebackend)
  is export
{ * }
