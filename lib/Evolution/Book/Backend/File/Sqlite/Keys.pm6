use v6.c;

use Method::Also;
use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Backend::File::Sqlite::Keys;

use GLib::Raw::Types;

our subset EBookSqliteKeysAncestry is export of Mu
  where EBookSqliteKeys | GObject;

class Evolution::Book::Backend::File::Keys {
  also does GLib::Roles::Object;

  has EBookSqliteKeys $!eds-sk is implementor;

  submethod BUILD ( :$e-book-sqlite-keys ) {
    self.setEBookSqliteKeys($e-book-sqlite-keys)
      if $e-book-sqlite-keys
  }

  method setEBookSqliteKeys (EBookSqliteKeysAncestry $_) {
    my $to-parent;

    $!eds-sk = do {
      when EBookSqliteKeys {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBookSqliteKeys, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EBookSqliteKeys
    is also<EBookSqliteKeys>
  { $!eds-sk }

  multi method new (
    $e-book-sqlite-keys where * ~~ EBookSqliteKeysAncestry,

    :$ref = True
  ) {
    return unless $e-book-sqlite-keys;

    my $o = self.bless( :$e-book-sqlite-keys );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    EBookSqlite() $book,
    Str()         $table_name,
    Str()         $key_column_name,
    Str()         $value_column_name
  ) {
    my $e-book-sqlite-keys = e_book_sqlite_keys_new(
      $book,
      $table_name,
      $key_column_name,
      $value_column_name
    );

    $e-book-sqlite-keys ?? self.bless( :$e-book-sqlite-keys ) !! Nil
  }

  proto method count_keys_sync (|)
    is also<count-keys-sync>
  { * }

  multi method count_keys_sync (
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($, $cancellable, $error);
  }
  multi method count_keys_sync (
                            $out_n_stored is rw,
    GCancellable()          $cancellable         = GCancellable,
    CArray[Pointer[GError]] $error               = gerror
  ) {
    my gint64 $o = 0;

    clear_error;
    e_book_sqlite_keys_count_keys_sync(
      $!eds-sk,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $out_n_stored = $o;
  }

  method foreach_sync (
                            &func,
    gpointer                $user_data   = gpointer,
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<foreach-sync>
  {
    e_book_sqlite_keys_foreach_sync(
      $!eds-sk,
      &func,
      $user_data,
      $cancellable,
      $error
    );
  }

  proto method get_ref_count_sync (|)
    is also<get-ref-count-sync>
  { * }

  multi method get_ref_count_sync (
    Str()                    $key,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($key, $, $cancellable, $error);
  }
  multi method get_ref_count_sync (
    Str()                   $key,
                            $out_ref_count is rw,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error                 = gerror;
  ) {
    my gint64 $o = 0;

    clear_error;
    e_book_sqlite_keys_get_ref_count_sync(
      $!eds-sk,
      $key,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $out_ref_count = $o;
  }

  proto method get_sync (|)
    is also<get-sync>
  { * }

  multi method get_sync (
    Str()                    $key,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($key, newCArray(Str), $cancellable, $error);
  }
  multi method get_sync (
    Str()                   $key,
    CArray[Str]             $out_value,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_book_sqlite_keys_get_sync(
      $!eds-sk,
      $key,
      $out_value,
      $cancellable,
      $error
    );
    set_error($error);
    $rv ?? ppr($out_value) !! Nil;
  }

  proto method init_table_sync (|)
  { * }

  multi method init_table_sync (
    CArray[Pointer[GError]]  $error         = gerror,
    GCancellable            :$cancellable   = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method init_table_sync (
                            $cancel where $cancel.^can('GCancellable'),

    CArray[Pointer[GError]] $error = gerror
  )
    is also<init-table-sync>
  {
    my $c = $cancel;
    $c .= GCancellable if $c !~~ GCancellable;

    clear_error;
    my $rv = so e_book_sqlite_keys_init_table_sync($!eds-sk, $c, $error);
    set_error($error);
    $rv;
  }

  proto method put_sync (|)
    is also<put-sync>
  { * }

  multi method put_sync (
    Str()                   $key,
    Str()                   $value,
    CArray[Pointer[GError]] $error                  = gerror,
    Int()                   :inc(:$inc_ref_counts)  = True,
    GCancellable()          :$cancellable           = GCancellable
  ) {
    samewith($key, $value, $inc_ref_counts, $cancellable, $error);
  }
  multi method put_sync (
    Str()                   $key,
    Str()                   $value,
    Int()                   $inc_ref_counts,
    GCancellable()          $cancellable     = GCancellable,
    CArray[Pointer[GError]] $error           = gerror
  ) {
    my guint $i = $inc_ref_counts;

    clear_error;
    my $rv = e_book_sqlite_keys_put_sync(
      $!eds-sk,
      $key,
      $value,
      $inc_ref_counts,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method remove_all_sync (|)
  { * }

  multi method remove_all_sync (
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($cancellable, $error);
  }
  multi method remove_all_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<remove-all-sync>
  {
    clear_error;
    my $rv = so e_book_sqlite_keys_remove_all_sync(
      $!eds-sk,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method remove_sync (|)
  { * }

  multi method remove_sync (
    Str()                   $key,
    CArray[Pointer[GError]] $error                 = gerror,
    Int()                   :dec(:$dec_ref_counts) = True,
    GCancellable()          :$cancellable          = GCancellable
  ) {
    samewith($key, $dec_ref_counts, $cancellable, $error);
  }
  multi method remove_sync (
    Str()                   $key,
    Int()                   $dec_ref_counts,
    GCancellable()          $cancellable     = GCancellable,
    CArray[Pointer[GError]] $error           = gerror
  )
    is also<remove-sync>
  {
    my guint $d = $dec_ref_counts;

    clear_error;
    my $rv = so e_book_sqlite_keys_remove_sync(
      $!eds-sk,
      $key,
      $d,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

}
