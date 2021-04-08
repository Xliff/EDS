use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Client;

use GLib::Error;
use GLib::GList;
use GLib::MainContext;
use Evolution::Source;

use GLib::Roles::Object;

our subset EClientAncestry is export of Mu
  where EClient | GObject;

class Evolution::Client {
  also does GLib::Roles::Object;

  has EClient $!c is implementor;

  submethod BUILD (:$client) {
    self.setEClient($client) if $client;
  }

  method setEClient (EClientAncestry $_) {
    my $to-parent;

    $!c = do {
      when EClient {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EClient, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EClient
  { $!c }

  method new (EClientAncestry $client, :$ref = True) {
    return Nil unless $client;

    my $o = self.bless( :$client );
    $o.ref if $ref;
    $o;
  }

  method cancel_all {
    e_client_cancel_all($!c);
  }

  method check_capability (Str() $capability) {
    e_client_check_capability($!c, $capability);
  }

  method check_refresh_supported {
    e_client_check_refresh_supported($!c);
  }

  method dup_bus_name {
    e_client_dup_bus_name($!c);
  }

  method error_create (Str() $custom_msg, :$raw = False) {
    my $e = e_client_error_create($!c, $custom_msg);

    # Transfer: full (Implied)
    $e ??
      ( $raw ?? $e !! GLib::Error.new($e, :!ref) )
      !!
      Nil
  }

  # method error_create_fmt (Str $format, ...) {
  #   e_client_error_create_fmt($!c, $format);
  # }

  method error_to_string (Evolution::Client:U: Int() $code) {
    my EClientError $c = $code;

    e_client_error_to_string($c);
  }

  proto method get_backend_property (|)
  { * }

  multi method get_backend_property (
    Str()          $prop_name,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($prop_name, $cancellable, &callback, $user_data);
  }
  multi method get_backend_property (
    Str()          $prop_name,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    so e_client_get_backend_property(
      $!c,
      $prop_name,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method get_backend_property_finish (
    GAsyncResult()          $result,
    Str()                   $prop_value,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_client_get_backend_property_finish(
      $!c,
      $result,
      $prop_value,
      $error
    );
    set_error($error);
    $rv;
  }

  method get_backend_property_sync (
    Str()                   $prop_name,
    Str()                   $prop_value,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_client_get_backend_property_sync(
      $!c,
      $prop_name,
      $prop_value,so
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method get_capabilities (:$glist = False, :$raw = False) {
    returnGList(
      e_client_get_capabilities($!c),
      $glist,
      $raw
    );
  }

  method get_source (:$raw = False) {
    my $s = e_client_get_source($!c);

    # Transfer: none
    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_client_get_type,
      $n,
      $t
    );
  }

  method is_online {
    so e_client_is_online($!c);
  }

  method is_opened {
    so e_client_is_opened($!c);
  }

  method is_readonly {
    so e_client_is_readonly($!c);
  }

  multi method open (
    Int()          $only_if_exists,
                   &callback,
    gpointer       $user_data        = gpointer,
    GCancellable() :$cancellable     = GCancellable
  )
    is DEPRECATED
  {
    samewith($only_if_exists, $cancellable, &callback, $user_data);
  }
  multi method open (
    Int()          $only_if_exists,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data        = gpointer
  )
    is DEPRECATED
  {
    my gboolean $o = $only_if_exists.so.Int;

    e_client_open($!c, $o, $cancellable, &callback, $user_data);
  }

  method open_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_client_open_finish($!c, $result, $error);
    set_error($error);
    $rv;
  }

  method open_sync (
    Int()                   $only_if_exists,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error           = gerror
  ) {
    my gboolean $o = $only_if_exists.so.Int;

    clear_error;
    my $rv = so e_client_open_sync($!c, $o, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method ref_main_context (:$raw = False) {
    my $mc = e_client_ref_main_context($!c);

    # Transfer: full
    $mc ??
      ($raw ?? $mc !! GLib::MainContext.new($mc, :!ref) )
      !!
      Nil;
  }

  multi method refresh (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method refresh (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_client_refresh($!c, $cancellable, &callback, $user_data);
  }

  method refresh_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_client_refresh_finish($!c, $result, $error);
    set_error($error);
    $rv;
  }

  method refresh_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_client_refresh_sync($!c, $cancellable, $error);
    set_error($error);
    $rv;
  }

  multi method remove (
                 &callback,
    gpointer     $user_data,
    GCancellable :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method remove (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    e_client_remove($!c, $cancellable, &callback, $user_data);
  }

  method remove_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_client_remove_finish($!c, $result, $error);
    set_error($error);
    $rv;
  }

  method remove_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_client_remove_sync($!c, $cancellable, $error);
    set_error($rv);
    $rv;
  }

  proto method retrieve_capabilities (|)
  { * }

  multi method retrieve_capabilities (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $cancellable);
  }
  multi method retrieve_capabilities (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    e_client_retrieve_capabilities($!c, $cancellable, &callback, $user_data);
  }

  proto method retrieve_capabilities_finish (|)
  { * }

  multi method retrieve_capabilities_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error
  ) {
    my $rv = samewith($result, $, $error, :all);

    $rv[0] ?? CStringArrayToArray( $rv[1] ) !! Nil;
  }
  multi method retrieve_capabilities_finish (
    GAsyncResult()          $result,
                            $capabilities is rw,
    CArray[Pointer[GError]] $error,
                            :$all         =  False
  ) {
    ($capabilities = CArray[Str].new)[0] = Str unless $capabilities;

    clear_error;
    my $rv = so e_client_retrieve_capabilities_finish(
      $!c,
      $result,
      $capabilities,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ($rv, $capabilities);
  }

  proto method retrieve_capabilities_sync (|)
  { * }

  multi method retrieve_capabilities_sync (
    CArray[Pointer[GError]] $error        = gerror,
                            :$raw         = False,
    GCancellable()          :$cancellable = GCancellable
  ) {
    (my $ca = CArray[Str].new)[0] = Str;

    my $rv = samewith($ca, $cancellable, $error, :all);
    return Nil unless $rv[0];
    $raw ?? $rv[1]
         !! CStringArrayToArray( $rv[1] );

  }
  multi method retrieve_capabilities_sync (
    CArray[Str]             $capabilities,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error,
                            :$all          = False
  ) {
    clear_error;
    my $rv = so e_client_retrieve_capabilities_sync(
      $!c,
      $capabilities,
      $cancellable,
      $error
    );
    set_error($error);

    $all ?? $rv !! ($rv, $capabilities);
  }

  proto method retrieve_properties (|)
  { * }

  multi method retrieve_properties (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method retrieve_properties (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_client_retrieve_properties($!c, $cancellable, &callback, $user_data);
  }

  method retrieve_properties_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_client_retrieve_properties_finish($!c, $result, $error);
    set_error($error);
    $rv;
  }

  method retrieve_properties_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    e_client_retrieve_properties_sync($!c, $cancellable, $error);
  }

  proto method set_backend_property (|)
  { * }

  multi method set_backend_property (
    Str()        $prop_name,
    Str()        $prop_value,
                 &callback,
    gpointer     $user_data    = gpointer,
    GCancellable :$cancellable = GCancellable
  ) {
    samewith($prop_name, $prop_value, $cancellable, &callback, $user_data);
  }
  multi method set_backend_property (
    Str()          $prop_name,
    Str()          $prop_value,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    so e_client_set_backend_property(
      $!c,
      $prop_name,
      $prop_value,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method set_backend_property_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error
  ) {
    clear_error;
    my $rv = so e_client_set_backend_property_finish($!c, $result, $error);
    set_error($error);
    $rv;
  }

  method set_backend_property_sync (
    Str()                   $prop_name,
    Str()                   $prop_value,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_client_set_backend_property_sync(
      $!c,
      $prop_name,
      $prop_value,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_bus_name (Str() $bus_name) {
    e_client_set_bus_name($!c, $bus_name);
  }

  # cw: -XXX- Might be missing a multi, here.
  method unwrap_dbus_error (
    GError                  $dbus_error,
    CArray[Pointer[GError]] $out_error
  )
    is DEPRECATED
  {
    e_client_unwrap_dbus_error($!c, $dbus_error, $out_error);
  }

  # Returns GSList, which currently has limited utility!
  # method util_parse_comma_strings {
  #   e_client_util_parse_comma_strings($!c);
  # }

  # DEPRECATED METHODS!
  #
  # method util_copy_object_slist (GSList $objects) {
  #   e_client_util_copy_object_slist($!c, $objects);
  # }
  #
  # method util_copy_string_slist (GSList $strings) {
  #   e_client_util_copy_string_slist($!c, $strings);
  # }
  #
  # method util_free_object_slist {
  #   e_client_util_free_object_slist($!c);
  # }
  #
  # method util_free_string_slist {
  #   e_client_util_free_string_slist($!c);
  # }
  #
  # method util_slist_to_strv {
  #   e_client_util_slist_to_strv($!c);
  # }
  #
  # method util_strv_to_slist {
  #   e_client_util_strv_to_slist($!c);
  # }


  proto method wait_for_connected (|)
  { * }

  multi method wait_for_connected (
    Int()          $timeout_seconds,
                   &callback,
    gpointer       $user_data        = gpointer,
    GCancellable() :$cancellable     = GCancellable
  ) {
    samewith($timeout_seconds, $cancellable, &callback, $user_data);
  }
  multi method wait_for_connected (
    Int()          $timeout_seconds,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my guint32 $t = $timeout_seconds;

    e_client_wait_for_connected(
      $!c,
      $t,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method wait_for_connected_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    clear_error;
    my $rv = e_client_wait_for_connected_finish($!c, $result, $error);
    set_error($error);
    $rv;
  }

  method wait_for_connected_sync (
    Int()                   $timeout_seconds,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    my guint32 $t = $timeout_seconds;

    clear_error;
    my $rv = so e_client_wait_for_connected_sync(
      $!c,
      $timeout_seconds,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

}

use GLib::Roles::StaticClass;

class Evolution::Client::Util {
  also does GLib::Roles::StaticClass;

  proto method unwrap_dbus_error (|)
  { * }

  multi method unwrap_dbus_error (
    GError  $dbus_error,
            @known_errors,
    GQuark  $known_errors_domain,
    Int()   $fail_when_none_matched
  ) {
    # Create an empty CArray[Pointer[GError]] value
    my $ce = gerror;

    samewith(
      $dbus_error,
      $ce,
      GLib::Roles::TypedBuffer[GError].new(@known_errors).p,
      @known_errors.elems,
      $known_errors_domain,
      $fail_when_none_matched
    );
  }
  multi method unwrap_dbus_error (
    GError   $dbus_error,
             $client_error            is rw,  #= CArray[Pointer[GError], but not to be used as the global error!,
    gpointer $known_errors,                   #= EClientList *
    Int()    $known_errors_count,
    GQuark   $known_errors_domain,
    Int()    $fail_when_none_matched,
             :$all                    =  False
  )
    is DEPRECATED
  {
    my guint    $ec = $known_errors_count;
    my gboolean $f  = $fail_when_none_matched.so.Int;

    $client_error //= gerror;

    my $rv = so e_client_util_unwrap_dbus_error(
      $dbus_error,
      $client_error,
      $known_errors,
      $ec,
      $known_errors_domain,
      $f
    );

    $all.not ?? $rv !! ( $rv, ppr($client_error) );
  }

}
