use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Data::Book::Cursor;

use GLib::GList;

use GLib::Roles::Object;

our subset EDataBookCursorAncestry is export of Mu
  where EDataBookCursor | GObject;

class Evolution::Data::Book::Cursor {
  also does GLib::Roles::Object;

  has EDataBookCursor $!edbc is implementor;

  submethod BUILD ( :$e-data-book-cursor ) {
    self.setEDataBookCursor($e-data-book-cursor) if $e-data-book-cursor
  }

  method setEDataBookCursor (EDataBookCursorAncestry $_) {
    my $to-parent;

    $!edbc = do {
      when EDataBookCursor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EDataBookCursor, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EDataBookCursor
    is also<EDataBookCursor>
  { $!edbc }

  multi method new (
     $e-data-book-cursor where * ~~ EDataBookCursorAncestry,

    :$ref = True
  ) {
    return unless $e-data-book-cursor;

    my $o = self.bless( :$e-data-book-cursor );
    $o.ref if $ref;
    $o;
  }

  method contact_added (EContact() $contact) is also<contact-added> {
    e_data_book_cursor_contact_added($!edbc, $contact);
  }

  method contact_removed (EContact() $contact) is also<contact-removed> {
    e_data_book_cursor_contact_removed($!edbc, $contact);
  }

  method get_backend ( :$raw = False ) is also<get-backend> {
    propReturnObject(
      e_data_book_cursor_get_backend($!edbc),
      $raw,
      |::('Evolution::Book::Backend').getTypePair
    );
  }

  method get_position is also<get-position> {
    e_data_book_cursor_get_position($!edbc);
  }

  method get_total is also<get-total> {
    e_data_book_cursor_get_total($!edbc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_data_book_cursor_get_type, $n, $t );
  }

  proto method load_locale (|)
    is also<load-locale>
  { * }

  multi method load_locale (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
  ) {
    (my $l = CArray[Str].new)[0] = Str;

    return-with-all( samewith($l, $cancellable, $error, :all) )
  }
  multi method load_locale (
    CArray[Str]             $locale,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror,
                            :$all         = False
  ) {
    clear_error;
    my $rv = e_data_book_cursor_load_locale(
      $!edbc,
      $locale,
      $cancellable,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ( $rv, ppr($locale) )
  }

  method recalculate (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = e_data_book_cursor_recalculate($!edbc, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method register_gdbus_object (
    GDBusConnection()       $connection,
    Str()                   $object_path,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<register-gdbus-object>
  {
    clear_error;
    my $rv = e_data_book_cursor_register_gdbus_object(
      $!edbc,
      $connection,
      $object_path,
      $error
    );
    set_error($error);

    $rv;
  }

  method set_alphabetic_index (
    Int()                   $index,
    Str()                   $locale,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<set-alphabetic-index>
  {
    my gint $i = $index;

    clear_error;
    my $rv = e_data_book_cursor_set_alphabetic_index(
      $!edbc,
      $i,
      $locale,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_sexp (
    Str()                   $sexp,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<set-sexp>
  {
    clear_error;
    my $rv = e_data_book_cursor_set_sexp($!edbc, $sexp, $cancellable, $error);
    set_error($error);
    $rv;
  }

  multi method step (
    Str()                    $revision_guard,
    Int()                    $flags,
    Int()                    $origin,
    Int()                    $count,
    CArray[Pointer[GError]]  $error           = gerror,
    GCancellable()          :$cancellable     = GCancellable,
                            :$raw             = False,
                            :$glist           = False

  ) {
    (my $r = CArray[GSList].new)[0] = GSList;

    samewith(
      $revision_guard,
      $flags,
      $origin,
      $count,
      $r,
      $error,
      :all,
      :$raw,
      :$glist
    );
  }
  multi method step (
    Str()                    $revision_guard,
    Int()                    $flags,
    Int()                    $origin,
    Int()                    $count,
    CArray[GSList]           $results,
    GCancellable()           $cancellable     = GCancellable,
    CArray[Pointer[GError]]  $error           = gerror,
                            :$all             = False,
                            :$raw             = False,
                            :$glist           = False
  ) {
    my EBookCursorStepFlags $f = $flags;
    my EBookCursorOrigin    $o = $origin;
    my gint                 $c = $count;

    clear_error;
    my $nc = e_data_book_cursor_step(
      $!edbc,
      $revision_guard,
      $f,
      $o,
      $c,
      $flags +& E_BOOK_CURSOR_STEP_FETCH ?? $results !! CArray[GSList],
      $cancellable,
      $error
    );
    set_error($error);

    $all.not ?? $nc
             !! (
                  $nc,
                  returnGList(ppr($results), $raw, $glist, Str)
                );
  }

}
