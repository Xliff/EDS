use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Book::Sqlite;

### /usr/src/evolution-data-server-3.48.0/src/libedata-book/e-book-sqlite.h

sub e_book_sqlite_add_contact (
  EBookSqlite             $ebsql,
  EContact                $contact,
  Str                     $extra,
  gboolean                $replace,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_add_contacts (
  EBookSqlite             $ebsql,
  GSList                  $contacts,
  GSList                  $extra,
  gboolean                $replace,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_cursor_calculate (
  EBookSqlite             $ebsql,
  EbSqlCursor             $cursor,
  gint                    $total        is rw,
  gint                    $position     is rw,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_cursor_compare_contact (
  EBookSqlite $ebsql,
  EbSqlCursor $cursor,
  EContact    $contact,
  gboolean    $matches_sexp
)
  returns gint
  is native(eds)
  is export
{ * }

sub e_book_sqlite_cursor_free (EBookSqlite $ebsql, EbSqlCursor $cursor)
  is native(eds)
  is export
{ * }

sub e_book_sqlite_cursor_new (
  EBookSqlite             $ebsql,
  Str                     $sexp,
  EContactField           $sort_fields,
  EBookCursorSortType     $sort_types,
  guint                   $n_sort_fields,
  CArray[Pointer[GError]] $error
)
  returns EbSqlCursor
  is native(eds)
  is export
{ * }

sub e_book_sqlite_cursor_set_sexp (
  EBookSqlite             $ebsql,
  EbSqlCursor             $cursor,
  Str                     $sexp,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_cursor_set_target_alphabetic_index (
  EBookSqlite $ebsql,
  EbSqlCursor $cursor,
  gint        $idx
)
  is native(eds)
  is export
{ * }

sub e_book_sqlite_cursor_step (
  EBookSqlite             $ebsql,
  EbSqlCursor             $cursor,
  EbSqlCursorStepFlags    $flags,
  EbSqlCursorOrigin       $origin,
  gint                    $count,
  CArray[GSList]          $results,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(eds)
  is export
{ * }

sub e_book_sqlite_error_quark ()
  returns GQuark
  is native(eds)
  is export
{ * }

sub e_book_sqlite_get_contact (
  EBookSqlite             $ebsql,
  Str                     $uid,
  gboolean                $meta_contact,
  CArray[EContact]        $ret_contact,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_get_contact_extra (
  EBookSqlite             $ebsql,
  Str                     $uid,
  CArray[Str]             $ret_extra,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_get_key_value (
  EBookSqlite             $ebsql,
  Str                     $key,
  CArray[Str]             $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_get_key_value_int (
  EBookSqlite             $ebsql,
  Str                     $key,
  gint                    $value is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_get_locale (
  EBookSqlite             $ebsql,
  CArray[Str]             $locale_out,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_book_sqlite_get_vcard (
  EBookSqlite             $ebsql,
  Str                     $uid,
  gboolean                $meta_contact,
  CArray[Str]             $ret_vcard,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_has_contact (
  EBookSqlite             $ebsql,
  Str                     $uid,
  gboolean                $exists,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_lock (
  EBookSqlite             $ebsql,
  EbSqlLockType           $lock_type,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_new (
  Str                     $path,
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns EBookSqlite
  is native(eds)
  is export
{ * }

sub e_book_sqlite_new_full (
  Str                        $path,
  ESource                    $source,
  ESourceBackendSummarySetup $setup,
                             &vcard_callback (Str, Str, gpointer --> Str),
                             &change_callback (
                              EbSqlChangeType, 
                              Str,
                              Str,
                              Str
                              --> gpointer
                             ),
  gpointer                   $user_data,
  GDestroyNotify             $user_data_destroy,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns EBookSqlite
  is native(eds)
  is export
{ * }

sub e_book_sqlite_ref_collator (EBookSqlite $ebsql)
  returns ECollator
  is native(eds)
  is export
{ * }

sub e_book_sqlite_ref_source (EBookSqlite $ebsql)
  returns ESource
  is native(eds)
  is export
{ * }

sub e_book_sqlite_remove_contact (
  EBookSqlite             $ebsql,
  Str                     $uid,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_remove_contacts (
  EBookSqlite             $ebsql,
  GSList                  $uids,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_search (
  EBookSqlite             $ebsql,
  Str                     $sexp,
  gboolean                $meta_contacts,
  CArray[GSList]          $ret_list,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_search_data_free (EbSqlSearchData $data)
  is native(eds)
  is export
{ * }

sub e_book_sqlite_search_uids (
  EBookSqlite             $ebsql,
  Str                     $sexp,
  CArray[GSList]          $ret_list,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_set_contact_extra (
  EBookSqlite             $ebsql,
  Str                     $uid,
  Str                     $extra,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_set_key_value (
  EBookSqlite             $ebsql,
  Str                     $key,
  Str                     $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_set_key_value_int (
  EBookSqlite             $ebsql,
  Str                     $key,
  gint                    $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_set_locale (
  EBookSqlite             $ebsql,
  Str                     $lc_collate,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_book_sqlite_unlock (
  EBookSqlite             $ebsql,
  EbSqlUnlockAction       $action,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub ebsql_get_contact_extra_unlocked (
  EBookSqlite             $ebsql,
  Str                     $uid,
  CArray[Str]             $ret_extra,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub ebsql_get_contact_unlocked (
  EBookSqlite             $ebsql,
  Str                     $uid,
  gboolean                $meta_contact,
  CArray[EContact]        $contact,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub ebsql_get_vcard_unlocked (
  EBookSqlite             $ebsql,
  Str                     $uid,
  gboolean                $meta_contact,
  CArray[Str]             $ret_vcard,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }
