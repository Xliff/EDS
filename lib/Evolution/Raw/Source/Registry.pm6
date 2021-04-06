use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;

use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Registry;

### /usr/include/evolution-data-server/libedataserver/e-source-registry.h

sub e_source_registry_build_display_tree (
  ESourceRegistry $registry,
  Str             $extension_name
)
  returns GNode
  is native(eds)
  is export
{ * }

sub e_source_registry_check_enabled (ESourceRegistry $registry, ESource $source)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_registry_commit_source (
  ESourceRegistry $registry,
  ESource         $source,
  GCancellable    $cancellable,
                  &callback (ESourceRegistry, GAsyncResult, gpointer),
  gpointer        $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_registry_commit_source_finish (
  ESourceRegistry         $registry,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_registry_commit_source_sync (
  ESourceRegistry         $registry,
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_registry_create_sources (
  ESourceRegistry $registry,
  GList           $list_of_sources,
  GCancellable    $cancellable,
                  &callback (ESourceRegistry, GAsyncResult, gpointer),
  gpointer        $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_registry_create_sources_finish (
  ESourceRegistry         $registry,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_registry_create_sources_sync (
  ESourceRegistry         $registry,
  GList                   $list_of_sources,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_registry_debug_dump (
  ESourceRegistry $registry,
  Str             $extension_name
)
  is native(eds)
  is export
{ * }

sub e_source_registry_dup_unique_display_name (
  ESourceRegistry $registry,
  ESource         $source,
  Str             $extension_name
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_registry_find_extension (
  ESourceRegistry $registry,
  ESource         $source,
  Str             $extension_name
)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_free_display_tree (GNode $display_tree)
  is native(eds)
  is export
{ * }

sub e_source_registry_get_oauth2_services (ESourceRegistry $registry)
  returns EOAuth2Services
  is native(eds)
  is export
{ * }

sub e_source_registry_list_enabled (
  ESourceRegistry $registry,
  Str             $extension_name
)
  returns GList
  is native(eds)
  is export
{ * }

sub e_source_registry_list_sources (
  ESourceRegistry $registry,
  Str             $extension_name
)
  returns GList
  is native(eds)
  is export
{ * }

sub e_source_registry_new (
  GCancellable $cancellable,
               &callback (ESourceRegistry, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_registry_new_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns ESourceRegistry
  is native(eds)
  is export
{ * }

sub e_source_registry_new_sync (
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns ESourceRegistry
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_builtin_address_book (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_builtin_calendar (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_builtin_mail_account (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_builtin_memo_list (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_builtin_proxy (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_builtin_task_list (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_default_address_book (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_default_calendar (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_default_for_extension_name (
  ESourceRegistry $registry,
  Str             $extension_name
)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_default_mail_account (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_default_mail_identity (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_default_memo_list (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_default_task_list (ESourceRegistry $registry)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_ref_source (ESourceRegistry $registry, Str $uid)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_source_registry_refresh_backend (
  ESourceRegistry     $registry,
  Str                 $source_uid,
  GCancellable        $cancellable,
  &callback (ESourceRegistry, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_registry_refresh_backend_finish (
  ESourceRegistry         $registry,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_registry_refresh_backend_sync (
  ESourceRegistry         $registry,
  Str                     $source_uid,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_registry_set_default_address_book (
  ESourceRegistry $registry,
  ESource         $default_source
)
  is native(eds)
  is export
{ * }

sub e_source_registry_set_default_calendar (
  ESourceRegistry $registry,
  ESource         $default_source
)
  is native(eds)
  is export
{ * }

sub e_source_registry_set_default_for_extension_name (
  ESourceRegistry $registry,
  Str             $extension_name,
  ESource         $default_source
)
  is native(eds)
  is export
{ * }

sub e_source_registry_set_default_mail_account (
  ESourceRegistry $registry,
  ESource         $default_source
)
  is native(eds)
  is export
{ * }

sub e_source_registry_set_default_mail_identity (
  ESourceRegistry $registry,
  ESource         $default_source
)
  is native(eds)
  is export
{ * }

sub e_source_registry_set_default_memo_list (
  ESourceRegistry $registry,
  ESource         $default_source
)
  is native(eds)
  is export
{ * }

sub e_source_registry_set_default_task_list (
  ESourceRegistry $registry,
  ESource         $default_source
)
  is native(eds)
  is export
{ * }
