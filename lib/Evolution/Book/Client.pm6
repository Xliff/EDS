use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Client;

use GLib::GList;
use Evolution::Client;
#use Evolution::Contact;

our subset EBookClientAncestry is export of Mu
  where EBookClient | EClient;

class Evolution::Book::Client is Evolution::Client {
  has EBookClient $!ebc;

  submethod BUILD (:$book-client ) {
    self.setEBookClient($book-client ) if $book-client ;
  }

  method setEBookClient (EBookClientAncestry $_) {
    my $to-parent;

    $!ebc = do {
      when EBookClient {
        $to-parent = cast(EClient, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBookClient, $_);
      }
    }
    self.setEClient($to-parent);
  }

  method Evolution::Raw::Definitions::EBookClient
  { $!ebc }

  multi method new (EBookClientAncestry $book-client, :$ref = True) {
    return Nil unless $book-client ;

    my $o = self.bless( :$book-client  );
    $o.ref if $ref;
    $o;
  }
  multi method new (ESource() $source, CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $book-client = e_book_client_new($source, $error);
    set_error($error);

    $book-client ?? self.bless( :$book-client ) !! Nil;
  }

  proto method add_contact (|)
  { * }

  multi method add_contact (
    EContact()     $contact,
                   &callback,
    gpointer       $user_data    = gpointer,
    Int()          :$opflags     = 0,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $contact,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method add_contact (
    EContact()     $contact,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_book_client_add_contact(
      $!ebc,
      $contact,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method add_contact_finish (|)
  { * }

  multi method add_contact_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    (my $oau = CArray[Str].new)[0] = Str;

    my ($rv, $out_added_uid) = samewith(
      $result,
      $oau,
      $error,
      :all
    );

    return Nil unless $rv;

    return $out_added_uid;
  }

  multi method add_contact_finish (
    GAsyncResult()          $result,
    CArray[Str]             $out_added_uid,
    CArray[Pointer[GError]] $error          = gerror,
                            :$all           = False
  ) {
    clear_error;
    my $rv = so e_book_client_add_contact_finish(
      $!ebc,
      $result,
      $out_added_uid,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ($rv, ppr($out_added_uid) );
  }

  proto method add_contact_sync (|)
  { * }

  multi method add_contact_sync (
    EContact()              $contact,
    CArray[Pointer[GError]] $error          = gerror,
    Int()                   :$opflags       = 0,
    GCancellable()          :$cancellable   = GCancellable
  ) {
    (my $ou = CArray[Str].new)[0] = Str;

    my ($rv, $out_uid) = samewith(
      $contact,
      $opflags,
      $ou,
      $cancellable,
      $error,
      :all
    );

    return Nil unless $rv;

    return $out_uid;
  }
  multi method add_contact_sync (
    EContact()              $contact,
    Int()                   $opflags,
    CArray[Str]             $out_added_uid,
    GCancellable()          $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error          = gerror,
                            :$all           = False
  ) {
    my guint32 $o = $opflags;

    my $rv = e_book_client_add_contact_sync(
      $!ebc,
      $contact,
      $o,
      $out_added_uid,
      $cancellable,
      $error
    );

    return $rv unless $all;

    ( $rv, ppr($out_added_uid) );
  }

  proto method add_contacts (|)
  { * }

  multi method add_contacts (
    GSList()       $contacts,
                   &callback,
    gpointer       $user_data    = gpointer,
    Int()          :$opflags     = 0,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $contacts,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method add_contacts (
    GSList()       $contacts,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_book_client_add_contacts(
      $!ebc,
      $contacts,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method add_contacts_finish (|)
  { * }

  multi method add_contacts_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$glist  = False,
                            :$raw    = False
  ) {
    (my $oau = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my ($rv, $aul) = samewith(
      $result,
      $oau,
      $error
    );

    return Nil unless $rv;

    returnGList($aul, $glist, $raw);
  }
  multi method add_contacts_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GSList]] $out_added_uids,
    CArray[Pointer[GError]] $error           = gerror,
                            :$all            = False
  ) {
    clear_error;
    my $rv = e_book_client_add_contacts_finish(
      $!ebc,
      $result,
      $out_added_uids,
      $error
    );

    return $rv unless $all;

    ( $rv, ppr($out_added_uids) );
  }

  proto method add_contacts_sync (|)
  { * }

  multi method add_contacts_sync (
    GSList()                $contacts,
    CArray[Pointer[GError]] $error            = gerror,
    Int()                   :$opflags         = 0,
    GCancellable()          :$cancellable     = GCancellable,
                            :$glist           = False,
                            :$raw             = False
  ) {
    (my $oau = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my ($rv, $aul) = samewith(
      $contacts,
      $opflags,
      $oau,
      $cancellable,
      $error,
      :all
    );

    return Nil unless $rv;

    returnGList($aul, $glist, $raw);
  }
  multi method add_contacts_sync (
    GSList()                $contacts,
    Int()                   $opflags,
    CArray[Pointer[GSList]] $out_added_uids,
    GCancellable()          $cancellable     = GCancellable,
    CArray[Pointer[GError]] $error           = gerror,
                            :$all
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = e_book_client_add_contacts_sync(
      $!ebc,
      $contacts,
      $o,
      $out_added_uids,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_added_uids) );
  }

  multi method connect (
    Evolution::Book::Client:U:

    ESource()      $source,
                   &callback,
    gpointer       $user_data                          = gpointer,
    Int()          :wait(
                     :wait-for-connected-seconds(
                       :$wait_for_connected_seconds
                     )
                   )                                   = -1,
    GCancellable() :$cancellable                       = GCancellable
  ) {
    samewith(
      $source,
      $wait_for_connected_seconds,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method connect (
    Evolution::Book::Client:U:
    ESource()                  $source,
    Int()                      $wait_for_connected_seconds,
    GCancellable()             $cancellable,
                               &callback,
    gpointer                   $user_data
  ) {
    my guint32 $w = $wait_for_connected_seconds;

    e_book_client_connect($source, $w, $cancellable, &callback, $user_data);
  }

  proto method connect_direct (|)
  { * }

  multi method connect_direct (
    Evolution::Book::Client:U:

    ESource()      $source,
                   &callback,
    gpointer       $user_data                          = gpointer,
    Int()          :wait(
                     :wait-for-connected-seconds(
                       :$wait_for_connected_seconds
                     )
                   )                                   = -1,
    GCancellable() :$cancellable                       = GCancellable
  ) {
    samewith(
      $source,
      $wait_for_connected_seconds,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method connect_direct (
    Evolution::Book::Client:U:
    ESource                    $source,
    Int()                      $wait_for_connected_seconds,
    GCancellable()             $cancellable,
                               &callback,
    gpointer                   $user_data                   = gpointer
  ) {
    my guint32 $w = $wait_for_connected_seconds;

    e_book_client_connect_direct(
      $source,
      $w,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method connect_direct_finish (
    Evolution::Book::Client:U:
    GAsyncResult()             $result,
    CArray[Pointer[GError]]    $error   = gerror,
                               :$raw    = False
  ) {
    clear_error;
    my $ebc = e_book_client_connect_direct_finish($result, $error);
    set_error($error);

    $ebc ??
      ( $raw ?? $ebc !! Evolution::Book::Client.new($ebc) )
      !!
      Nil;
  }

  method connect_direct_sync (
    Evolution::Book::Client:U:
    ESourceRegistry()          $registry,
    ESource()                  $source,
    Int()                      $wait_for_connected_seconds = -1,
    GCancellable               $cancellable                = GCancellable,
    CArray[Pointer[GError]]    $error                      = gerror,
                               :$raw                       = False
  ) {
    my guint32 $w = $wait_for_connected_seconds;

    clear_error;
    my $ebc = e_book_client_connect_direct_sync(
      $registry,
      $source,
      $w,
      $cancellable,
      $error
    );
    set_error($error);

    $ebc ??
      ( $raw ?? $ebc !! Evolution::Book::Client.new($ebc) )
      !!
      Nil;
  }

  method connect_finish (
    Evolution::Book::Client:U:
    GAsyncResult()             $result,
    CArray[Pointer[GError]]    $error = gerror
  ) {
    clear_error;
    my $rv = so e_book_client_connect_finish($result, $error);
    set_error($error);
    $rv;
  }

  method connect_sync (
    Evolution::Book::Client:U:
    ESource()                  $source,
    Int()                      $wait_for_connected_seconds  = -1,
    GCancellable()             $cancellable                 = GCancellable,
    CArray[Pointer[GError]]    $error                       = gerror,
                               :$raw                        = False
  ) {
    my guint32 $w = $wait_for_connected_seconds;

    clear_error;
    my $ec = e_book_client_connect_sync($source, $w, $cancellable, $error);
    set_error($error);

    $ec ??
      ( $raw ?? $ec !! Evolution::Book::Client.new($ec) )
      !!
      Nil;
  }

  proto method get_contact (|)
  { * }

  multi method get_contact (
    Str()          $uid,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($uid, $cancellable, &callback, $user_data);
  }
  multi method get_contact (
    Str()          $uid,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_book_client_get_contact($!ebc, $uid, $cancellable, &callback, $user_data);
  }

  proto method get_contact_finish (|)
  { * }

  multi method get_contact_finish (
    GAsyncResult()            $result,
    CArray[Pointer[GError]]   $error        = gerror,
                              :$raw         = False
  ) {
    (my $oc = CArray[Pointer[EContact]].new)[0] = Pointer[EContact];

    my ($rv, $c) = samewith($result, $oc, $error, :all);

    return Nil unless $rv;

    $c ??
      ( $raw ?? $c !! Evolution::Contact.new($c) )
      !!
      Nil;
  }
  multi method get_contact_finish (
    GAsyncResult()            $result,
    CArray[Pointer[EContact]] $out_contact,
    CArray[Pointer[GError]]   $error        = gerror,
                              :$all         = False
  ) {
    clear_error;
    my $rv = so e_book_client_get_contact_finish(
      $!ebc,
      $result,
      $out_contact,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_contact) );
  }

  proto method get_contact_sync (|)
  { * }

  multi method get_contact_sync (
    Str()                     $uid,
    GCancellable()            $cancellable = GCancellable,
    CArray[Pointer[GError]]   $error       = gerror,
                              :$raw        = False
  ) {
    (my $oc = CArray[Pointer[EContact]].new)[0] = Pointer[EContact];

     my ($rv, $c) = samewith(
       $uid,
       $oc,
       $cancellable,
       $error
     );

     return Nil unless $rv;

     $c ??
       ( $raw ?? $c !! Evolution::Contact.new($c) )
       !!
       Nil;
  }
  multi method get_contact_sync (
    Str()                     $uid,
    CArray[Pointer[EContact]] $out_contact,
    GCancellable()            $cancellable = GCancellable,
    CArray[Pointer[GError]]   $error       = gerror,
                              :$all        = False
  ) {
    clear_error;
    my $rv = so e_book_client_get_contact_sync(
      $!ebc,
      $uid,
      $out_contact,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_contact) );
  }

  proto method get_contacts (|)
  { * }

  multi method get_contacts (
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
  multi method get_contacts (
    Str()          $sexp,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data         = gpointer
  ) {
    e_book_client_get_contacts(
      $!ebc,
      $sexp,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_contacts_finish (|)
  { * }

  multi method get_contacts_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error         = gerror,
                            :$glist        = False,
                            :$raw          = False
  ) {
    (my $ocl = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    my ($rv, $cl) = samewith($result, $ocl, $error);

    return Nil unless $rv;

    returnGList($cl, $glist, $raw, EContact, Evolution::Contact);
  }
  multi method get_contacts_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GSList]] $out_contacts,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False
  ) {
    clear_error
    my $rv = e_book_client_get_contacts_finish(
      $!ebc,
      $result,
      $out_contacts,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_contacts) );
  }

  proto method get_contacts_sync (|)
  { * }

  multi method get_contacts_sync (
    Str()                   $sexp,
    CArray[Pointer[GError]] $error         = gerror,
    GCancellable()          :$cancellable  = GCancellable,
                            :$glist        = False,
                            :$raw          = False
  ) {
    (my $oc = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my ($rv, $cl) = samewith($sexp, $oc, $cancellable, $error);

    return Nil unless $rv;

    returnGList($cl, $glist, $raw, EContact, Evolution::Contact);
  }
  multi method get_contacts_sync (
    Str()                   $sexp,
    CArray[Pointer[GSList]] $out_contacts,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False
  ) {
    clear_error;
    my $rv = so e_book_client_get_contacts_sync(
      $!ebc,
      $sexp,
      $out_contacts,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_contacts) );
  }

  proto method get_contacts_uids (|)
  { * }

  multi method get_contacts_uids (
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
  multi method get_contacts_uids (
    Str()          $sexp,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_book_client_get_contacts_uids(
      $!ebc,
      $sexp,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_contacts_uids_finish (|)
  { * }

  multi method get_contacts_uids_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error             = gerror,
                            :$glist            = False,
                            :$raw              = False
  ) {
    (my $ocu = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];
    my ($rv, $cul) = samewith($result, $ocu, $error, :all);

    return Nil unless $rv;

    returnGList($cul, $glist, $raw);
  }
  multi method get_contacts_uids_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GSList]] $out_contact_uids,
    CArray[Pointer[GError]] $error             = gerror,
                            :$all              = False
  ) {
    clear_error;
    my $rv = so e_book_client_get_contacts_uids_finish(
      $!ebc,
      $result,
      $out_contact_uids,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_contact_uids) )
  }

  proto method get_contacts_uids_sync (|)
  { * }

  multi method get_contacts_uids_sync (
    Str()                   $sexp,
    GCancellable()          $cancellable       = GCancellable,
    CArray[Pointer[GError]] $error             = gerror,
                            :$glist            = False,
                            :$raw              = False
  ) {
    (my $ocu = CArray[Pointer[GSList]].new)[0] = Pointer[GSList];

    my ($rv, $cl) = samewith(
      $sexp,
      $ocu,
      $cancellable,
      $error,
      :all
    );

    returnGList($cl, $glist, $raw);
  }
  multi method get_contacts_uids_sync (
    Str()                   $sexp,
    CArray[Pointer[GSList]] $out_contact_uids,
    GCancellable()          $cancellable       = GCancellable,
    CArray[Pointer[GError]] $error             = gerror,
                            :$all              = False
  ) {
    my $rv = so e_book_client_get_contacts_uids_sync(
      $!ebc,
      $sexp,
      $out_contact_uids,
      $cancellable,
      $error
    );

    return $rv unless $all;

    ( $rv, ppr($out_contact_uids) );
  }

  proto method get_cursor (|)
  { * }

  # cw: Black. Lives. Matter.
  # Rest in peace, Ma'khia Bryant.
  # https://crooksandliars.com/2021/04/police-kill-15-year-old-girl-columbus-ohio
  multi method get_cursor (
    Str()                       $sexp,
                                @sort_fields,
                                @sort_types,
                                &callback,
    gpointer                    $user_data    = gpointer,
    GCancellable()              :$cancellable = GCancellable
  ) {
    samewith(
      $sexp,
      CArray[EContactField].new(@sort_fields),
      CArray[EBookCursorSortType].new(@sort_types),
      @sort_fields.elems,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method get_cursor (
    Str()                       $sexp,
    CArray[EContactField]       $sort_fields,
    CArray[EBookCursorSortType] $sort_types,
    Int()                       $n_fields,
    GCancellable()              $cancellable,
                                &callback,
    gpointer                    $user_data,
  ) {
    my guint $n = $n_fields;

    e_book_client_get_cursor(
      $!ebc,
      $sexp,
      $sort_fields,
      $sort_types,
      $n_fields,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_cursor_finish (|)
  { * }

  multi method get_cursor_finish (
    GAsyncResult()                     $result,
    CArray[Pointer[GError]]            $error       = gerror,
                                       :$raw        = False
  ) {
    (my $oc = CArray[Pointer[EBookClientCursor]].new)[0] =
      Pointer[EBookClientCursor];

    my ($rv, $ecc) = samewith($result, $oc, $error, :all);

    return Nil unless $rv;

    $ecc ??
      ( $raw ?? $ecc !! Evolution::Book::Client::Cursor.new($ecc) )
      !!
      Nil;
  }
  multi method get_cursor_finish (
    GAsyncResult()                     $result,
    CArray[Pointer[EBookClientCursor]] $out_cursor,
    CArray[Pointer[GError]]            $error       = gerror,
                                       :$all        = False
  ) {
    clear_error;
    my $rv = so e_book_client_get_cursor_finish(
      $!ebc,
      $result,
      $out_cursor,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_cursor) );
  }

  proto method get_cursor_sync (|)
  { * }

  multi method get_cursor_sync (
    Str()                   $sexp,
                            @sort_fields,
    Int()                   $sort_types,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False
  ) {
    (my $oc = CArray[Pointer[EBookClientCursor]].new)[0] =
      Pointer[EBookClientCursor];

    my ($rv, $ecc) = samewith(
      $sexp,
      CArray[EContactField].new(@sort_fields),
      $sort_types,
      @sort_fields.elems,
      $oc,
      $cancellable,
      $error,
      :all
    );

    return Nil unless $rv;

    $ecc ??
      ( $raw ?? $ecc !! Evolution::Book::Client::Cursor.new($ecc) )
      !!
      Nil;
  }
  multi method get_cursor_sync (
    Str()                              $sexp,
    CArray[EContactField]              $sort_fields,
    Int()                              $sort_types,
    Int()                              $n_fields,
    CArray[Pointer[EBookClientCursor]] $out_cursor,
    GCancellable()                     $cancellable,
    CArray[Pointer[GError]]            $error,
                                       :$all         = False
  ) {
    my EBookCursorSortType $s = $sort_types;
    my guint               $n = $n_fields;

    clear_error;
    my $rv = so e_book_client_get_cursor_sync(
      $!ebc,
      $sexp,
      $sort_fields,
      $s,
      $n,
      $out_cursor,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_cursor) );
  }

  method get_locale {
    e_book_client_get_locale($!ebc);
  }

  proto method get_self (|)
  { * }

  multi method get_self (
    Evolution::Book::Client:U:
    ESourceRegistry()          $registry,
    CArray[Pointer[GError]]    $error = gerror,
                               :$raw  = False
  ) {
    (my $oec = CArray[Pointer[EContact]].new)[0]    = Pointer[EContact];
    (my $oc  = CArray[Pointer[EBookClient]].new)[0] = Pointer[EBookClient];

    my ($rv, $ec, $cl) = samewith($registry, $oc, $oec, :all);

    $ec = $ec ??
      ( $raw ?? $ec !! Evolution::Contact.new($ec) )
      !!
      Nil;

    $cl = $cl ??
      ( $raw ?? $cl !! Evolution::Book::Client.new($cl) )
      !!
      Nil;

    $rv[0] ?? ($ec, $cl) !! Nil;
  }
  multi method get_self (
    Evolution::Book::Client:U:
    ESourceRegistry()            $registry,
    CArray[Pointer[EContact]]    $out_contact,
    CArray[Pointer[EBookClient]] $out_client,
    CArray[Pointer[GError]]      $error        = gerror,
                                 :$all         = False
  ) {
    clear_error;
    my $rv = so e_book_client_get_self(
      $registry,
      $out_contact,
      $out_client,
      $error
    );
    set_error($error);
    return $rv unless $all;

    ( $rv, ppr($out_contact), ppr($out_client) )
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_book_client_get_type, $n, $t );
  }

  proto method get_view (|)
  { * }

  multi method get_view (
    Str()        $sexp,
                 &callback,
    gpointer     $user_data    = gpointer,
    GCancellable :$cancellable = GCancellable
  ) {
    samewith($sexp, $cancellable, &callback, $user_data);
  }
  multi method get_view (
    Str()        $sexp,
    GCancellable $cancellable,
                 &callback,
    gpointer     $user_data = gpointer
  ) {
    so e_book_client_get_view($!ebc, $sexp, $cancellable, &callback, $user_data);
  }

  proto method get_view_finish (|)
  { * }

  multi method get_view_finish (
    GAsyncResult()                   $result,
    CArray[Pointer[GError]]          $error   = gerror,
                                     $raw     = False
  ) {
    (my $ov = CArray[Pointer[EBookClientView]])[0] = Pointer[EBookClientView];

    my ($rv, $v) = samewith(
      $result,
      $ov,
      $error,
      :all
    );

    return Nil unless $rv;

    $v ??
      ( $raw ?? $v !! Evolutino::Book::Client::View.new($v) )
      !!
      Nil
  }
  multi method get_view_finish (
    GAsyncResult()                   $result,
    CArray[Pointer[EBookClientView]] $out_view,
    CArray[Pointer[GError]]          $error     = gerror,
                                     :$all      = False
  ) {
    clear_error;
    my $rv = so e_book_client_get_view_finish($!ebc, $result, $out_view, $error);
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_view) )
  }

  proto method get_view_sync (|)
  { * }

  multi method get_view_sync (
    Str()                   $sexp,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False
  ) {
    (my $ov = CArray[Pointer[EBookClientView]].new)[0] =
      Pointer[EBookClientView];

    my ($rv, $v) = samewith(
      $sexp,
      $ov,
      $cancellable,
      $error,
      :all
    );

    return Nil unless $rv;

    $v ??
      ( $raw ?? $v !! Evolution::Book::Client::View.new($v) )
      !!
      Nil;
  }
  multi method get_view_sync (
    Str()                            $sexp,
    CArray[Pointer[EBookClientView]] $out_view,
    GCancellable()                   $cancellable,
    CArray[Pointer[GError]]          $error,
                                     :$all         = False
  ) {
    my $rv = so e_book_client_get_view_sync(
      $!ebc,
      $sexp,
      $out_view,
      $cancellable,
      $error
    );

    return $rv unless $all;

    ( $rv, ppr($out_view) )
  }

  method is_self (
    Evolution::Book::Client:U:
    EContact()                 $contact
  ) {
    so e_book_client_is_self($contact);
  }

  proto method modify_contact (|)
  { * }

  multi method modify_contact (
    EContact()     $contact,
                   &callback,
    gpointer       $user_data     = gpointer,
    Int()          :$opflags      = 0,
    GCancellable() :$cancellable  = GCancellable
  ) {
    samewith(
      $contact,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method modify_contact (
    EContact()     $contact,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my guint32 $o = $opflags;

    e_book_client_modify_contact(
      $!ebc,
      $contact,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method modify_contact_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error
    my $rv = so e_book_client_modify_contact_finish($!ebc, $result, $error);
    set_error($error);
    $rv;
  }

  method modify_contact_sync (
    EContact()              $contact,
    Int()                   $opflags     = 0,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_book_client_modify_contact_sync(
      $!ebc,
      $contact,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method modify_contacts (|)
  { * }

  multi method modify_contacts (
                   @contacts,
                   &callback,
    gpointer       $user_data    = gpointer,
    Int()          :$opflags     = 0,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      GLib::GSList.new(@contacts),
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method modify_contacts (
    GSList()       $contacts,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_book_client_modify_contacts(
      $!ebc,
      $contacts,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method modify_contacts_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_book_client_modify_contacts_finish($!ebc, $result, $error);
    set_error($error);
    $rv;
  }

  proto method modify_contacts_sync (|)
  { * }

  multi method modify_contacts_sync (
                            @contacts,
    CArray[Pointer[GError]] $error        = gerror,
    Int()                   :$opflags     = 0,
    GCancellable            :$cancellable = GCancellable
  ) {
    samewith(
      GLib::GSList.new(@contacts, typed => EContact),
      $opflags,
      $cancellable,
      $error
    );
  }
  multi method modify_contacts_sync (
    GSList()                $contacts,
    Int()                   $opflags     = 0,
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_book_client_modify_contacts_sync(
      $!ebc,
      $contacts,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method remove_contact (|)
  { * }

  multi method remove_contact (
    EContact()     $contact,
                   &callback,
    gpointer       $user_data    = gerror,
    Int()          :$opflags     = 0,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($contact, $opflags, $cancellable, &callback, $user_data);
  }
  multi method remove_contact (
    EContact()     $contact,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_book_client_remove_contact(
      $!ebc,
      $contact,
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method remove_contact_by_uid (|)
  { * }

  multi method remove_contact_by_uid (
    Str()          $uid,
                   &callback,
    gpointer       $user_data    = gpointer,
    Int()          :$opflags     = 0,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($uid, $opflags, $cancellable, &callback, $user_data);
  }
  multi method remove_contact_by_uid (
    Str()          $uid,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my guint32 $o = $opflags;

    e_book_client_remove_contact_by_uid(
      $!ebc,
      $uid, $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method remove_contact_by_uid_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_book_client_remove_contact_by_uid_finish(
      $!ebc,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

  method remove_contact_by_uid_sync (
    Str()                   $uid,
    Int()                   $opflags     = 0,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_book_client_remove_contact_by_uid_sync(
      $!ebc,
      $uid,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method remove_contact_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_book_client_remove_contact_finish($!ebc, $result, $error);
    set_error($error);
    $rv;
  }

  method remove_contact_sync (
    EContact()              $contact,
    Int()                   $opflags      = 0,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = e_book_client_remove_contact_sync(
      $!ebc,
      $contact,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method remove_contacts (|)
  { * }

  multi method remove_contacts (
                   @uids,
                   &callback,
    gpointer       $user_data    = gpointer,
    Int()          :$opflags     = 0,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      GLib::GSList.new(@uids),
      $opflags,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method remove_contacts (
    GSList()       $uids,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    so e_book_client_remove_contacts(
      $!ebc,
      $uids,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method remove_contacts_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_book_client_remove_contacts_finish($!ebc, $result, $error);
    set_error($error);
    $rv;
  }

  proto method remove_contacts_sync (|)
  { * }

  multi method remove_contacts_sync (
                            @uids,
    CArray[Pointer[GError]] $error        = gerror,
    Int()                   :$opflags     = 0,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith( GLib::GSList.new(@uids), $opflags, $cancellable, $error);
  }
  multi method remove_contacts_sync (
    GSList()                $uids,
    Int()                   $opflags     = 0,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my guint32 $o  = $opflags;

    clear_error;
    my $rv = so e_book_client_remove_contacts_sync(
      $!ebc,
      $uids,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_self (EContact() $contact, CArray[Pointer[GError]] $error) {
    clear_error;
    my $rv = so e_book_client_set_self($!ebc, $contact, $error);
    set_error($error);
    $rv;
  }

}
