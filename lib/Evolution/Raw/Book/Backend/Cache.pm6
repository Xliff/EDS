use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Book::Backend::Cache;

### /usr/src/evolution-data-server-3.48.0/src/addressbook/libedata-book/e-book-backend-cache.h

sub e_book_backend_cache_add_contact (
  EBookBackendCache $cache,
  EContact          $contact
)
  returns uint32
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_check_contact (
  EBookBackendCache $cache,
  Str               $uid
)
  returns uint32
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_get_contact (
  EBookBackendCache $cache,
  Str               $uid
)
  returns EContact
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_get_contacts (
  EBookBackendCache $cache,
  Str               $query
)
  returns GList
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_get_time (EBookBackendCache $cache)
  returns Str
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_get_type
  returns GType
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_is_populated (EBookBackendCache $cache)
  returns uint32
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_new (Str $filename)
  returns EBookBackendCache
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_remove_contact (
  EBookBackendCache $cache,
  Str               $uid
)
  returns uint32
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_search (
  EBookBackendCache $cache,
  Str               $query
)
  returns GPtrArray
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_set_populated (EBookBackendCache $cache)
  is      native(edata-book)
  is      export
{ * }

sub e_book_backend_cache_set_time (
  EBookBackendCache $cache,
  Str               $t
)
  is      native(edata-book)
  is      export
{ * }
