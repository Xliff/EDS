use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::CollectionBackend;

### /usr/include/evolution-data-server/libebackend/e-collection-backend.h

sub e_collection_backend_authenticate_children (
  ECollectionBackend $backend,
  ENamedParameters   $credentials
)
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_claim_all_resources (ECollectionBackend $backend)
  returns GList
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_create_resource (
  ECollectionBackend $backend,
  ESource            $source,
  GCancellable       $cancellable,
                     &callback (ECollectionBackend, GAsyncResult, gpointer),
  gpointer           $user_data
)
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_create_resource_finish (
  ECollectionBackend      $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_create_resource_sync (
  ECollectionBackend      $backend,
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_delete_resource (
  ECollectionBackend $backend,
  ESource            $source,
  GCancellable       $cancellable,
                     &callback (ECollectionBackend, GAsyncResult, gpointer),
  gpointer           $user_data
)
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_delete_resource_finish (
  ECollectionBackend      $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_delete_resource_sync (
  ECollectionBackend      $backend,
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_dup_resource_id (
  ECollectionBackend $backend,
  ESource            $child_source
)
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_freeze_populate (ECollectionBackend $backend)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_get_cache_dir (ECollectionBackend $backend)
  returns Str
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_get_populate_frozen (ECollectionBackend $backend)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_get_type ()
  returns GType
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_is_new_source (
  ECollectionBackend $backend,
  ESource            $source
)
  returns uint32
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_list_calendar_sources (ECollectionBackend $backend)
  returns GList
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_list_contacts_sources (ECollectionBackend $backend)
  returns GList
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_list_mail_sources (ECollectionBackend $backend)
  returns GList
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_new_child (
  ECollectionBackend $backend,
  Str                $resource_id
)
  returns ESource
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_ref_proxy_resolver (ECollectionBackend $backend)
  returns GProxyResolver
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_ref_server (ECollectionBackend $backend)
  returns ESourceRegistryServer
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_schedule_populate (ECollectionBackend $backend)
  is native(ebackend)
  is export
{ * }

sub e_collection_backend_thaw_populate (ECollectionBackend $backend)
  is native(ebackend)
  is export
{ * }
