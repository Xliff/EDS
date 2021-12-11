use v6.c;
use Method::Also;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Sqlite;

use GLib::GList;

use GLib::Roles::Object;
use Evolution::Roles::Signals::Book::Sqlite;

our subset EBookSqliteAncestry is export of Mu
  where EBookSqlite | GObject;

class Evolution::Book::Sqlite {
  also does GLib::Roles::Object;
  also does Evolution::Roles::Signals::Book::Sqlite;

  has EBookSqlite $!ebs;

  submethod BUILD ( :$e-book-sqlite ) {
    self.setEBookSqlite($e-book-sqlite) if $e-book-sqlite;
  }

  method setEBookSqlite (EBookSqliteAncestry $_) {
    my $to-parent;

    $!ebs = do {
      when EBookSqlite {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBookSqlite, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Structs::EBookSqlite
    is also<EBookSqlite>
  { $!ebs }

  multi method new (EBookSqliteAncestry $e-book-sqlite, :$ref = True) {
    return Nil unless $e-book-sqlite;

    my $o = self.bless( :$e-book-sqlite );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str()                   $path,
    ESource()               $source,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $e-book-sqlite = e_book_sqlite_new($path, $source, $cancellable, $error);
    set_error($error);

    $e-book-sqlite ?? self.bless( :$e-book-sqlite ) !! Nil;
  }

  # cw: Needs serious simplification!
  proto method new_full (|)
    is also<new-full>
  { * }

  multi method new_full (
    $path,
    $source,
    $setup,
    :&vcard_callback    = Callable,
    :&change_callback   = Callable,
    :$user_data         = gpointer,
    :$user_data_destroy = gpointer,
    :$cancellable       = GCancellable,
    :$error             = gerror
  ) {
    samewith(
      $path,
      $source,
      $setup,
      &vcard_callback,
      &change_callback,
      $user_data,
      $user_data_destroy,
      $cancellable,
      $error
    )
  }
  multi method new_full (
    Str()                        $path,
    ESource()                    $source,
    ESourceBackendSummarySetup() $setup,
                                 &vcard_callback,
                                 &change_callback,
    gpointer                     $user_data         = gpointer,
    GDestroyNotify               $user_data_destroy = gpointer,
    GCancellable                 $cancellable       = GCancellable,
    CArray[Pointer[GError]]      $error             = gerror
  ) {
    clear_error;
    my $e-book-sqlite = e_book_sqlite_new_full(
      $path,
      $source,
      $setup,
      &vcard_callback,
      &change_callback,
      $user_data,
      $user_data_destroy,
      $cancellable,
      $error
    );
    set_error($error);

    $e-book-sqlite ?? self.bless( :$e-book-sqlite ) !! Nil;
  }

  # Is originally:
  # EBookSqlite, gpointer, GObject, gchar, gboolean, GObject, gpointer, gpointer --> gboolean
  method before-insert-contact is also<before_insert_contact> {
    self.connect-before-insert-contact($!ebs);
  }

  # Is originally:
  # EBookSqlite, gpointer, gchar, GObject, gpointer, gpointer --> gboolean
  method before-remove-contact is also<before_remove_contact> {
    self.connect-before-remove-contact($!ebs);
  }

  method add_contact (
    EContact()              $contact,
    Str()                   $extra,
    Int()                   $replace,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<add-contact>
  {
    my gboolean $r = $replace.so.Int;

    clear_error;
    my $rv = so e_book_sqlite_add_contact(
      $!ebs,
      $contact,
      $extra,
      $r,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method add_contacts (|)
    is also<add-contacts>
  { * }

  multi method add_contacts (
    @contacts,
    @extra,
    $replace,
    $cancellable,
    $error
  ) {
    samewith(
      GSList.new(@contacts, typed => EContact),
      GSList.new(@extra,    typed => Str),
      $replace,
      $cancellable,
      $error
    );
  }
  multi method add_contacts (
    GSList()                $contacts,
    GSList()                $extra,
    Int()                   $replace,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my gboolean $r = $replace.so.Int;

    clear_error;
    my $rv = so e_book_sqlite_add_contacts(
      $!ebs,
      $contacts,
      $extra,
      $r,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  multi method calculate (
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False
  ) {
    my $ebsc = EbSqlCursor.new;

    return-with-all(
      samewith($ebsc, $, $, $cancellable, $error, :all, :$raw)
    );
  }
  multi method calculate (
    EbSqlCursor()            $cursor,
                             $total       is rw,
                             $position    is rw,
    GCancellable()           $cancellable =  GCancellable,
    CArray[Pointer[GError]]  $error       =  gerror,
                            :$all         =  False,
                            :$raw         =  False
  ) {
    my gint ($t, $p) = 0 xx 2;

    clear_error;
    my $rv = e_book_sqlite_cursor_calculate(
      $!ebs,
      $cursor,
      $t,
      $p,
      $cancellable,
      $error
    );
    set_error($error);

    ($total, $position) = ($t, $p);

    my $ebsc = propReturnObject(
      $cursor,
      $raw,
      |Evolution::Book::Cursor.getTypePair
    );

    $all.not ?? $rv !! ($rv, $cursor, $total, $position);
  }

  method error_quark (Evolution::Book::Sqlite:U: ) is also<error-quark> {
    e_book_sqlite_error_quark();
  }

  proto method get_contact (|)
    is also<get-contact>
  { * }

  multi method get_contact (
     $uid,
     $meta_contact,
     $error,
    :$raw           = False
  ) {
    my $c = newCArray(EContact);

    samewith($uid, $meta_contact, $c, $error, :all, :$raw)
  }
  multi method get_contact (
    Str()                      $uid,
    Int()                      $meta_contact,
    CArray[Pointer[EContact]]  $ret_contact,
    CArray[Pointer[GError]]    $error,
                              :$all           = False,
                              :$raw           = False
  ) {
    my gboolean $m =  $meta_contact.so.Int;

    clear_error;
    my $rv = so e_book_sqlite_get_contact(
      $!ebs,
      $uid,
      $m,
      $ret_contact,
      $error
    );
    set_error($error);

    my $c = ppr($ret_contact);
    $c = Evolution::Contact.new($c) unless $raw;

    $all.not ?? $rv !! ($rv, $c);
  }

  proto method get_contact_extra (|)
    is also<get-contact-extra>
  { * }

  multi method get_contact_extra (
    Str()                    $uid,
    CArray[Pointer[GError]]  $error = gerror
  ) {
    my $e = newCArray(Str);

    samewith($uid, $e, $error, :all);
  }
  multi method get_contact_extra (
    Str()                    $uid,
    CArray[Str]              $ret_extra,
    CArray[Pointer[GError]]  $error      = gerror,
                            :$all        = False
  ) {
    clear_error;
    my $rv = so e_book_sqlite_get_contact_extra(
      $!ebs,
      $uid,
      $ret_extra,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ( $rv, ppr($ret_extra) );
  }

  proto method get_key_value (|)
    is also<get-key-value>
  { * }

  multi method get_key_value (
    $key,
    $error = gerror,
  ) {
    my $v = newCArray(Str);

    return-with-all( samewith($key, $v, $error, :all) );
  }
  multi method get_key_value (
    Str()                   $key,
    CArray[Str]             $value,
    CArray[Pointer[GError]] $error  = gerror,
                            :$all   = False
  ) {
    clear_error;
    my $rv = so e_book_sqlite_get_key_value($!ebs, $key, $value, $error);
    set_error($error);

    $all.not ?? $rv !! ( $rv, ppr($value) );
  }

  proto method get_key_value_int (|)
    is also<get-key-value-int>
  { * }

  multi method get_key_value_int (
    $key,
    $error =  gerror
  ) {
    return-with-all(
      samewith($key, $, $error, :all)
    )
  }
  multi method get_key_value_int (
    Str                      $key,
                             $value is rw,
    CArray[Pointer[GError]]  $error =  gerror,
                            :$all   =  False
  ) {
    my gint $v = 0;

    clear_error;
    my $rv = so e_book_sqlite_get_key_value_int($!ebs, $key, $v, $error);
    set_error($error);
    $value = $v;

    $all.not ?? $rv !! ($rv, $value);
  }

  proto method get_locale (|)
    is also<get-locale>
  { * }

  multi method get_locale ( CArray[Pointer[GError]] $error = gerror ) {
    (my $l = CArray[Str].new)[0] = Str;

    return-with-all(
      samewith($l, $error, :all)
    );
  }
  multi method get_locale (
    CArray[Str]              $locale_out,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$all         = False
  ) {
    clear_error;
    my $rv = e_book_sqlite_get_locale($!ebs, $locale_out, $error);
    set_error($error);

    $all.not ?? $rv !! ( $rv, ppr($locale_out) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_book_sqlite_get_type, $n, $t );
  }

  proto method get_vcard (|)
    is also<get-vcard>
  { * }

  multi method get_vcard (
    Str()                    $uid,
    Int()                    $meta_contact,
    CArray[Pointer[GError]]  $error         = gerror
  ) {
    my $m = $meta_contact.so.Int;
    my $r = newCArray(Str);

    return-with-all(
      samewith($uid, $m, $r, $error, :all)
    );
  }
  multi method get_vcard (
    Str()                    $uid,
    Int()                    $meta_contact,
    CArray[Str]              $ret_vcard,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$all           = False
  ) {
    my gboolean $m = $meta_contact.so.Int;

    clear_error;
    my $rv = so e_book_sqlite_get_vcard(
      $!ebs,
      $uid,
      $m,
      $ret_vcard,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ( $rv, ppr($ret_vcard) );
  }

  method has_contact (
    Str()                   $uid,
    Int()                   $exists,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<has-contact>
  {
    my gboolean $e = $exists.so.Int;

    clear_error;
    my $rv = so e_book_sqlite_has_contact($!ebs, $uid, $e, $error);
    set_error($error);
    $rv;
  }

  method lock (
    Int()                   $lock_type,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my EbSqlLockType $l = $lock_type;

    clear_error;
    e_book_sqlite_lock($!ebs, $l, $cancellable, $error);
    set_error($error);
  }

  method ref_collator ( :$raw = False ) is also<ref-collator> {
    propReturnObject(
      e_book_sqlite_ref_collator($!ebs),
      $raw,
      |Evolution::Collator.getTypePair
    );
  }

  method ref_source ( :$raw = False ) is also<ref-source> {
    propReturnObject(
      e_book_sqlite_ref_source($!ebs),
      $raw,
      |Evolution::Source.getTypePair
    );
  }

  method remove_contact (
    Str()                   $uid,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<remove-contact>
  {
    clear_error;
    my $rv = so e_book_sqlite_remove_contact(
      $!ebs,
      $uid,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method remove_contacts (
    GSList()                $uids,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<remove-contacts>
  {
    clear_error;
    my $rv = so e_book_sqlite_remove_contacts(
      $!ebs,
      $uids,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  multi method search (
    Str()                   $sexp,
    Int()                   $meta_contacts,
    CArray[Pointer[GError]] $error          = gerror,
    GCancellable()          :$cancellable   = GCancellable
  ) {
    my $rl = newCArray(GSList);

    return-with-all(
      samewith($sexp, $meta_contacts, $rl, $cancellable, $error, :all)
    )
  }
  multi method search (
    Str()                    $sexp,
    Int()                    $meta_contacts,
    CArray[Pointer[GSList]]  $ret_list,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$all            = False,
                            :$glist          = False,
  ) {
    my gboolean $m = $meta_contacts.so.Int;

    clear_error;
    my $rv = so e_book_sqlite_search(
      $!ebs,
      $sexp,
      $m,
      $ret_list,
      $cancellable,
      $error
    );
    set_error($error);

    my $rl = returnGList( ppr($ret_list), True, $glist, EbSqlSearchData);

    $all.not ?? $rv !! ($rv, $rl);
  }

  method search_data_free (Evolution::Book::Sqlite:U: EbSqlSearchData $sd)
    is also<search-data-free>
  {
    e_book_sqlite_search_data_free($sd);
  }

  proto method search_uids (|)
    is also<search-uids>
  { * }

  multi method search_uids (
    Str()                    $sexp,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$glist       = False,
    GCancellable()          :$cancellable = GCancellable
  ) {
    my $rl = newCArray(GSList);

    return-with-all(
      samewith($sexp, $rl, $cancellable, $error, :all, :$glist)
    );
  }
  multi method search_uids (
    Str()                    $sexp,
    CArray[Pointer[GSList]]  $ret_list,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$all         = False,
                            :$glist       = False
  ) {
    clear_error;
    my $rv = so e_book_sqlite_search_uids(
      $!ebs,
      $sexp,
      $ret_list,
      $cancellable,
      $error
    );
    set_error($error);

    my $rl = returnGList( ppr($ret_list), True, $glist, Str );

    $all.not ?? $rv !! ($rv, $rl)
  }

  method set_contact_extra (
    Str()                   $uid,
    Str()                   $extra,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<set-contact-extra>
  {
    clear_error;
    my $rv = so e_book_sqlite_set_contact_extra($!ebs, $uid, $extra, $error);
    set_error($error);
    $rv;
  }

  method set_key_value (
    Str()                   $key,
    Str()                   $value,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<set-key-value>
  {
    clear_error;
    my $rv = so e_book_sqlite_set_key_value($!ebs, $key, $value, $error);
    set_error($error);
    $rv
  }

  method set_key_value_int (
    Str()                   $key,
    Int()                   $value,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-key-value-int>
  {
    my gint $v = $value;

    clear_error;
    my $rv = so e_book_sqlite_set_key_value_int($!ebs, $key, $value, $error);
    set_error($error);
    $rv;
  }

  method set_locale (
    Str()                   $lc_collate,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<set-locale>
  {
    clear_error;
    e_book_sqlite_set_locale($!ebs, $lc_collate, $cancellable, $error);
    set_error($error);
  }

  method unlock (Int() $action, CArray[Pointer[GError]] $error = gerror) {
    my EbSqlUnlockAction $a = $action;

    clear_error;
    my $rv = so e_book_sqlite_unlock($!ebs, $a, $error);
    set_error($error);
    $rv;
  }

  proto method get_contact_extra_unlocked (|)
    is also<get-contact-extra-unlocked>
  { * }

  multi method get_contact_extra_unlocked (
    Str()                    $uid,
    CArray[Pointer[GError]]  $error = gerror
  ) {
    my $ec = newCArray(Str);

    return-with-all( samewith($uid, $ec, $error, :all) );
  }
  multi method get_contact_extra_unlocked (
    Str()                    $uid,
    CArray[Str]              $ret_extra,
    CArray[Pointer[GError]]  $error      = gerror,
                            :$all        = False
  ) {
    clear_error;
    my $rv = so ebsql_get_contact_extra_unlocked(
      $!ebs,
      $uid,
      $ret_extra,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ( $rv, ppr($ret_extra) );
  }

  proto method get_contact_unlocked (|)
    is also<get-contact-unlocked>
  { * }

  multi method get_contact_unlocked (
    Str()                    $uid,
    Int()                    $meta_contact,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$raw           = False,
  ) {
    my $oc = newCArray(EContact);

    return-with-all(
      samewith($uid, $meta_contact, $oc, $error, :all, :$raw)
    );
  }
  multi method get_contact_unlocked (
    Str()                      $uid,
    Int()                      $meta_contact,
    CArray[Pointer[EContact]]  $contact,
    CArray[Pointer[GError]]    $error,
                              :$all          = False,
                              :$raw          = False
  ) {
    my gboolean $m = $meta_contact.so.Int;

    clear_error;
    my $rv = so ebsql_get_contact_unlocked(
      $!ebs,
      $uid,
      $meta_contact,
      $contact,
      $error
    );
    set_error($error);

    my $oc = propReturnObject(
      ppr($contact),
      $raw,
      |Evolution::Contact.getTypePair
    );

    $all.not ?? $rv !! ($rv, $oc)
  }

  proto method get_vcard_unlocked (|)
    is also<get-vcard-unlocked>
  { * }

  multi method get_vcard_unlocked (
    Str()                   $uid,
    Int()                   $meta_contact,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    my $rv = newCArray(Str);

    return-with-all(
      samewith($uid, $meta_contact, $rv, $error, :all)
    );
  }
  multi method get_vcard_unlocked (
    Str()                    $uid,
    Int()                    $meta_contact,
    CArray[Str]              $ret_vcard,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$all           = False
  ) {
    my gboolean $m = $meta_contact.so.Int;

    clear_error;
    my $rv = ebsql_get_vcard_unlocked(
      $!ebs,
      $uid,
      $m,
      $ret_vcard,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ( $rv, ppr($ret_vcard) );
  }

}

# POINTER

class Evolution::Book::Sqlite::Cursor {
  also does GLib::Roles::Implementor;

  has EbSqlCursor $!ebsc  is implementor;
  has EBookSqlite $!ebsql;

  submethod BUILD ( :$e-book-sqlite-cursor, :$!ebsql ) {
    $!ebsc = $e-book-sqlite-cursor;
  }

  method Evolution::Raw::Definitions::EbSqlCursor
    is also<EbSqlCursor>
  { $!ebsc }

  multi method new (
    EBookSqlite()               $ebsql,
    Str()                       $sexp,
                                @sort_fields,
                                @sort_types,
    CArray[Pointer[GError]]     $error          = gerror
  ) {
    die "\@sort_fields and \@sort_types must have the same number of entries!"
      unless +@sort_fields == +@sort_types;

    samewith(
      $ebsql,
      ArrayToCArray(EContactField,       @sort_fields),
      ArrayToCArray(EBookCursorSortType, @sort_types),
      @sort_fields.elems,
      $error
    )
  }
  multi method new (
    EBookSqlite()               $ebsql,
    Str()                       $sexp,
    CArray[EContactField]       $sort_fields,
    CArray[EBookCursorSortType] $sort_types,
    Int()                       $n_sort_fields,
    CArray[Pointer[GError]]     $error          = gerror
  ) {
    my guint $n = $n_sort_fields;

    clear_error;
    my $e-book-sqlite-cursor = e_book_sqlite_cursor_new(
      $ebsql,
      $sexp,
      $sort_fields,
      $sort_types,
      $n_sort_fields,
      $error
    );
    set_error($error);

    $e-book-sqlite-cursor ?? self.bless( :$e-book-sqlite-cursor, :$ebsql )
                          !! Nil;
  }

  method compare_contact (EContact() $contact, Int() $matches_sexp)
    is also<compare-contact>
  {
    my gboolean $m = $matches_sexp.so.Int;

    e_book_sqlite_cursor_compare_contact($!ebsc, $contact, $m);
  }

  method free {
    e_book_sqlite_cursor_free($!ebsql, $!ebsc);
  }

  method set_sexp (
    Str()                   $sexp,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-sexp>
  {
    clear_error;
    my $rv = so e_book_sqlite_cursor_set_sexp($!ebsc, $sexp, $error);
    set_error($error);
    $rv;
  }

  method set_target_alphabetic_index (Int() $idx)
    is also<set-target-alphabetic-index>
  {
    my gint $i = $idx;

    e_book_sqlite_cursor_set_target_alphabetic_index($!ebsc, $idx);
  }

  multi method step (
    $flags,
    $origin,
    $count,
    $error       = gerror,
   :$cancellable = GCancellable,
   :$glist       = False
  ) {
    my $r = newCArray(GSList);

    samewith(
      $flags,
      $origin,
      $count,
      $r,
      $cancellable,
      $error,
      :all,
      :$glist
    )
  }
  multi method step (
    Int()                    $flags,
    Int()                    $origin,
    Int()                    $count,
    CArray[Pointer[GSList]]  $results,
    GCancellable()           $cancellable = gerror,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$all         = False,
                            :$glist       = False
  ) {
    my EbSqlCursorStepFlags $f = $flags;
    my EbSqlCursorOrigin    $o = $origin;
    my gint                 $c = $count;

    clear_error;
    my $nc = e_book_sqlite_cursor_step(
      $!ebsc,
      $flags,
      $origin,
      $count,
      $results,
      $cancellable,
      $error
    );
    set_error($error);

    my $r = returnGList(
      $results,
      True,
      $glist,
      EbSqlSearchData
    );

    $all.not ?? $nc !! ($nc, $r);
  }

}
