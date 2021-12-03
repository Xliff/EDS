use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Data::Book;

### /usr/include/evolution-data-server/libedata-book/e-data-book.h

sub e_data_book_get_connection (EDataBook $book)
  returns GDBusConnection
  is native(edata-book)
  is export
{ * }

sub e_data_book_get_object_path (EDataBook $book)
  returns Str
  is native(edata-book)
  is export
{ * }

sub e_data_book_get_type ()
  returns GType
  is native(edata-book)
  is export
{ * }

sub e_data_book_new (
  EBookBackend            $backend,
  GDBusConnection         $connection,
  Str                     $object_path,
  CArray[Pointer[GError]] $error
)
  returns EDataBook
  is native(edata-book)
  is export
{ * }

sub e_data_book_ref_backend (EDataBook $book)
  returns EBookBackend
  is native(edata-book)
  is export
{ * }

sub e_data_book_report_backend_property_changed (
  EDataBook $book,
  Str       $prop_name,
  Str       $prop_value
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_report_error (EDataBook $book, Str $message)
  is native(edata-book)
  is export
{ * }

sub e_data_book_respond_create_contacts (
  EDataBook $book,
  guint32   $opid,
  GError    $error,
  GSList    $contacts
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_respond_get_contact (
  EDataBook $book,
  guint32   $opid,
  GError    $error,
  EContact  $contact
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_respond_get_contact_list (
  EDataBook $book,
  guint32   $opid,
  GError    $error,
  GSList    $contacts
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_respond_get_contact_list_uids (
  EDataBook  $book,
  guint32    $opid,
  GError     $error,
  GSList     $uids
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_respond_modify_contacts (
  EDataBook $book,
  guint32   $opid,
  GError    $error,
  GSList    $contacts
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_respond_open (
  EDataBook $book,
  guint32   $opid,
  GError    $error
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_respond_refresh (
  EDataBook $book,
  guint32   $opid,
  GError    $error
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_respond_remove_contacts (
  EDataBook $book,
  guint32   $opid,
  GError    $error,
  GSList    $ids
)
  is native(edata-book)
  is export
{ * }

sub e_data_book_set_locale (
  EDataBook               $book,
  Str                     $locale,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_data_book_string_slist_to_comma_string (GSList $strings)
  returns Str
  is native(edata-book)
  is export
{ * }
