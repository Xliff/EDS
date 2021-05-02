use v6.c

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Backend::Factory;

### /usr/include/evolution-data-server/libebackend/e-backend-factory.h

sub e_backend_factory_get_hash_key (EBackendFactory $factory)
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_backend_factory_get_module_filename (EBackendFactory $factory)
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_backend_factory_get_type ()
  returns GType
  is native(ebackend)
  is export
{ * }

sub e_backend_factory_new_backend (EBackendFactory $factory, ESource $source)
  returns EBackend
  is native(ebackend)
  is export
{ * }

sub e_backend_factory_share_subprocess (EBackendFactory $factory)
  returns uint32
  is native(ebackend)
  is export
{ * }
