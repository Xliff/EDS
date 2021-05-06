use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Client::Cursor;

use GLib::GList;
use GLib::Value;
use Evolution::Book::Client;

use GLib::Roles::Object;
use GLib::Roles::Signals::Generic;
use GIO::Roles::Initable;

our subset EBookClientCursorAncestry is export of Mu
  where EBookClientCursor | GInitable | GObject;

class Evolution::Book::Client::Cursor {
  also does GLib::Roles::Object;
  also does GLib::Roles::Signals::Generic;
  also does GIO::Roles::Initable;

  has EBookClientCursor $!ebcc;

  submethod BUILD (:$book-client-cursor, :$init, :$cancellable) {
    self.setEBookClientCursor($book-client-cursor, :$init, :$cancellable)
      if $book-client-cursor ;
  }

  method setEBookClientCursor (EBookClientCursorAncestry $_, :$init, :$cancellable) {
    my $to-parent;

    $!ebcc = do {
      when EBookClientCursor {
        $to-parent = cast(EClient, $_);
        $_;
      }

      when GInitable {
        $to-parent = cast(GObject, $_);
        $!i = $_;
        cast(ESource, $_);
      }

      default {
        $to-parent = $_;
        cast(EBookClientCursor, $_);
      }
    }
    self.setEClient($to-parent);
    self.roleInit-GInitable(:$init, :$cancellable);
    self.roleInit-AsyncInitable;
  }

  method Evolution::Raw::Definitions::EBookClientCursor
  { $!ebcc }

  multi method new (
    EBookClientCursorAncestry $book-client-cursor,
                              :$ref                = True
  ) {
    return Nil unless $book-client-cursor ;

    my $o = self.bless( :$book-client-cursor  );
    $o.ref if $ref;
    $o;
  }

  # Type: GStrv
  # According to the following:
  #   https://stackoverflow.com/questions/61308780/how-to-convert-a-glib-value-of-type-gstrv-string-to-a-glib-variant
  # GStrv is a boxed type, we'll try that, first.
  method alphabet (:$raw = False) is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('alphabet', $gv)
        );

        my $o = cast(CArray[Str], $gv.boxed);
        return $o if $raw;

        CStringArrayToArray($o)
      },
      STORE => -> $,  $val is copy {
        warn 'alphabet does not allow writing'
      }
    );
  }

  # Type: EBookClientCursor
  method client (:$raw = False) is rw  {
    my $gv = GLib::Value.new( Evolution::Book::Client.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('client', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          EBookClientCursor,
          Evolution::Book::Client
        );
      },
      STORE => -> $,  $val is copy {
        warn 'client is a construct-only attribute'
      }
    );
  }

  # Type: gint
  method position is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('position', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'position does not allow writing'
      }
    );
  }

  # Type: gint
  method total is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('total', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'total does not allow writing'
      }
    );
  }

  # Is originally:
  # EBookClientCursor, gpointer --> void
  method refresh {
    self.connect($!ebcc, 'refresh');
  }

  proto method get_alphabet (|)
  { * }

  multi method get_alphabet {
    samewith($, $, $, $, :all);
  }
  multi method get_alphabet (
    $n_labels  is rw,
    $underflow is rw,
    $inflow    is rw,
    $overflow  is rw,
    :$all      =  False
  ) {
    my gint ($n, $u, $i, $o) = 0 xx 4;
    my $a = e_book_client_cursor_get_alphabet($!ebcc, $n, $u, $i, $o);

    ($n_labels = $n, $underflow = $u, $inflow = $i, $overflow = $o);

    return $a unless $all;

    ($a, $n_labels, $underflow, $inflow, $overflow);
  }

  method get_contact_alphabetic_index (EContact() $contact) {
    e_book_client_cursor_get_contact_alphabetic_index($!ebcc, $contact);
  }

  method get_position {
    e_book_client_cursor_get_position($!ebcc);
  }

  method get_total {
    e_book_client_cursor_get_total($!ebcc);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_book_client_cursor_get_type, $n, $t );
  }

  method ref_client (:$raw = False) {
    my $c = e_book_client_cursor_ref_client($!ebcc);

    $c ??
      ( $raw ?? $c !! Evolution::Book::Client.new($c, :!ref) )
      !!
      Nil;
  }

  proto method set_alphabetic_index (|)
  { * }

  multi method set_alphabetic_index (
    Int()        $index,
                 &callback,
    gpointer     $user_data    = gpointer,
    GCancellable :$cancellable = GCancellable
  ) {
    samewith($index, $cancellable, &callback, $user_data);
  }
  multi method set_alphabetic_index (
    Int()        $index,
    GCancellable $cancellable,
                 &callback,
    gpointer     $user_data = gpointer
  ) {
    my gint $i = $index;

    e_book_client_cursor_set_alphabetic_index(
      $!ebcc,
      $index,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method set_alphabetic_index_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so e_book_client_cursor_set_alphabetic_index_finish(
      $!ebcc,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_alphabetic_index_sync (
    Int()                   $index,
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my gint $i = $index;

    so e_book_client_cursor_set_alphabetic_index_sync(
      $!ebcc,
      $i,
      $cancellable,
      $error
    );
  }

  proto method set_sexp (|)
  { * }

  multi method set_sexp (
    Str()          $sexp,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $sexp,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method set_sexp (
    Str()          $sexp,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    e_book_client_cursor_set_sexp(
      $!ebcc,
      $sexp,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method set_sexp_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_book_client_cursor_set_sexp_finish($!ebcc, $result, $error);
    set_error($error);
    $rv;
  }

  method set_sexp_sync (
    Str()                   $sexp,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_book_client_cursor_set_sexp_sync(
      $!ebcc,
      $sexp,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method step (|)
  { * }

  multi method step (
    Int()        $count,
                 &callback,
    gpointer     $user_data   = gpointer,
    Int()        $flags       = E_BOOK_CURSOR_STEP_MOVE,
    Int()        $origin      = E_BOOK_CURSOR_ORIGIN_BEGIN,
    GCancellable $cancellable = GCancellable
  ) {
    samewith(
      $flags,
      $origin,
      $count,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method step (
    Int()        $flags,
    Int()        $origin,
    Int()        $count,
    GCancellable $cancellable,
                 &callback,
    gpointer     $user_data
  ) {
    my EBookCursorStepFlags $f = $flags;
    my EBookCursorOrigin    $o = $origin;
    my gint                 $c = $count;

    e_book_client_cursor_step(
      $!ebcc,
      $f,
      $o,
      $c,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method step_finish (|)
  { * }

  multi method step_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$glist  = False,
                            :$raw    = False
  ) {
    (my $oc = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    my ($rv, $cl) = samewith($result, $oc, $error, :all);

    return Nil unless $rv;

    returnGList(
      $cl,
      $glist,
      $raw,
      EContact,
      Evolution::Contact
    );
  }
  multi method step_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GSList]] $out_contacts,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False

  ) {
    clear_error;
    my $rv = e_book_client_cursor_step_finish(
      $!ebcc,
      $result,
      $out_contacts,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_contacts) );
  }

  proto method step_sync (|)
  { * }

  multi method step_sync (
    Int()                   $flags,
    Int()                   $origin,
    Int()                   $count,
    CArray[Pointer[GError]] $error         = gerror,
    GCancellable            :$cancellable  = GCancellable,
                            :$glist        = False,
                            :$raw          = False
  ) {
    (my $oc = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    my ($n, $cl) = samewith(
      $flags,
      $origin,
      $count,
      $oc,
      $cancellable,
      $error,
      :all
    );

    return Nil if $n == -1;

    # List return,
    (
      $n,
      returnGList(
        $cl,
        $glist,
        $raw,
        EContact,
        Evolution::Contact
      )
    )
  }
  multi method step_sync (
    Int()                   $flags,
    Int()                   $origin,
    Int()                   $count,
    CArray[Pointer[GSList]] $out_contacts,
    GCancellable            $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False
  ) {
    my EBookCursorStepFlags $f = $flags;
    my EBookCursorOrigin    $o = $origin;
    my gint                 $c = $count;

    clear_error;
    my $n = e_book_client_cursor_step_sync(
      $!ebcc,
      $f,
      $o,
      $c,
      $out_contacts,
      $cancellable,
      $error
    );
    set_error($error);

    ( $n, ppr($out_contacts) );
  }


}
