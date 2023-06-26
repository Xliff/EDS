
use v6.c;

use Method::Also;
use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Backend;

use GLib::GList;
use GLib::Queue;
use Evolution::Backend;
use Evolution::Contact;
use Evolution::Data::Book;
use Evolution::Data::Book::View;
use Evolution::Data::Book::Cursor;

use GLib::Roles::TypedQueue0;
use GIO::Roles::ProxyResolver;

our subset EBookBackendAncestry is export of Mu
  where EBookBackend | EBackendAncestry;

class Evolution::Book::Backend is Evolution::Backend {
  has EBookBackend $!ebb is implementor;

  submethod BUILD (:$e-book-backend) {
    self.setEBookBackend($e-book-backend) if $e-book-backend;
  }

  method setEBookBackend (EBookBackendAncestry $_) {
    my $to-parent;

    $!ebb = do {
      when EBookBackend {
        $to-parent = cast(EBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBookBackend, $_);
      }
    }
    self.setEBackend($to-parent);
  }

  method Evolution::Raw::Structs::EBookBackend
    is also<EBookBackend>
  { $!ebb }

  multi method new (EBookBackendAncestry $e-book-backend, :$ref = True) {
    return Nil unless $e-book-backend;

    my $o = self.bless( :$e-book-backend );
    $o.ref if $ref;
    $o;
  }

  method add_view (EDataBookView() $view) is also<add-view> {
    e_book_backend_add_view($!ebb, $view);
  }

  method configure_direct (Str() $config) is also<configure-direct> {
    e_book_backend_configure_direct($!ebb, $config);
  }

  proto method create_contacts (|)
    is also<create-contacts>
  { * }

  multi method create_contacts (
                  @vcards,
                  &callback,
    gpointer      $user_data       = gpointer,
    GCancellable :$cancellable     = GCancellable,
    guint32      :flags(:$opflags) = 0
  ) {
    samewith(
      ArrayToCArray(Str, @vcards),
      $opflags,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method create_contacts (
    CArray[Str]    $vcards,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_book_backend_create_contacts(
      $!ebb,
      $vcards,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method create_contacts_finish (|)
    is also<create-contacts-finish>
  { * }

  multi method create_contacts_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error         = gerror,
                            :$raw          = False,
                            :$glist        = False,
                            :$queue        = False
  ) {
    my $q  = GQueue.new;

    my $rv = samewith(
      $result,
      $q,
      $error,
      raw => $queue ?? $raw !! False,
      :all
    );

    my $ra = $rv[0] ?? $rv[1] !! Nil;
    return unless $ra;
    return $ra if $queue;

    $ra does GLib::Roles::TypedQueue0[
      $raw,
      $glist,
      |Evolution::Contact.getTypePair
    ];

    $ra.Array;
  }

  multi method create_contacts_finish (
    GAsyncResult()          $result,
    GQueue()                $out_contacts,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False,
                            :$raw          = False
  ) {
    clear_error;
    my $rv = e_book_backend_create_contacts_finish(
      $!ebb,
      $result,
      $out_contacts,
      $error
    );
    set_error($error);

    my $q;
    $q = propReturnObject($out_contacts, $raw, |GLib::Queue.getTypePair)
      if $rv;

    $all.not ?? $rv !! ($rv, $q);
  }

  proto method create_contacts_sync (|)
    is also<create-contacts-sync>
  { * }

  multi method create_contacts_sync (
                            @vcards,
    CArray[Pointer[GError]] $error        = gerror,
    Int()                   :$opflags     = 0,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False,
                            :$glist       = False,
                            :$queue       = False
  ) {
    my $q = GQueue.new;

    my $rv = samewith(
      ArrayToCArray(Str, @vcards),
      $opflags,
      $q,
      $cancellable,
      $error,
      raw => $queue ?? $raw !! False,
      :all
    );

    my $ra = $rv[0] ?? $rv[1] !! Nil;
    return     unless $rv[0];
    return $ra if     $queue;

    $ra does GLib::Roles::TypedQueue0[
      $raw,
      $glist,
      |Evolution::Contact.getTypePair
    ];

    $ra.Array;
  }
  multi method create_contacts_sync (
    CArray[Str]             $vcards,
    Int()                   $opflags,
    GQueue()                $out_contacts,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False,
                            :$raw          = False
  ) {
    clear_error;
    my $rv = e_book_backend_create_contacts_sync(
      $!ebb,
      $vcards,
      $opflags,
      $out_contacts,
      $cancellable,
      $error
    );
    set_error($error);

    my $q;
    $q = propReturnObject($out_contacts, $raw, |GLib::Queue.getTypePair)
      if $rv;

    $all.not ?? $rv !! ($rv, $q);
  }

  proto method create_cursor (|)
    is also<create-cursor>
  { * }

  multi method create_cursor (
                            @sort_fields, #= Array of EContactField
    Int()                   $sort_types,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    samewith(
      GLib::Roles::TypedBuffer[EContactField].new(@sort_fields).p,
      $sort_types,
      @sort_fields.elems,
      $error
    )
  }
  multi method create_cursor (
    Pointer                  $sort_fields, #= Array of EContactField
    Int()                    $sort_types,
    Int()                    $n_fields,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$raw          = False
  ) {
    my guint               $n = $n_fields;
    my EBookCursorSortType $s = $sort_types;

    clear_error;
    my $bc = e_book_backend_create_cursor($!ebb, $sort_fields, $s, $n, $error);
    set_error($error);

    propReturnObject($bc, $raw, |Evolution::Data::Book::Cursor.getTypePair);
  }

  method delete_cursor (
    EDataBookCursor()       $cursor,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<delete-cursor>
  {
    clear_error;
    e_book_backend_delete_cursor($!ebb, $cursor, $error);
    set_error($error);
  }

  method dup_cache_dir is also<dup-cache-dir> {
    e_book_backend_dup_cache_dir($!ebb);
  }

  method dup_locale is also<dup-locale> {
    e_book_backend_dup_locale($!ebb);
  }

  method foreach_view (&func, gpointer $user_data = gpointer)
    is also<foreach-view>
  {
    e_book_backend_foreach_view($!ebb, &func, $user_data);
  }

  method foreach_view_notify_progress (
    Int() $only_completed_views,
    Int() $percent,
    Str() $message
  )
    is also<foreach-view-notify-progress>
  {
    my gboolean $o = $only_completed_views.so.Int;
    my gint     $p = $percent;

    e_book_backend_foreach_view_notify_progress($!ebb, $o, $p, $message);
  }

  method get_backend_property (Str() $prop_name)
    is also<get-backend-property>
  {
    my $sv = e_book_backend_get_backend_property($!ebb, $prop_name);
    my $r  = $sv;
    #g_free($sv);
    $r;
  }

  method get_cache_dir is also<get-cache-dir> {
    e_book_backend_get_cache_dir($!ebb);
  }

  proto method get_contact (|)
    is also<get-contact>
  { * }

  multi method get_contact (
    Str()           $uid,
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($uid, $cancellable, &callback, $user_data);
  }
  multi method get_contact (
    Str()          $uid,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data,
                   :$raw         = False
  ) {
    propReturnObject(
      e_book_backend_get_contact(
        $!ebb,
        $uid,
        $cancellable,
        &callback,
        $user_data
      ),
      :$raw,
      |Evolution::Contact.getTypePair
    );
  }

  method get_contact_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<get-contact-finish>
  {
    clear_error();
    e_book_backend_get_contact_finish($!ebb, $result, $error);
    set_error($error);
  }

  proto method get_contact_list (|)
    is also<get-contact-list>
  { * }

  multi method get_contact_list (
    Str()           $query,
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $query,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method get_contact_list (
    Str()          $query,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_book_backend_get_contact_list(
      $!ebb,
      $query,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_contact_list_finish (|)
    is also<get-contact-list-finish>
  { * }

  multi method get_contact_list_finish (
  GAsyncResult()          $result,
  CArray[Pointer[GError]] $error         = gerror,
                          :$raw          = False,
                          :$glist        = False,
                          :$queue        = False
  ) {
    my $q  = GQueue.new;
    my $rv = samewith(
      $result,
      $q,
      $error,
      raw => $queue ?? $raw !! False,
      :all
    );
    my $r  = $rv[0] ?? $rv[1] !! Nil;

    return Nil unless $rv[0];
    return $r  if     $queue;

    $r does GLib::Roles::TypedQueue0[
      $raw,
      $glist,
      |Evolution::Contact.getTypePair
    ];

    $r.Array
  }
  multi method get_contact_list_finish (
    GAsyncResult()           $result,
    GQueue()                 $out_contacts,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$all           = False,
                            :$raw           = False
  ) {
    clear_error;
    my $rv = e_book_backend_get_contact_list_finish(
      $!ebb,
      $result,
      $out_contacts,
      $error
    );
    set_error($error);

    my $rq;
    $rq = propReturnObject($out_contacts, $raw, |GLib::Queue.getTypePair)
      if $rv;

    $all.not ?? $rv !! ($rv, $rq);
  }

  proto method get_contact_list_sync (|)
    is also<get-contact-list-sync>
  { * }

  multi method get_contact_list_sync (
    Str()                   $query,
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable,
                            :$raw         = False,
                            :$glist       = False,
                            :$queue       = False
  ) {
    my $q  = GQueue.new;
    my $rv = samewith(
      $query,
      $q,
      $cancellable,
      $error,
      raw => $queue ?? $raw !! False,
      :all
    );
    my $ra = $rv[0] ?? $rv[1] !! Nil;

    return     unless $ra;
    return $ra if     $queue;

    $ra does GLib::Roles::TypedQueue0[
      $raw,
      $glist,
      |Evolution::Contact.getTypePair
    ];

    $ra.Array;
  }
  multi method get_contact_list_sync (
    Str()                   $query,
    GQueue()                $out_contacts,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror,
                            :$all          = False,
                            :$raw          = False
  ) {
    clear_error;
    my $rv =e_book_backend_get_contact_list_sync(
      $!ebb,
      $query,
      $out_contacts,
      $cancellable,
      $error
    );
    set_error($error);

    my $q;
    $q = propReturnObject($out_contacts, $raw, |GLib::Queue.getTypePair)
      if $rv;

    $all.not ?? $rv !! ($rv, $q);
  }

  proto method get_contact_list_uids (|)
    is also<get-contact-list-uids>
  { * }

  multi method get_contact_list_uids (
    Str()           $query,
                    &callback,
    gpointer        $user_data,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($query, $cancellable, &callback, $user_data);
  }
  multi method get_contact_list_uids (
    Str()          $query,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    e_book_backend_get_contact_list_uids(
      $!ebb,
      $query,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_contact_list_uids_finish (|)
    is also<get-contact-list-uids-finish>
  { * }

  multi method get_contact_list_uids_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error     = gerror,
                            :$raw       = False,
                            :$glist     = False,
                            :$queue     = False
  ) {
    my $q  = GQueue.new;
    my $rv = samewith(
      $result,
      $q,
      $error,
      raw => $queue ?? $raw !! False,
      :all
    );

    return        unless $rv[0];
    return $rv[1] if     $queue;

    # cw: $raw is irrelevant for Str
    $rv[1] does GLib::Roles::TypedQueue0[False, $glist, Str];

    $q.Array;
  }
  multi method get_contact_list_uids_finish (
    GAsyncResult()           $result,
    GQueue()                 $out_uids,
    CArray[Pointer[GError]]  $error     = gerror,
                            :$all       = False,
                            :$raw       = False
  ) {
    my $rv = e_book_backend_get_contact_list_uids_finish(
      $!ebb,
      $result,
      $out_uids,
      $error
    );

    my $q;
    $q = propReturnObject($out_uids, $raw, |GLib::Queue.getTypePair) if $rv;

    $all.not ?? $rv !! ($rv, $q);
  }

  proto method get_contact_list_uids_sync (|)
    is also<get-contact-list-uids-sync>
  { * }

  multi method get_contact_list_uids_sync (
    Str()                    $query,
    CArray[Pointer[GError]]  $error        = gerror,
    GCancellable()          :$cancellable  = GCancellable,
                            :$raw          = False,
                            :$glist        = False,
                            :$queue        = False
  ) {
    my $q  = GQueue.new;
    my $rv = samewith($query, $q, $cancellable, $error, :all, :$raw);

    return        unless $rv[0];
    return $rv[1] if     $queue;

    # cw: $raw is irrelevant for Str
    $rv[1] does GLib::Roles::TypedQueue0[False, $glist, Str];

    $q.Array;
  }
  multi method get_contact_list_uids_sync (
    Str()                    $query,
    GQueue()                 $out_uids,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$all          = False,
                            :$raw          = False
  ) {
    clear_error;
    my $rv = e_book_backend_get_contact_list_uids_sync(
      $!ebb,
      $query,
      $out_uids,
      $cancellable,
      $error
    );
    set_error($error);

    my $q;
    $q = propReturnObject($out_uids, $raw, |GLib::Queue.getTypePair) if $rv;

    $all.not ?? $rv !! ($rv, $q);
  }

  method get_contact_sync (
    Str()                    $uid,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$raw         = False
  )
    is also<get-contact-sync>
  {
    clear_error
    my $c = e_book_backend_get_contact_sync($!ebb, $uid, $cancellable, $error);
    set_error($error);

    propReturnObject($c, $raw, |Evolition::Contact.getTypePair)
  }

  method get_direct_book is also<get-direct-book> {
    e_book_backend_get_direct_book($!ebb);
  }

  method get_registry is also<get-registry> {
    e_book_backend_get_registry($!ebb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_book_backend_get_type, $n, $t );
  }

  method get_writable is also<get-writable> {
    so e_book_backend_get_writable($!ebb);
  }

  method is_opened is also<is-opened> {
    so e_book_backend_is_opened($!ebb);
  }

  method is_readonly is also<is-readonly> {
    so e_book_backend_is_readonly($!ebb);
  }

  method list_views (:$raw = False, :$glist = False) is also<list-views> {
    returnGList(
      e_book_backend_list_views($!ebb),
      $raw,
      |Evolution::Data::Book::View.getTypePair
    )
  }

  proto method modify_contacts (|)
    is also<modify-contacts>
  { * }

  multi method modify_contacts (
                    @vcards,
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable,
    Int()          :$opflags     = 0
  ) {
    samewith(
      ArrayToCArray(Str, @vcards),
      $opflags,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method modify_contacts (
    CArray[Str]    $vcards,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my guint32 $o = $opflags;

    e_book_backend_modify_contacts(
      $!ebb,
      $vcards,
      $o,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method modify_contacts_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<modify-contacts-finish>
  {
    clear_error;
    my $rv = e_book_backend_modify_contacts_finish($!ebb, $result, $error);
    set_error($error);
    $rv;
  }

  proto method modify_contacts_sync (|)
    is also<modify-contacts-sync>
  { * }

  multi method modify_contacts_sync (
                             @vcards,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable,
    Int()                   :$opflags     = 0
  ) {
    samewith(
      ArrayToCArray(Str, @vcards),
      $opflags,
      $cancellable,
      $error
    );
  }
  multi method modify_contacts_sync (
    CArray[Str]             $vcards,
    Int()                   $opflags,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = e_book_backend_modify_contacts_sync(
      $!ebb,
      $vcards,
      $opflags,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method notify_complete is also<notify-complete> {
    e_book_backend_notify_complete($!ebb);
  }

  method notify_error (Str() $message) is also<notify-error> {
    e_book_backend_notify_error($!ebb, $message);
  }

  method notify_property_changed (Str() $prop_name, Str() $prop_value)
    is also<notify-property-changed>
  {
    e_book_backend_notify_property_changed($!ebb, $prop_name, $prop_value);
  }

  method notify_remove (Str() $id) is also<notify-remove> {
    e_book_backend_notify_remove($!ebb, $id);
  }

  method notify_update (EContact() $contact) is also<notify-update> {
    e_book_backend_notify_update($!ebb, $contact);
  }

  method open (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_book_backend_open($!ebb, $cancellable, &callback, $user_data);
  }

  method open_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<open-finish>
  {
    clear_error;
    my $rv = e_book_backend_open_finish($!ebb, $result, $error);
    set_error($error);
    $rv;
  }

  method open_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<open-sync>
  {
    clear_error;
    my $rv = e_book_backend_open_sync($!ebb, $cancellable, $error);
    set_error($error);
    $rv;
  }

  # cw: Not a part of the public API, as per:
  # https://developer-old.gnome.org/eds/stable/EBookBackend.html#e-book-backend-prepare-for-completion
  #
  # method prepare_for_completion (
  #   Int()          $opid,
  #   CArray[GQueue] $result_queue
  # ) {
  #   my guint32 $o = $opid;
  #   e_book_backend_prepare_for_completion($!ebb, $opid, $result_queue);
  # }

  method ref_data_book ( :$raw = False ) is also<ref-data-book> {
    propReturnObject(
      e_book_backend_ref_data_book($!ebb),
      $raw,
      |Evolution::Data::Book.getTypePair
    );
  }

  method ref_proxy_resolver ( :$raw = False ) is also<ref-proxy-resolver> {
    propReturnObject(
      e_book_backend_ref_proxy_resolver($!ebb),
      $raw,
      |GIO::ProxyResolver.getTypePair
    );
  }

  multi method refresh (
                    &callback,
    gpointer        $user_data    = gpointer,
    GCancellable() :$cancellable,
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method refresh (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_book_backend_refresh($!ebb, $cancellable, &callback, $user_data);
  }

  method refresh_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<refresh-finish>
  {
    clear_error;
    my $rv = e_book_backend_refresh_finish($!ebb, $result, $error);
    set_error($error);
    $rv.so;
  }

  method refresh_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<refresh-sync>
  {
    clear_error;
    my $rv = e_book_backend_refresh_sync($!ebb, $cancellable, $error);
    set_error($error);
    $rv.so;
  }

  proto method remove_contacts (|)
    is also<remove-contacts>
  { * }

  multi method remove_contacts (
                  @uids,
                  &callback,
    gpointer      $user_data   = gpointer,
    Int()        :$opflags     = 0,
    GCancellable :$cancellable = GCancellable
  ) {
    samewith(
      ArrayToCArray(Str, @uids),
      $opflags,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method remove_contacts (
    CArray[Str]    $uids,
    Int()          $opflags,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my guint32 $o = $opflags;

    e_book_backend_remove_contacts(
      $!ebb,
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
  )
    is also<remove-contacts-finish>
  {
    clear_error;
    my $rv = e_book_backend_remove_contacts_finish($!ebb, $result, $error);
    set_error($error);
    $rv.so;
  }

  proto method remove_contacts_sync (|)
    is also<remove-contacts-sync>
  { * }

  multi method remove_contacts_sync (
                             @uids,
    CArray[Pointer[GError]]  $error       = gerror,
    Int()                   :$opflags     = 0,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith(ArrayToCArray(Str, @uids), $opflags, $cancellable, $error);
  }
  multi method remove_contacts_sync (
    CArray[Str]             $uids,
    Int()                   $opflags,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = e_book_backend_remove_contacts_sync(
      $!ebb,
      $uids,
      $o,
      $cancellable,
      $error
    );
    set_error($error);
  }

  method remove_view (EDataBookView() $view) is also<remove-view> {
    e_book_backend_remove_view($!ebb, $view);
  }

  method schedule_custom_operation (
    GCancellable()   $use_cancellable,
                     &func,
    gpointer         $user_data        = gpointer,
    GDestroyNotify   $user_data_free   = gpointer
  )
    is also<schedule-custom-operation>
  {
    e_book_backend_schedule_custom_operation(
      $!ebb,
      $use_cancellable,
      &func,
      $user_data,
      $user_data_free
    );
  }

  method set_cache_dir (Str() $cache_dir) is also<set-cache-dir> {
    e_book_backend_set_cache_dir($!ebb, $cache_dir);
  }

  method set_data_book (EDataBook() $data_book) is also<set-data-book> {
    e_book_backend_set_data_book($!ebb, $data_book);
  }

  method set_locale (
    Str()                   $locale,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<set-locale>
  {
    clear_error;
    e_book_backend_set_locale($!ebb, $locale, $cancellable, $error);
    set_error($error);
  }

  method set_writable (Int() $writable) is also<set-writable> {
    my gboolean $w = $writable.so.Int;

    e_book_backend_set_writable($!ebb, $w);
  }

  method start_view (EDataBookView() $view) is also<start-view> {
    e_book_backend_start_view($!ebb, $view);
  }

  method stop_view (EDataBookView() $view) is also<stop-view> {
    e_book_backend_stop_view($!ebb, $view);
  }

  method sync {
    e_book_backend_sync($!ebb);
  }

}
