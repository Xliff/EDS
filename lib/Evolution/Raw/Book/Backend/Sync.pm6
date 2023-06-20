use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Book::Backend::Sync;

### /usr/src/evolution-data-server-3.48.0/src/addressbook/libedata-book/e-book-backend-sync.h

sub e_book_backend_sync_contains_email (
  EBookBackendSync        $backend,
  Str                     $email_address,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_backend_sync_create_contacts (
  EBookBackendSync        $backend,
  CArray[Str]             $vcards,
  guint32                 $opflags,
  CArray[GSList]          $out_contacts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_backend_sync_get_contact (
  EBookBackendSync        $backend,
  Str                     $uid,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns EContact
  is      native(eds)
  is      export
{ * }

sub e_book_backend_sync_get_contact_list (
  EBookBackendSync        $backend,
  Str                     $query,
  CArray[GSList]          $out_contacts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_backend_sync_get_contact_list_uids (
  EBookBackendSync        $backend,
  Str                     $query,
  CArray[GSList]          $out_uids,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_backend_sync_modify_contacts (
  EBookBackendSync        $backend,
  CArray[Str]             $vcards,
  guint32                 $opflags,
  CArray[GSList]          $out_contacts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_backend_sync_open (
  EBookBackendSync        $backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_backend_sync_refresh (
  EBookBackendSync        $backend,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_backend_sync_remove_contacts (
  EBookBackendSync        $backend,
  CArray[Str]             $uids,
  guint32                 $opflags,
  CArray[GSList]          $out_removed_uids,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }
