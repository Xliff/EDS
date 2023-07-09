use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Book::Backend::Cache;

use GLib::GList;
use Evolution::Cache::File;
use Evolution::Contact;

use GLib::Roles::Implementor;

our subset EBookBackendCacheAncestry is export of Mu
  where EBookBackendCache | EFileCacheAncestry;

class Evolution::Book::Backend::Cache is Evolution::Cache::File {
  has EBookBackendCache $!eds-ebbc is implementor;

  submethod BUILD ( :$e-backend-cache ) {
    self.setEBookBackendCache($e-backend-cache) if $e-backend-cache
  }

  method setEBookBackendCache (EBookBackendCacheAncestry $_) {
    my $to-parent;

    $!eds-ebbc = do {
      when EBookBackendCache {
        $to-parent = cast(EFileCache, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBookBackendCache, $_);
      }
    }
    self.setEFileCache($to-parent);
  }

  method Evolution::Raw::Definitions::EBookBackendCache
    is also<EBookBackendCache>
  { $!eds-ebbc }

  multi method new (
    $e-backend-cache where * ~~ EBookBackendCacheAncestry,

    :$ref = True
  ) {
    return unless $e-backend-cache;

    my $o = self.bless( :$e-backend-cache );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $e-backend-cache = e_book_backend_cache_new();

    $e-backend-cache ?? self.bless( :$e-backend-cache ) !! Nil;
  }

  method add_contact (EContact() $contact) {
    e_book_backend_cache_add_contact($!eds-ebbc, $contact);
  }

  method check_contact (Str() $uid) {
    e_book_backend_cache_check_contact($!eds-ebbc, $uid);
  }

  method get_contact (Str() $uid, :$raw = False) {
    propReturnObject(
      e_book_backend_cache_get_contact($!eds-ebbc, $uid),
      $raw,
      |Evolution::Contact.getTypePair
    );
  }

  method get_contacts (
    Str()  $query,
          :$raw            = False,
          :gslist(:$glist) = False
  ) {
    returnGList(
      e_book_backend_cache_get_contacts($!eds-ebbc, $query),
      $raw,
      $glist,
      |Evolution::Contact.getTypePair
    );
  }

  method get_time {
    e_book_backend_cache_get_time($!eds-ebbc);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_book_backend_cache_get_type, $n, $t );
  }

  method is_populated {
    so e_book_backend_cache_is_populated($!eds-ebbc);
  }

  method remove_contact (Str() $uid) {
    e_book_backend_cache_remove_contact($!eds-ebbc, $uid);
  }

  method search (Str() $query) {
    e_book_backend_cache_search($!eds-ebbc, $query);
  }

  method set_populated {
    e_book_backend_cache_set_populated($!eds-ebbc);
  }

  method set_time (Str() $t) {
    e_book_backend_cache_set_time($!eds-ebbc, $t);
  }

}
