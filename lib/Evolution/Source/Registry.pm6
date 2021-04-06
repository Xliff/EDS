use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Registry;

use GLib::GList;
use GLib::Node;

use GLib::Roles::Object;
use GIO::Roles::Initable;
use GIO::Roles::AsyncInitable;

our subset ESourceRegistryAncestry is export of Mu
  where ESourceRegistry | GInitable | GAsyncInitable | GObject;

class Evolution::Source::Registry {
  also does GLib::Roles::Object;
  also does GIO::Roles::Initable;
  also does GIO::Roles::AsyncInitable;

  has ESourceRegistry $!esr;

  submethod BUILD (:$calendar) {
    self.setESourceRegistry($calendar) if $calendar;
  }

  method setESourceRegistry (ESourceRegistryAncestry $_) {
    my $to-parent;

    $!esr = do {
      when ESourceRegistry {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GInitable {
        $to-parent = cast(GObject, $_);
        $!i = $_;
        cast(ESourceRegistry, $_);
      }

      when GAsyncInitable {
        $to-parent = cast(GObject, $_);
        $!ai = $_;
        cast(ESourceRegistry, $_);
      }

      default {
        $to-parent = $_;
        cast(ESourceRegistry, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-Initable;
    self.roleInit-AsyncInitable;
  }

  method Evolution::Raw::Definitions::ESourceRegistry
  { $!esr }

  multi method new (ESourceRegistryAncestry $calendar, :$ref = True) {
    return Nil unless $calendar;

    my $o = self.bless( :$calendar );
    $o.ref if $ref;
    $o;
  }
  multi method new (&callback, gpointer $user_data = gpointer) {
    my $registry = e_source_registry_new($!esr, &callback, $user_data);

    $registry ?? self.bless( :$registry ) !! Nil;
  }

  method new_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $registry = e_source_registry_new_finish($!esr, $result, $error);
    set_error($error);

    $registry ?? self.bless( :$registry ) !! Nil;
  }

  method new_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $registry = e_source_registry_new_sync($!esr, $cancellable, $error);
    set_error($error);

    $registry ?? self.bless( :$registry ) !! Nil;
  }

  method build_display_tree (Str() $extension_name, :$raw = False) {
    my $n = e_source_registry_build_display_tree($!esr, $extension_name);

    $n ??
      ( $raw ?? $n !! GLib::Node.new($n) )
      !!
      Nil;
  }

  method check_enabled (ESource() $source) {
    so e_source_registry_check_enabled($!esr, $source);
  }

  proto method commit_source (|)
  { * }

  multi method commit_source (
    ESource()      $source,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $source,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method commit_source (
    ESource()      $source,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_source_registry_commit_source(
      $!esr,
      $source,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method commit_source_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_source_registry_commit_source_finish($!esr, $result, $error);
    set_error($error);
    $rv;
  }

  method commit_source_sync (
    ESource()               $source,
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = e_source_registry_commit_source_sync(
      $!esr,
      $source,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;

  }

  proto method create_sources (|)
  { * }

  multi method create_sources (
    GList()        $list_of_sources,
                   &callback,
    gpointer       $user_data       = gpointer,
    GCancellable() :$cancellable    = GCancellable
  ) {
    samewith(
      $list_of_sources,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method create_sources (
    GList()        $list_of_sources,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data       = gpointer
  ) {
    e_source_registry_create_sources(
      $!esr,
      $list_of_sources,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method create_sources_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = e_source_registry_create_sources_finish($!esr, $result, $error);
    set_error($error);
    $rv;
  }

  method create_sources_sync (
    GList()                 $list_of_sources,
    GCancellable()          $cancellable      = GCancellable,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    so e_source_registry_create_sources_sync(
      $!esr,
      $list_of_sources,
      $cancellable,
      $error
    );
  }

  method debug_dump (Str() $extension_name) {
    e_source_registry_debug_dump($!esr, $extension_name);
  }

  method dup_unique_display_name (ESource() $source, Str() $extension_name) {
    e_source_registry_dup_unique_display_name($!esr, $source, $extension_name);
  }

  method find_extension (
    ESource() $source,
    Str()     $extension_name,
              :$raw            = False
  ) {
    my $s = e_source_registry_find_extension($!esr, $source, $extension_name);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method free_display_tree (Evolution::Source::Registry:U: GNode() $t) {
    e_source_registry_free_display_tree($t);
  }

  method get_oauth2_services {
    e_source_registry_get_oauth2_services($!esr);
  }

  method list_enabled (Str() $extension_name, :$glist = False, :$raw = False) {
    returnGList(
      e_source_registry_list_enabled($!esr, $extension_name),
      $glist,
      $raw,
      ESource,
      Evolution::Source
    );
  }

  method list_sources (Str() $extension_name, :$glist = False, :$raw = False) {
    returnGList(
      e_source_registry_list_sources($!esr, $extension_name),
      $glist,
      $raw,
      ESource,
      Evolution::Source
    );
  }

  method ref_builtin_address_book (:$raw = False) {
    my $s = e_source_registry_ref_builtin_address_book($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method ref_builtin_calendar (:$raw = False) {
    my $s = e_source_registry_ref_builtin_calendar($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method ref_builtin_mail_account (:$raw = False) {
    my $s = e_source_registry_ref_builtin_mail_account($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method ref_builtin_memo_list (:$raw = False) {
    my $s = e_source_registry_ref_builtin_memo_list($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method ref_builtin_proxy (:$raw = False) {
    my $s = e_source_registry_ref_builtin_proxy($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method ref_builtin_task_list (:$raw = False) {
    my $s = e_source_registry_ref_builtin_task_list($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method ref_default_address_book (:$raw = False) {
    my $s = e_source_registry_ref_default_address_book($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method ref_default_calendar (:$raw = False) {
    my $s = e_source_registry_ref_default_calendar($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method ref_default_for_extension_name (Str() $extension_name, :$raw = False) {
    my $s = e_source_registry_ref_default_for_extension_name(
      $!esr,
      $extension_name
    );

    $s ??
      ( $raw ?? $s !! Evolution::Source($s) )
      !!
      Nil;
  }

  method ref_default_mail_account (:$raw = False) {
    my $s = e_source_registry_ref_default_mail_account($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source($s) )
      !!
      Nil;
  }

  method ref_default_mail_identity (:$raw = False) {
    my $s = e_source_registry_ref_default_mail_identity($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source($s) )
      !!
      Nil;
  }

  method ref_default_memo_list (:$raw = False) {
    my $s = e_source_registry_ref_default_memo_list($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source($s) )
      !!
      Nil;
  }

  method ref_default_task_list (:$raw = False) {
    my $s = e_source_registry_ref_default_task_list($!esr);

    $s ??
      ( $raw ?? $s !! Evolution::Source($s) )
      !!
      Nil;
  }

  method ref_source (Str() $uid, :$raw = False) {
    my $s = e_source_registry_ref_source($!esr, $uid);

    $s ??
      ( $raw ?? $s !! Evolution::Source($s) )
      !!
      Nil;
  }

  proto method refresh_backend (|)
  { * }

  multi method refresh_backend (
    Str()          $source_uid,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $source_uid,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method refresh_backend (
    Str()          $source_uid,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_source_registry_refresh_backend(
      $!esr,
      $source_uid,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method refresh_backend_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_source_registry_refresh_backend_finish(
      $!esr,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

  method refresh_backend_sync (
    Str()                   $source_uid,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = e_source_registry_refresh_backend_sync(
      $!esr,
      $source_uid,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_default_address_book (ESource() $default_source) {
    e_source_registry_set_default_address_book($!esr, $default_source);
  }

  method set_default_calendar (ESource() $default_source) {
    e_source_registry_set_default_calendar($!esr, $default_source);
  }

  method set_default_for_extension_name (
    Str()     $extension_name,
    ESource() $default_source
  ) {
    e_source_registry_set_default_for_extension_name(
      $!esr,
      $extension_name,
      $default_source
    );
  }

  method set_default_mail_account (ESource() $default_source) {
    e_source_registry_set_default_mail_account($!esr, $default_source);
  }

  method set_default_mail_identity (ESource() $default_source) {
    e_source_registry_set_default_mail_identity($!esr, $default_source);
  }

  method set_default_memo_list (ESource() $default_source) {
    e_source_registry_set_default_memo_list($!esr, $default_source);
  }

  method set_default_task_list (ESource() $default_source) {
    e_source_registry_set_default_task_list($!esr, $default_source);
  }
}
