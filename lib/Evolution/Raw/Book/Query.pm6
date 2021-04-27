use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;

unit package Evolution::Raw::Book::Query;

### /usr/include/evolution-data-server/libebook-contacts/e-book-query.h

sub e_book_query_and (gint $nqs, EBookQuery $qs, gboolean $unref)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_andv (EBookQuery $q)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_any_field_contains (Str $value)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_copy (EBookQuery $q)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_field_exists (EContactField $field)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_field_test (
  EContactField  $field,
  EBookQueryTest $test,
  Str            $value
)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_from_string (Str $query_string)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_get_type ()
  returns GType
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_not (EBookQuery $q, gboolean $unref)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_or (gint $nqs, EBookQuery $qs, gboolean $unref)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_orv (EBookQuery $q)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_ref (EBookQuery $q)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_to_string (EBookQuery $q)
  returns Str
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_unref (EBookQuery $q)
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_vcard_field_exists (Str $field)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }

sub e_book_query_vcard_field_test (
  Str            $field,
  EBookQueryTest $test,
  Str            $value
)
  returns EBookQuery
  is native(ebook-contacts)
  is export
{ * }
