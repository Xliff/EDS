use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Book::Backend;

### /usr/src/evolution-data-server-3.48.0/src/libedata-book/e-book-backend.h

sub e_book_backend_add_view (EBookBackend $backend, EDataBookView $view)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_configure_direct (EBookBackend $backend, Str $config)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_create_contacts (
  EBookBackend $backend,
  CArray[Str]  $vcards,
  guint32      $opflags,
  GCancellable $cancellable,
               &callback (EBookBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_create_contacts_finish (
  EBookBackend            $backend,
  GAsyncResult            $result,
  GQueue                  $out_contacts,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_create_contacts_sync (
  EBookBackend            $backend,
  CArray[Str]             $vcards,
  guint32                 $opflags,
  GQueue                  $out_contacts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_create_cursor (
  EBookBackend            $backend,
  Pointer                 $sort_fields, #= Array of EContactField]
  EBookCursorSortType     $sort_types,
  guint                   $n_fields,
  CArray[Pointer[GError]] $error
)
  returns EDataBookCursor
  is native(edata-book)
  is export
{ * }

sub e_book_backend_delete_cursor (
  EBookBackend            $backend,
  EDataBookCursor         $cursor,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_dup_cache_dir (EBookBackend $backend)
  returns Str
  is native(edata-book)
  is export
{ * }

sub e_book_backend_dup_locale (EBookBackend $backend)
  returns Str
  is native(edata-book)
  is export
{ * }

sub e_book_backend_foreach_view (
  EBookBackend $backend,
               &func (EBookBackend, EDataBookView, gpointer --> gboolean),
  gpointer     $user_data
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_foreach_view_notify_progress (
  EBookBackend $backend,
  gboolean     $only_completed_views,
  gint         $percent,
  Str          $message
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_backend_property (EBookBackend $backend, Str $prop_name)
  returns Str
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_cache_dir (EBookBackend $backend)
  returns Str
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_contact (
  EBookBackend $backend,
  Str          $uid,
  GCancellable $cancellable,
               &callback (EBookBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_contact_finish (
  EBookBackend            $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns EContact
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_contact_list (
  EBookBackend $backend,
  Str          $query,
  GCancellable $cancellable,
               &callback (EBookBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_contact_list_finish (
  EBookBackend            $backend,
  GAsyncResult            $result,
  GQueue                  $out_contacts,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_contact_list_sync (
  EBookBackend            $backend,
  Str                     $query,
  GQueue                  $out_contacts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_contact_list_uids (
  EBookBackend $backend,
  Str          $query,
  GCancellable $cancellable,
               &callback (EBookBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_contact_list_uids_finish (
  EBookBackend            $backend,
  GAsyncResult            $result,
  GQueue                  $out_uids,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_contact_list_uids_sync (
  EBookBackend            $backend,
  Str                     $query,
  GQueue                  $out_uids,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_contact_sync (
  EBookBackend            $backend,
  Str                     $uid,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns EContact
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_direct_book (EBookBackend $backend)
  returns EDataBookDirect
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_registry (EBookBackend $backend)
  returns ESourceRegistry
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_type ()
  returns GType
  is native(edata-book)
  is export
{ * }

sub e_book_backend_get_writable (EBookBackend $backend)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_is_opened (EBookBackend $backend)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_is_readonly (EBookBackend $backend)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_list_views (EBookBackend $backend)
  returns GList
  is native(edata-book)
  is export
{ * }

sub e_book_backend_modify_contacts (
  EBookBackend $backend,
  CArray[Str]  $vcards,
  guint32      $opflags,
  GCancellable $cancellable,
               &callback (EBookBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_modify_contacts_finish (
  EBookBackend            $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_modify_contacts_sync (
  EBookBackend            $backend,
  CArray[Str]             $vcards,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_notify_complete (EBookBackend $backend)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_notify_error (EBookBackend $backend, Str $message)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_notify_property_changed (
  EBookBackend $backend,
  Str          $prop_name,
  Str          $prop_value
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_notify_remove (EBookBackend $backend, Str $id)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_notify_update (
  EBookBackend $backend,
  EContact     $contact
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_open (
  EBookBackend $backend,
  GCancellable $cancellable,
               &callback (EBookBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_open_finish (
  EBookBackend            $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_open_sync (
  EBookBackend            $backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_prepare_for_completion (
  EBookBackend   $backend,
  guint32        $opid,
  CArray[GQueue] $result_queue
)
  returns GSimpleAsyncResult
  is native(edata-book)
  is export
{ * }

sub e_book_backend_ref_data_book (EBookBackend $backend)
  returns EDataBook
  is native(edata-book)
  is export
{ * }

sub e_book_backend_ref_proxy_resolver (EBookBackend $backend)
  returns GProxyResolver
  is native(edata-book)
  is export
{ * }

sub e_book_backend_refresh (
  EBookBackend $backend,
  GCancellable $cancellable,
               &callback (EBookBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_refresh_finish (
  EBookBackend            $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_refresh_sync (
  EBookBackend            $backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_remove_contacts (
  EBookBackend $backend,
  CArray[Str]  $uids,
  guint32      $opflags,
  GCancellable $cancellable,
               &callback (EBookBackend, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_remove_contacts_finish (
  EBookBackend            $backend,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_remove_contacts_sync (
  EBookBackend            $backend,
  CArray[Str]             $uids,
  guint32                 $opflags,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_remove_view (EBookBackend $backend, EDataBookView $view)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_schedule_custom_operation (
  EBookBackend   $book_backend,
  GCancellable   $use_cancellable,
                 &func (
                  EBookBackend,
                  gpointer,
                  GCancellable,
                  CArray[Pointer[GError]]
                 ),
  gpointer       $user_data,
  GDestroyNotify $user_data_free
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_set_cache_dir (EBookBackend $backend, Str $cache_dir)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_set_data_book (
  EBookBackend $backend,
  EDataBook    $data_book
)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_set_locale (
  EBookBackend            $backend,
  Str                     $locale,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_set_writable (EBookBackend $backend, gboolean $writable)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_start_view (EBookBackend $backend, EDataBookView $view)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_stop_view (EBookBackend $backend, EDataBookView $view)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_sync (EBookBackend $backend)
  is native(edata-book)
  is export
{ * }
