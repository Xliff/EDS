use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Book::Backend::SExp;

### /usr/src/evolution-data-server-3.48.0/src/libedata-book/e-book-backend-sexp.h

sub e_book_backend_sexp_get_type ()
  returns GType
  is native(edata-book)
  is export
{ * }

sub e_book_backend_sexp_lock (EBookBackendSExp $sexp)
  is native(edata-book)
  is export
{ * }

sub e_book_backend_sexp_match_contact (
  EBookBackendSExp $sexp,
  EContact         $contact
)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_sexp_match_vcard (EBookBackendSExp $sexp, Str $vcard)
  returns uint32
  is native(edata-book)
  is export
{ * }

sub e_book_backend_sexp_new (Str $text)
  returns EBookBackendSExp
  is native(edata-book)
  is export
{ * }

sub e_book_backend_sexp_text (EBookBackendSExp $sexp)
  returns Str
  is native(edata-book)
  is export
{ * }

sub e_book_backend_sexp_unlock (EBookBackendSExp $sexp)
  is native(edata-book)
  is export
{ * }
