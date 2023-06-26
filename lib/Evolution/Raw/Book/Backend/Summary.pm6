use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

### /usr/src/evolution-data-server-3.48.0/src/addressbook/libedata-book/e-book-backend-summary.h

sub e_book_backend_summary_add_contact (
  EBookBackendSummary $summary,
  EContact            $contact
)
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_check_contact (
  EBookBackendSummary $summary,
  Str                 $id
)
  returns uint32
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_get_summary_vcard (
  EBookBackendSummary $summary,
  Str                 $id
)
  returns Str
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_is_summary_query (
  EBookBackendSummary $summary,
  Str                 $query
)
  returns uint32
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_is_up_to_date (
  EBookBackendSummary $summary,
  time_t              $t
)
  returns uint32
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_load (EBookBackendSummary $summary)
  returns uint32
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_new (
  Str  $summary_path,
  gint $flush_timeout_millis
)
  returns EBookBackendSummary
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_remove_contact (
  EBookBackendSummary $summary,
  Str                 $id
)
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_save (EBookBackendSummary $summary)
  returns uint32
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_search (
  EBookBackendSummary $summary,
  Str                 $query
)
  returns GArray
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_summary_touch (EBookBackendSummary $summary)
  is      native(edata-book)
  is      export
{ * }
