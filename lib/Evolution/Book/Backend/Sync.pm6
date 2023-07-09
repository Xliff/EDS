use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Backend::Sync;

use GLib::GSList;
use Evolution::Book::Backend;
use Evolution::Contact;

use GLib::Roles::Implementor;

our subset EBookBackendSyncAncestry is export of Mu
  where EBookBackendSync | EBookBackendAncestry;

class Evolution::Book::Backend::Sync is Evolution::Book::Backend {
  has EBookBackendSync $!eds-ebbs is implementor;

  submethod BUILD ( :$e-book-backend-sync ) {
    self.setEBookBackendSync($e-book-backend-sync)
      if $e-book-backend-sync
  }

  method setEBookBackendSync (EBookBackendSyncAncestry $_) {
    my $to-parent;

    $!eds-ebbs = do {
      when EBookBackendSync {
        $to-parent = cast(EBookBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBookBackendSync, $_);
      }
    }
    self.setEBookBackend($to-parent);
  }

  method Evolution::Raw::Definitions::EBookBackendSync
  { $!eds-ebbs }

  multi method new (
    $e-book-backend-sync where * ~~ EBookBackendSyncAncestry,

    :$ref = True
  ) {
    return unless $e-book-backend-sync;

    my $o = self.bless( :$e-book-backend-sync );
    $o.ref if $ref;
    $o;
  }

  method contains_email (
    Str()                   $email_address,
    GCancellable()          $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    clear_error;
    my $rv = so e_book_backend_sync_contains_email(
      $!eds-ebbs,
      $email_address,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method create_contacts (|)
  { * }

  multi method create_contacts (
                             @vcards,
    CArray[Pointer[GError]]  $error          = gerror,
    Int()                   :$opflags        = 0,
    GCancellable()          :$cancellable    = GCancellable,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    samewith(
       ArrayToCArray(Str, @vcards),
       $opflags,
       newCArray(GSList),
       $cancellable,
       $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method create_contacts (
    CArray[Str]              $vcards,
    Int()                    $opflags,
    CArray[GSList]           $out_contacts,
    GCancellable()           $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$all            = False,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    my guint32 $o = $opflags;

    clear_error;
    my $rv = so e_book_backend_sync_create_contacts(
      $!eds-ebbs,
      $vcards,
      $o,
      $out_contacts,
      $cancellable,
      $error
    );
    set_error($error);

    my $ocl = returnGSList(
      ppr($out_contacts),
      $raw,
      $gslist,
      |Evolution::Contacts.getTypePair
    );

    $all.not ?? $rv !! $ocl;
  }

  method get_contact (
    Str()                   $uid,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_book_backend_sync_get_contact(
      $!eds-ebbs,
      $uid,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method get_contact_list (|)
  { * }

  multi method get_contact_list (
    Str()                    $query,
    GCancellable()           $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    samewith(
      $query,
      newCArray(GSList),
      $cancellable,
      $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method get_contact_list (
    Str()                     $query,
    CArray[GSList]            $out_contacts,
    GCancellable()            $cancellable    = GCancellable,
    CArray[Pointer[GError]]   $error          = gerror,
                             :$all            = False,
                             :$raw            = False,
                             :glist(:$gslist) = False
  ) {
    clear_error;
    my $rv = so e_book_backend_sync_get_contact_list(
      $!eds-ebbs,
      $query,
      $out_contacts,
      $cancellable,
      $error
    );
    set_error($error);

    my $ocl = returnGSList(
      ppr($out_contacts),
      $raw,
      $gslist,
      |Evolution::Contact.getTypePair
    );

    $all.not ?? $rv !! $ocl;
  }

  proto method get_contact_list_uids (|)
  { * }

  multi method get_contact_list_uids (
    Str                      $query,
    GCancellable()           $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    samewith(
       $query,
       newCArray(GSList),
       $cancellable,
       $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method get_contact_list_uids (
    Str                      $query,
    CArray[GSList]           $out_uids,
    GCancellable()           $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$all            = False,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    clear_error;
    my $rv = so e_book_backend_sync_get_contact_list_uids(
      $!eds-ebbs,
      $query,
      $out_uids,
      $cancellable,
      $error
    );
    set_error($error);

    my $ou = returnGSList($out_uids, $raw, $gslist, Str);

    $all.not ?? $rv !! $ou;
  }

  proto method modify_contacts (|)
  { * }

  multi method modify_contacts (
                             @vcards,
    CArray[Pointer[GError]]  $error           = gerror;
    Int()                   :$opflags         = 0,
    GCancellable()          :$cancellable     = GCancellable,
                            :$raw             = False,
                            :glist(:$gslist)  = False
  ) {
    samewith(
       ArrayToCArray(Str, @vcards),
       $opflags,
       newCArray(GSList),
       $cancellable,
       $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method modify_contacts (
    CArray[Str]              $vcards,
    Int()                    $opflags,
    CArray[GSList]           $out_contacts,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error           = gerror,
                            :$all             = False,
                            :$raw             = False,
                            :glist(:$gslist)  = False
  ) {
    my guint $f = $opflags;

    my $rv = e_book_backend_sync_modify_contacts(
      $!eds-ebbs,
      $vcards,
      $opflags,
      $out_contacts,
      $cancellable,
      $error
    );
    set_error($error);

    my $oc = returnGSList(
      ppr($out_contacts),
      $raw,
      $gslist,
      |Evolution::Contact.getTypePair
    );

    $all.not ?? $rv !! $oc;
  }

  method open (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_book_backend_sync_open($!eds-ebbs, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method refresh (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_book_backend_sync_refresh($!eds-ebbs, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method remove_contacts (|)
  { * }

  multi method remove_contacts (
                             @uids,
    CArray[Pointer[GError]]  $error          = gerror,
    Int()                   :$opflags        = 0,
    GCancellable()          :$cancellable    = GCancellable,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    samewith(
        ArrayToCArray(Str, @uids),
       $opflags,
       $cancellable,
       $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method remove_contacts (
    CArray[Str]              $uids,
    Int()                    $opflags,
    CArray[GSList]           $out_removed_uids,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error,
                            :$all               = False,
                            :$raw               = False,
                            :glist(:$gslist)    = False
  ) {
    my guint $f = $opflags;

    clear_error;
    my $rv = so e_book_backend_sync_remove_contacts(
      $!eds-ebbs,
      $uids,
      $f,
      $out_removed_uids,
      $cancellable,
      $error
    );
    set_error($error);

    my $oru = returnGSList($out_removed_uids, $raw, $gslist, Str);

    $all.not ?? $rv !! $oru;
  }

}
