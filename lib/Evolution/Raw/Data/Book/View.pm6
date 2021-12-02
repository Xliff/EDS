use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Data::Book::View;

### /usr/include/evolution-data-server/libedata-book/e-data-book-view.h

sub e_data_book_view_get_backend (EDataBookView $view)
  returns EBookBackend
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_get_connection (EDataBookView $view)
  returns GDBusConnection
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_get_fields_of_interest (EDataBookView $view)
  returns GHashTable
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_get_flags (EDataBookView $view)
  returns EBookClientViewFlags
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_get_object_path (EDataBookView $view)
  returns Str
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_get_sexp (EDataBookView $view)
  returns EBookBackendSExp
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_get_type ()
  returns GType
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_is_completed (EDataBookView $view)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_new (
  EBookBackend            $backend,
  EBookBackendSExp        $sexp,
  GDBusConnection         $connection,
  Str                     $object_path,
  CArray[Pointer[GError]] $error
)
  returns EDataBookView
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_notify_complete (
  EDataBookView $view,
  GError        $error
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_notify_progress (
  EDataBookView $view,
  guint         $percent,
  Str           $message
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_notify_remove (EDataBookView $view, Str $id)
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_notify_update (EDataBookView $view, EContact $contact)
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_notify_update_prefiltered_vcard (
  EDataBookView $view,
  Str           $id,
  Str           $vcard
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_notify_update_vcard (
  EDataBookView $view,
  Str           $id,
  Str           $vcard
  )
  is native(edata-book)
  is export
{ * }

sub e_data_book_view_ref_backend (EDataBookView $view)
  returns EBookBackend
  is native(edata-book)
  is export
{ * }
