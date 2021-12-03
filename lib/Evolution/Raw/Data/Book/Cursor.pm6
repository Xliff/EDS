use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Data::Book::Cursor;

### /usr/include/evolution-data-server/libedata-book/e-data-book-cursor.h

sub e_data_book_cursor_contact_added (
  EDataBookCursor $cursor,
  EContact        $contact
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_contact_removed (
  EDataBookCursor $cursor,
  EContact        $contact
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_get_backend (EDataBookCursor $cursor)
  returns EBookBackend
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_get_position (EDataBookCursor $cursor)
  returns gint
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_get_total (EDataBookCursor $cursor)
  returns gint
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_get_type ()
  returns GType
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_load_locale (
  EDataBookCursor         $cursor,
  CArray[Str]             $locale,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_recalculate (
  EDataBookCursor         $cursor,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_register_gdbus_object (
  EDataBookCursor         $cursor,
  GDBusConnection         $connection,
  Str                     $object_path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_set_alphabetic_index (
  EDataBookCursor         $cursor,
  gint                    $index,
  Str                     $locale,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_set_sexp (
  EDataBookCursor         $cursor,
  Str                     $sexp,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_data_book_cursor_step (
  EDataBookCursor         $cursor,
  Str                     $revision_guard,
  EBookCursorStepFlags    $flags,
  EBookCursorOrigin       $origin,
  gint                    $count,
  CArray[GSList]          $results,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(edata-book)
  is export
{ * }
