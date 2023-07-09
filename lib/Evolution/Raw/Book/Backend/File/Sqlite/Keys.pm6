use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Book::Backends::File::SqliteKeys;

### /usr/src/evolution-data-server-3.48.0/src/addressbook/backends/file/e-book-sqlite-keys.h

sub e_book_sqlite_keys_count_keys_sync (
  EBookSqliteKeys         $self,
  gint64                  $out_n_stored is rw,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_sqlite_keys_foreach_sync (
  EBookSqliteKeys            $self,
                             &func (
                               EBookSqliteKeys,
                               Str,
                               Str,
                               guint,
                               gpointer
                             ),
  gpointer                   $user_data,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_sqlite_keys_get_ref_count_sync (
  EBookSqliteKeys         $self,
  Str                     $key,
  guint                   $out_ref_count is rw,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_sqlite_keys_get_sync (
  EBookSqliteKeys         $self,
  Str                     $key,
  CArray[Str]             $out_value,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_sqlite_keys_init_table_sync (
  EBookSqliteKeys         $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_sqlite_keys_new (
  EBookSqlite $ebsql,
  Str         $table_name,
  Str         $key_column_name,
  Str         $value_column_name
)
  returns EBookSqliteKeys
  is      native(eds)
  is      export
{ * }

sub e_book_sqlite_keys_put_sync (
  EBookSqliteKeys         $self,
  Str                     $key,
  Str                     $value,
  guint                   $inc_ref_counts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_sqlite_keys_remove_all_sync (
  EBookSqliteKeys         $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_book_sqlite_keys_remove_sync (
  EBookSqliteKeys         $self,
  Str                     $key,
  guint                   $dec_ref_counts,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }
