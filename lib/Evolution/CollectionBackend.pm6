use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::CollectionBackend;

use GLib::GList;
use Evolution::Backend;
use Evolution::Source;

use GIO::Roles::ProxyResolver;

our subset ECollectionBackendAncestry is export of Mu
  where ECollectionBackend | EBackendAncestry;

class Evolution::CollectionBackend is Evolution::Backend {
  has ECollectionBackend $!ecb;

  submethod BUILD (:$backend) {
    self.setECollectionBackend($backend) if $backend;
  }

  method setECollectionBackend (ECollectionBackendAncestry $_) {
    my $to-parent;

    $!ecb = do {
      when ECollectionBackend {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECollectionBackend, $_);
      }
    }
    self.setEBackend($to-parent);
  }

  method Evolution::Raw::Definitions::ECollectionBackend
  { $!ecb }

  method new (ECollectionBackendAncestry $backend, :$ref = True) {
    return Nil unless $backend;

    my $o = self.bless( :$backend );
    $o.ref if $ref;
    $o;
  }

  method new_child (ECollectionBackend() $backend, Str() $resource_id) {
    e_collection_backend_new_child($!ecb, $backend, $resource_id);
  }

  method authenticate_children (ENamedParameters() $credentials) {
    e_collection_backend_authenticate_children($!ecb, $credentials);
  }

  method claim_all_resources (:$glist = False, :$raw = False) {
    returnGList(
      e_collection_backend_claim_all_resources($!ecb),
      $glist,
      $raw,
      ESource,
      Evolution::Source
    );
  }

  method create_resource (
    ESource()      $source,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_collection_backend_create_resource(
      $!ecb,
      $source,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method create_resource_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    e_collection_backend_create_resource_finish($!ecb, $result, $error);
    set_error($error);
  }

  method create_resource_sync (
    ESource()               $source,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    clear_error;
    my $rv = so e_collection_backend_create_resource_sync(
      $!ecb,
      $source,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method delete_resource (
    ESource()      $source,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_collection_backend_delete_resource(
      $!ecb,
      $source,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method delete_resource_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error = gerror
  ) {
    e_collection_backend_delete_resource_finish($!ecb, $result, $error);
  }

  method delete_resource_sync (
    ESource()               $source,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_collection_backend_delete_resource_sync(
      $!ecb,
      $source,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method dup_resource_id (ESource() $child_source) {
    e_collection_backend_dup_resource_id($!ecb, $child_source);
  }

  method freeze_populate {
    e_collection_backend_freeze_populate($!ecb);
  }

  method get_cache_dir {
    e_collection_backend_get_cache_dir($!ecb);
  }

  method get_populate_frozen {
    so e_collection_backend_get_populate_frozen($!ecb);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_collection_backend_get_type, $n, $t );
  }

  method is_new_source (ESource() $source) {
    so e_collection_backend_is_new_source($!ecb, $source);
  }

  method list_calendar_sources (:$glist = False, :$raw = False) {
    returnGList(
      e_collection_backend_list_calendar_sources($!ecb),
      $glist,
      $raw,
      ESource,
      Evolution::Source
    );
  }

  method list_contacts_sources (:$glist = False, :$raw = False) {
    returnGList(
      e_collection_backend_list_contacts_sources($!ecb),
      $glist,
      $raw,
      ESource,
      Evolution::Source
    );
  }

  method list_mail_sources (:$glist = False, :$raw = False) {
    returnGList(
      e_collection_backend_list_mail_sources($!ecb),
      $glist,
      $raw,
      ESource,
      Evolution::Source
    );
  }

  method ref_proxy_resolver (:$raw = False) {
    my $pr = e_collection_backend_ref_proxy_resolver($!ecb);

    # Transfer: full (result from .ref provider)
    $pr ??
      ( $raw ?? $pr !! GIO::ProxyResolver.new($pr, :!ref) )
      !!
      Nil
  }

  method ref_server (:$raw = False) {
    my $s = e_collection_backend_ref_server($!ecb);

    # Late-Binding used to prevent circularity.
    # Transfer: full (result from .ref provider)
    $s ??
      ( $raw ?? $s !! ::('Evolution::Source::RegistryServer').new($s, :!ref) )
      !!
      Nil;
  }

  method schedule_populate {
    e_collection_backend_schedule_populate($!ecb);
  }

  method thaw_populate {
    e_collection_backend_thaw_populate($!ecb);
  }

}
