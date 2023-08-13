use v6.c;

use NativeCall;
use Method::Also;

use Evolution::Raw::Types;

use Evolution::Data::Book::Cursor;

use GLib::Roles::Implementor;


our subset EDataBookCursorSqliteAncestry is export of Mu
  where EDataBookCursorSqlite | EDataBookCursorAncestry;

class Evolution::Data::Book::Cursor::Sqlite
  is Evolution::Data::Book::Cursor
{
  has EDataBookCursorSqlite $!eds-dbcs is implementor;

  submethod BUILD ( :$e-cursor-sqlite ) {
    self.setEDataBookCursorSqlite($e-cursor-sqlite) if $e-cursor-sqlite
  }

  method setEDataBookCursorSqlite (EDataBookCursorSqliteAncestry $_) {
    my $to-parent;

    $!eds-dbcs = do {
      when EDataBookCursorSqlite {
        $to-parent = cast(EDataBookCursor, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EDataBookCursorSqlite, $_);
      }
    }
    self.setEDataBookCursort($to-parent);
  }

  method Evolution::Raw::Structs::EDataBookCursorSqlite
    is also<EDataBookCursorSqlite>
  { $!eds-dbcs }

  multi method new (
     $e-cursor-sqlite where * ~~ EDataBookCursorSqliteAncestry,

    :$ref = True
  ) {
    return unless $e-cursor-sqlite;

    my $o = self.bless( :$e-cursor-sqlite );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    EBookSqlite()               $ebsql,
    Str()                       $revision_key,
                                @sort_fields,
                                @sort_types,
    CArray[Pointer[GError]]     $error
  ) {
    samewith(
      $ebsql,
      $revision_key,
      newCArray(EContactField,       @sort_fields),
      newCArray(EBookCursorSortType, @sort_types),
      min(+@sort_fields, +@sort_types),
      $error
    );
  }
  multi method new (
    EBookSqlite()               $ebsql,
    Str()                       $revision_key,
    CArray[EContactField]       $sort_fields,
    CArray[EBookCursorSortType] $sort_types,
    Int()                       $n_fields,
    CArray[Pointer[GError]]     $error
  ) {
    my guint $n = $n_fields;

    clear_error;
    my $e-cursor-sqlite = e_data_book_cursor_sqlite_new(
      $ebsql,
      $revision_key,
      $sort_fields,
      $sort_types,
      $n,
      $error
    );
    set_error($error);

    $e-cursor-sqlite ?? self.bless( :$e-cursor-sqlite ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_data_book_cursor_sqlite_get_type,
      $n,
      $t
    );
  }

}


### /usr/src/evolution-data-server-3.48.0/src/addressbook/libedata-book/e-data-book-cursor-sqlite.h

sub e_data_book_cursor_sqlite_get_type
  returns GType
  is      native(edata-book)
  is      export
{ * }

sub e_data_book_cursor_sqlite_new (
  EBookBackend                $backend,
  EBookSqlite                 $ebsql,
  Str                         $revision_key,
  CArray[EContactField]       $sort_fields,
  CArray[EBookCursorSortType] $sort_types,
  guint                       $n_fields,
  CArray[Pointer[GError]]     $error
)
  returns EDataBookCursor
  is      native(edata-book)
  is      export
{ * }
