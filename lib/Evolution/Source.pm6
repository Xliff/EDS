use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source;

use GLib::Roles::Object;
use GIO::Roles::Initable;
use GIO::Roles::ProxyResolver;

our subset ESourceAncestry is export of Mu
  where ESource | GInitable | GProxyResolver | GObject;

class Evolution::Source {
  also does GLib::Roles::Object;
  also does GIO::Roles::Initable;
  also does GIO::Roles::ProxyResolver;

  has ESource $!s;

  submethod BUILD (:$source) {
    self.setESource($source) if $source;
  }

  method setESource (ESourceAncestry $_) {
    my $to-parent;

    $!s = do {
      when ESource {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GInitable {
        $to-parent = cast(GObject, $_);
        $!i = $_;
        cast(ESource, $_);
      }

      when GProxyResolver {
        $to-parent = cast(GObject, $_);
        $!pr = $_;
        cast(ESource, $_);
      }

      default {
        $to-parent = $_;
        cast(ESource, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GInitable;
    self.roleInit-ProxyResolver;
  }

  method EDS::Raw::Definitions::ESource
  { $!s }

  multi method new (ESourceAncestry $source, :$ref = True) {
    return Nil unless $source;

    my $o = self.bless( :$source );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GDBusObject()           $object,
    GMainContext()          $main_context,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $source = e_source_new_with_uid($object, $main_context, $error);
    set_error($error);

    $source ?? self.bless( :$source ) !! Nil;
  }

  method new_with_uid (
    Str()                   $uid,
    GMainContext()          $main_context,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    clear_error;
    my $source = e_source_new_with_uid($uid, $main_context, $error);
    set_error($error);

    $source ?? self.bless( :$source ) !! Nil;
  }

  method display_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        e_source_get_display_name($!s);
      },
      STORE => sub ($, $display_name is copy) {
        e_source_set_display_name($!s, $display_name);
      }
    );
  }

  method changed {
    e_source_changed($!s);
  }

  method delete_password (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    e_source_delete_password($!s, $cancellable, &callback, $user_data);
  }

  method delete_password_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_source_delete_password_finish($!s, $result, $error);
    set_error($error);
    $rv;
  }

  method delete_password_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    e_source_delete_password_sync($!s, $cancellable, $error);
  }

  method dup_parent {
    e_source_dup_parent($!s);
  }

  method dup_secret_label {
    e_source_dup_secret_label($!s);
  }

  method dup_uid {
    e_source_dup_uid($!s);
  }

  method emit_credentials_required (
    Int()  $reason,
    Str()  $certificate_pem,
    Int()  $certificate_errors,
    GError $op_error            = gerror
  ) {
    e_source_emit_credentials_required(
      $!s,
      $reason,
      $certificate_pem,
      $certificate_errors,
      $op_error
    );
  }

  method get_enabled {
    so e_source_get_enabled($!s);
  }

  # cw: If there were any way for Raku to force the use of try, here would be
  # one.
  #| throws X::ClassNotFound
  method get_extension (Str() $extension_name, :$typed = True, :$raw = False) {
    my $e = e_source_get_extension($!s, $extension_name);

    my \class = do if $typed.not {
      ESource::Extension
    } else {
      # cw: Callers should always prep for failure, here!
      ::(
        "Evolution::Source::{ $extension_name.subst(' ', '')
                                             .subst(/'(' <-[)]>+ ')'/, '') }"
      );
    }

    $e ??
      ( $raw ?? $e !! class.new($e, :!ref) )
      !!
      Nil
  }

  proto method get_last_credentials_required_arguments (|)
  { * }

  multi method get_last_credentials_required_arguments (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method get_last_credentials_required_arguments (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    e_source_get_last_credentials_required_arguments(
      $!s,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_last_credentials_required_arguments_finish (|)
  { * }

  multi method get_last_credentials_required_arguments_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   =  gerror
  ) {
    my $rv = samewith($result, $, $, $, $, $error);

    $rv[0] ?? $rv.skip(1) !! Nil;
  }

  # all parameters starting with 'out_' are rw parameters.
  # Needs thought.
  multi method get_last_credentials_required_arguments_finish (
    GAsyncResult()           $result,
                             $out_reason              is rw,
                             $out_certificate_pem     is rw,
                             $out_certificate_errors  is rw,
                             $out_op_error            is rw,
    CArray[Pointer[GError]]  $error                   =  gerror
  ) {
    my GTlsCertificateFlags      $oc   = 0;
    my ESourceCredentialsReason  $or   = 0;
    (my CArray[Str]              $ocp  = CArray[Str].new)[0] = Str;
    my $oce                          //= CArray[Pointer[GError]];
    my $ooe                          //= CArray[Pointer[GError]];
    ($oce, $ooe)».[0]                  = Pointer[GError] xx 2;

    clear_error;
    my $rv = e_source_get_last_credentials_required_arguments_finish(
      $!s,
      $result,
      $or,
      $ocp,
      $oce,
      $ooe,
      $error
    );
    set_error($error);
    ($out_reason, $out_certificate_pem, $out_certificate_errors, $out_op_error)
      =
    ($or, $ocp, $oce, $ooe);

    (
      $rv,
      $out_reason,
      $out_certificate_pem,
      $out_certificate_errors,
      $out_op_error
    )
  }

  # cw: -XXX- Look into this, please. Are we missing a multi and some "is rw" params?
  method get_last_credentials_required_arguments_sync (
    Int()                    $out_reason,
    Str                      $out_certificate_pem,
    Int()                    $out_certificate_errors,
    CArray[Pointer[GError]]  $out_op_error,
    GCancellable()           $cancellable             = GCancellable,
    CArray[Pointer[GError]]  $error                   = gerror
  ) {
    my CArray[Str]              $ocp = CArray[Str].new;
    my ESourceCredentialsReason $or  = CArray[Str].new;
    my GTlsCertificateFlags     $oce = 0;

    ($or, $ocp, $oce) = (Str, Str, Pointer[GError]);

    so e_source_get_last_credentials_required_arguments_sync(
      $!s,
      $or,
      $ocp,
      $oce,
      $out_op_error,
      $cancellable,
      $error
    );
  }

  proto method get_oauth2_access_token (|)
  { * }

  multi method get_oauth2_access_token (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method get_oauth2_access_token (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    e_source_get_oauth2_access_token($!s, $cancellable, &callback, $user_data);
  }

  proto method get_oauth2_access_token_finish (|)
  { * }

  multi method get_oauth2_access_token_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    my $rv = samewith($result, $, $, $error);

    $rv[0] ?? $rv.skip(1) !! Nil;
  }
  multi method get_oauth2_access_token_finish (
    GAsyncResult()          $result,
                            $out_access_token is rw,
                            $out_expires_in   is rw,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gint $oei = 0;

    (my $oat = CArray[Str].new)[0] = Str;

    clear_error;
    my $rv = so e_source_get_oauth2_access_token_finish(
      $!s,
      $result,
      $oat,
      $oei,
      $error
    );
    set_error($error);
    ($out_access_token, $out_expires_in) = ( ppr($oat), $oei );
    ($rv, $out_access_token, $out_expires_in);
  }


  proto method get_oauth2_access_token_sync (|)
  { * }

  multi method get_oauth2_access_token_sync (
    CArray[Pointer[GError]] $error        = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($cancellable, $, $, $error);
  }
  multi method get_oauth2_access_token_sync (
    GCancellable() $cancellable,
                   $out_access_token is rw,
                   $out_expires_in   is rw,
    CArray[Pointer[GError]] $error   =  gerror
  ) {
    my gint $oei = 0;

    (my $oat = CArray[Str].new)[0] = Str;

    my $rv = e_source_get_oauth2_access_token_sync(
      $!s,
      $cancellable,
      $oat,
      $oei,
      $error
    );
    ($out_access_token, $out_expires_in) = ( ppr($oat), $oei );
    ($rv, $out_access_token, $out_expires_in)
  }

  method get_remote_creatable {
    so e_source_get_remote_creatable($!s);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_get_type,
      $n,
      $t
    );
  }

  method get_writable {
    so e_source_get_writable($!s);
  }

  method has_extension (Str() $extension_name) {
    e_source_has_extension($!s, $extension_name);
  }

  method hash {
    e_source_hash($!s);
  }

  proto method invoke_authenticate (|)
  { * }

  multi method invoke_authenticate (
    ENamedParameters() $credentials,
                       &callback,
    gpointer           $user_data    = gpointer,
    GCancellable()     :$cancellable = GCancellable
  ) {
    samewith($credentials, $cancellable, &callback, $user_data);
  }
  multi method invoke_authenticate (
    ENamedParameters() $credentials,
    GCancellable()     $cancellable,
                       &callback,
    gpointer           $user_data   = gpointer
  ) {
    so e_source_invoke_authenticate(
      $!s,
      $credentials,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method invoke_authenticate_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    clear_error;
    my $rv = so e_source_invoke_authenticate_finish($!s, $result, $error);
    set_error($error);
    $rv;
  }

  method invoke_authenticate_sync (
    ENamedParameters()      $credentials,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    e_source_invoke_authenticate_sync($!s, $credentials, $cancellable, $error);
  }

  proto method invoke_credentials_required (|)
  { * }

  multi method invoke_credentials_required (
    Int()                    $reason,
    Str()                    $certificate_pem,
    Int()                    $certificate_errors,
    CArray[Pointer[GError]]  $op_error,
                             &callback,
    gpointer                 $user_data          = gpointer,
    GCancellable()           :$cancellable       = GCancellable
  ) {
    samewith(
      $reason,
      $certificate_pem,
      $certificate_errors,
      $op_error,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method invoke_credentials_required (
    Int()                    $reason,
    Str()                    $certificate_pem,
    Int()                    $certificate_errors,
    CArray[Pointer[GError]]  $op_error,
    GCancellable()           $cancellable,
                             &callback,
    gpointer                 $user_data          = gpointer
  ) {
    my ESourceCredentialsReason $r = $reason;
    my GTlsCertificateFlags     $c = $certificate_errors;

    clear_error;
    e_source_invoke_credentials_required(
      $!s,
      $reason,
      $certificate_pem,
      $certificate_errors,
      $op_error,
      $cancellable,
      &callback,
      $user_data
    );
    set_error($op_error);
  }

  method invoke_credentials_required_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    clear_error;
    my $rv = e_source_invoke_credentials_required_finish($!s, $result, $error);
    set_error($error);
    $rv;
  }

  proto method invoke_credentials_required_sync (|)
  { * }

  multi method invoke_credentials_required_sync (
    Int()                   $reason,
    Str()                   $certificate_pem,
    Int()                   $certificate_errors,
    CArray[Pointer[GError]] $error               = gerror,
    CArray[Pointer[GError]] :op-error(
                              :$op_error
                            )                    = CArray[Pointer[GError]],
    GCancellable            :$cancellable        = GCancellable
  ) {
    samewith(
      $reason,
      $certificate_pem,
      $certificate_errors,
      $op_error,
      $cancellable,
      $error
    );
  }
  multi method invoke_credentials_required_sync (
    Int()                   $reason,
    Str()                   $certificate_pem,
    Int()                   $certificate_errors,
    CArray[Pointer[GError]] $op_error           = CArray[Pointer[GError]],
    GCancellable            $cancellable        = GCancellable,
    CArray[Pointer[GError]] $error              = gerror
  ) {
    my ESourceCredentialsReason $r = $reason;
    my GTlsCertificateFlags     $c = $certificate_errors;

    clear_error;
    e_source_invoke_credentials_required_sync(
      $!s,
      $reason,
      $certificate_pem,
      $certificate_errors,
      $op_error,
      $cancellable,
      $error
    );
    set_error($error);
  }

  proto method lookup_password (|)
  { * }

  multi method lookup_password (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data)
  }
  multi method lookup_password (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data   = gpointer
  ) {
    e_source_lookup_password($!s, $cancellable, &callback, $user_data);
  }


  proto method lookup_password_finish (|)
  { * }

  multi method lookup_password_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    my $rv = samewith($result, $, $error, :all);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method lookup_password_finish (
    GAsyncResult            $result,
                            $out_password is rw,
    CArray[Pointer[GError]] $error,
                            :$all = False
  ) {
    (my $op = CArray[Str].new)[0] = Str;

    clear_error;
    my $rv = e_source_lookup_password_finish(
      $!s,
      $result,
      $op,
      $error
    );
    set_error($error);
    $out_password = ppr($op);

    $all.not ?? $rv !! ($rv, $out_password);
  }

  proto method lookup_password_sync (|)
  { * }

  multi method lookup_password_sync (
    CArray[Pointer[GError]] $error       = gerror,
    GCancellable()         :$cancellable = GCancellable
  ) {
    my $rv = samewith($cancellable, $, $error);

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method lookup_password_sync (
    GCancellable()         $cancellable,
                            $out_password is rw,
    CArray[Pointer[GError]] $error        =  gerror,
                            :$all         =  False
  ) {
    (my $op = CArray[Str].new)[0] = Str;

    clear_error;
    my $rv = so e_source_lookup_password_sync($!s, $cancellable, $op, $error);
    set_error($error);
    $out_password = ppr($op);

    $all.not ?? $rv !! ($rv, $out_password);
  }

  method parameter_to_key (Str() $param) {
    e_source_parameter_to_key($param);
  }

  method ref_dbus_object (:$raw = False) {
    my $ro = e_source_ref_dbus_object($!s);

    $ro ??
      ( $raw ?? $ro !! GIO::DBus::Object.new($ro, :!ref) )
      !!
      Nil;
  }

  proto method remote_create (|)
  { * }

  multi method remote_create (
    ESource()      $scratch_source,
                   &callback,
    gpointer       $user_data      = gpointer,
    GCancellable() :$cancellable   = GCancellable
  ) {
    samewith($scratch_source, $cancellable, &callback, $user_data);
  }
  multi method remote_create (
    ESource()      $scratch_source,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    e_source_remote_create(
      $!s,
      $scratch_source,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method remote_create_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    e_source_remote_create_finish($!s, $result, $error);
  }

  method remote_create_sync (
    ESource()               $scratch_source,
    GCancellable()          $cancellable     = GCancellable,
    CArray[Pointer[GError]] $error           = gerror
  ) {
    e_source_remote_create_sync($!s, $scratch_source, $cancellable, $error);
  }

  proto method remote_delete (|)
  { *}

  multi method remote_delete (
                   &callback,
    gpointer       $user_data   = gpointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method remote_delete (
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data          = gpointer
  ) {
    e_source_remote_delete($!s, $cancellable, &callback, $user_data);
  }

  method remote_delete_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_source_remote_delete_finish($!s, $result, $error);
    set_error($error);
    $rv;
  }

  method remote_delete_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    so e_source_remote_delete_sync($!s, $cancellable, $error);
  }

  multi method remove (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method remove (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_source_remove($!s, $cancellable, &callback, $user_data);
  }

  method remove_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_source_remove_finish($!s, $result, $error);
    set_error($error);
    $rv;
  }

  method remove_sync (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so e_source_remove_sync($!s, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method set_connection_status (Int() $connection_status) {
    my ESourceConnectionStatus $c = $connection_status;

    e_source_set_connection_status($!s, $connection_status);
  }

  proto method store_password (|)
  { * }

  multi method store_password (
    Str()          $password,
    Int()          $permanently,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($password, $permanently, $cancellable, &callback, $user_data);
  }
  multi method store_password (
    Str()          $password,
    Int()          $permanently,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my gboolean $p = $permanently.so.Int;

    e_source_store_password(
      $!s,
      $password,
      $p,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method store_password_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so e_source_store_password_finish($!s, $result, $error);
    set_error($error);
    $rv;
  }

  method store_password_sync (
    Str()                   $password,
    Int()                   $permanently,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {

    my gboolean $p = $permanently.so.Int;

    clear_error;
    my $rv = so e_source_store_password_sync(
      $!s,
      $password,
      $permanently,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method to_string (Int() $length) {
    my gsize $l = $length;

    e_source_to_string($!s, $length);
  }

  proto method unset_last_credentials_required_arguments (|)
  { * }

  multi method unset_last_credentials_required_arguments (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method unset_last_credentials_required_arguments (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data   = gpointer
  ) {
    so e_source_unset_last_credentials_required_arguments(
      $!s,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method unset_last_credentials_required_arguments_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error
  ) {
    clear_error;
    my $rv = so e_source_unset_last_credentials_required_arguments_finish(
      $!s,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

  method unset_last_credentials_required_arguments_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    so e_source_unset_last_credentials_required_arguments_sync(
      $!s,
      $cancellable,
      $error
    );
  }

  multi method write (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method write (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_source_write($!s, $cancellable, &callback, $user_data);
  }

  method write_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    e_source_write_finish($!s, $result, $error);
  }

  method write_sync (
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_source_write_sync($!s, $cancellable, $error);
    set_error($error);
    $rv;
  }

}
