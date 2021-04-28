use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Book::Client::View;

### /usr/include/evolution-data-server/libebook/e-book-client-view.h

sub e_book_client_view_get_client (EBookClientView $client_view)
  returns EBookClient
  is native(ebook)
  is export
{ * }

sub e_book_client_view_get_connection (EBookClientView $client_view)
  returns GDBusConnection
  is native(ebook)
  is export
{ * }

sub e_book_client_view_get_object_path (EBookClientView $client_view)
  returns Str
  is native(ebook)
  is export
{ * }

sub e_book_client_view_get_type ()
  returns GType
  is native(ebook)
  is export
{ * }

sub e_book_client_view_is_running (EBookClientView $client_view)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_view_ref_client (EBookClientView $client_view)
  returns EBookClient
  is native(ebook)
  is export
{ * }

sub e_book_client_view_set_fields_of_interest (
  EBookClientView         $client_view,
  GSList                  $fields_of_interest,
  CArray[Pointer[GError]] $error
)
  is native(ebook)
  is export
{ * }

sub e_book_client_view_set_flags (
  EBookClientView         $client_view,
  EBookClientViewFlags    $flags,
  CArray[Pointer[GError]] $error
)
  is native(ebook)
  is export
{ * }

sub e_book_client_view_start (
  EBookClientView         $client_view,
  CArray[Pointer[GError]] $error
)
  is native(ebook)
  is export
{ * }

sub e_book_client_view_stop (
  EBookClientView         $client_view,
  CArray[Pointer[GError]] $error
)
  is native(ebook)
  is export
{ * }
