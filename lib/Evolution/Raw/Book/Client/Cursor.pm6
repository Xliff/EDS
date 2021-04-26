use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

### /usr/include/evolution-data-server/libebook/e-book-client-cursor.h

sub e_book_client_cursor_get_alphabet (
  EBookClientCursor $cursor,
  gint              $n_labels  is rw,
  gint              $underflow is rw,
  gint              $inflow    is rw,
  gint              $overflow  is rw
)
  returns CArray[Str]
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_get_contact_alphabetic_index (
  EBookClientCursor $cursor,
  EContact          $contact
)
  returns gint
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_get_position (EBookClientCursor $cursor)
  returns gint
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_get_total (EBookClientCursor $cursor)
  returns gint
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_get_type ()
  returns GType
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_ref_client (EBookClientCursor $cursor)
  returns EBookClient
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_set_alphabetic_index (
  EBookClientCursor $cursor,
  gint              $index,
  GCancellable      $cancellable,
                    &callback (EBookClientCursor, GAsyncResult, gpointer),
  gpointer          $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_set_alphabetic_index_finish (
  EBookClientCursor       $cursor,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_set_alphabetic_index_sync (
  EBookClientCursor       $cursor,
  gint                    $index,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_set_sexp (
  EBookClientCursor $cursor,
  Str               $sexp,
  GCancellable      $cancellable,
                    &callback (EBookClientCursor, GAsyncResult, gpointer),
  gpointer          $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_set_sexp_finish (
  EBookClientCursor       $cursor,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_set_sexp_sync (
  EBookClientCursor       $cursor,
  Str                     $sexp,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_step (
  EBookClientCursor    $cursor,
  EBookCursorStepFlags $flags,
  EBookCursorOrigin    $origin,
  gint                 $count,
  GCancellable         $cancellable,
                       &callback (EBookClientCursor, GAsyncResult, gpointer),
  gpointer             $user_data
)
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_step_finish (
  EBookClientCursor       $cursor,
  GAsyncResult            $result,
  CArray[Pointer[GSList]] $out_contacts,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(ebook)
  is export
{ * }

sub e_book_client_cursor_step_sync (
  EBookClientCursor       $cursor,
  EBookCursorStepFlags    $flags,
  EBookCursorOrigin       $origin,
  gint                    $count,
  CArray[Pointer[GSList]] $out_contacts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(ebook)
  is export
{ * }
