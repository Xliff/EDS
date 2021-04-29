use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Backend;

use GLib::MainContext;
use Evolution::Source;

use GLib::Roles::Object;
use GIO::Roles::SocketConnectable;

our subset EBackendAncestry is export of Mu
  where EBackend | GObject;

class Evolution::Backend {
  also does GLib::Roles::Object;

  has EBackend $!eb;

  submethod BUILD (:$backend) {
    self.setEBackend($backend) if $backend;
  }

  method setEBackend (EBackendAncestry $_) {
    my $to-parent;

    $!eb = do {
      when EBackend {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EBackend, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EBackend
  { $!eb }

  method new (EBackendAncestry $backend, :$ref = True) {
    return Nil unless $backend;

    my $o = self.bless( :$backend );
    $o.ref if $ref;
    $o;
  }

  # Type: GSocketConnectable
  method connectable ( :$raw = False) is rw  {
    my $gv = GLib::Value.new( GIO::SocketConnectable.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('connectable', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          GSocketConnectable,
          GIO::SocketConnectable
        );
      },
      STORE => -> $, GSocketConnectable() $val is copy {
        $gv.object = $val;
        self.prop_set('connectable', $gv);
      }
    );
  }

  # Type: GMainContext
  method main-context (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GLib::MainContext.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('main-context', $gv)
        );

        propReturnObject(
          $gv.pointer,
          $raw,
          GMainContext,
          GLib::MainContext
        );
      },
      STORE => -> $,  $val is copy {
        warn 'main-context does not allow writing'
      }
    );
  }

  # Type: gboolean
  method online is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('online', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('online', $gv);
      }
    );
  }

  # Type: ESource
  method source ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( Evolution::Source.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('source', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          ESource,
          Evolution::Source
        );
      },
      STORE => -> $, $val is copy {
        warn 'source is a construct-only attribute'
      }
    );
  }

  # EUserPrompter
  method user-prompter ( :$raw = False) is rw  {
    my $gv = GLib::Value.new( Evolution::UserPrompter.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('user-prompter', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          EUserPrompter,
          Evolution::UserPrompter
        )
      },
      STORE => -> $,  $val is copy {
        warn 'user-prompter does not allow writing'
      }
    );
  }

  proto method credentials_required (|)
  { * }

  multi method credentials_required (
    Int()                   $reason,
    Str()                   $certificate_pem,
    Int()                   $certificate_errors,
                            &callback,
    gpointer                $user_data           = gpointer,
    GError()                :$op_error           = GError,
    GCancellable()          :$cancellable        = GCancellable
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
  multi method credentials_required (
    Int()                   $reason,
    Str()                   $certificate_pem,
    Int()                   $certificate_errors,
    GError()                $op_error,
    GCancellable()          $cancellable,
                            &callback,
    gpointer                $user_data
  ) {
    my ESourceCredentialsReason $r = $reason;
    my GTlsCertificateFlags     $c = $certificate_errors;

    e_backend_credentials_required(
      $!eb,
      $r,
      $certificate_pem,
      $c,
      $op_error,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method credentials_required_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_backend_credentials_required_finish($!eb, $result, $error);
    set_error($error);
    $rv;
  }

  method credentials_required_sync (
    Int()                   $reason,
    Str()                   $certificate_pem,
    Int()                   $certificate_errors,
    GError()                $op_error            = GError,
    GCancellable()          $cancellable         = GCancellable,
    CArray[Pointer[GError]] $error               = gerror
  ) {
    my ESourceCredentialsReason $r = $reason;
    my GTlsCertificateFlags     $c = $certificate_errors;

    clear_error;
    my $rv = so e_backend_credentials_required_sync(
      $!eb,
      $r,
      $certificate_pem,
      $c,
      $op_error,
      $cancellable,
      $error
    );
  }

  method ensure_online_state_updated (
    GCancellable() $cancellable = GCancellable
  ) {
    e_backend_ensure_online_state_updated($!eb, $cancellable);
  }

  method ensure_source_status_connected {
    e_backend_ensure_source_status_connected($!eb);
  }

  multi method get_destination_address {
    (my $h = CArray[Str].new)[0] = Str;

    my $rv = samewith($h, $, :all);

    $rv ?? $rv.skip(1) !! Nil;
  }
  multi method get_destination_address (CArray[Str] $host, $port is rw, :$all = False) {
    my gint16 $p   = 0;
    my        $rv = so e_backend_get_destination_address($!eb, $host, $p);

    return $rv unless $all;

    ($rv, ppr($host), $p)
  }

  method get_online {
    so e_backend_get_online($!eb);
  }

  method get_source (:$raw = False) {
    my $s = e_backend_get_source($!eb);

    # Source is paired with this object, so no tranfer is possible.
    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s) )
      !!
      Nil
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_backend_get_type, $n, $t );
  }

  method get_user_prompter (:$raw = False) {
    my $up = e_backend_get_user_prompter($!eb);

    # Transfer: none
    $up ??
      ( $raw ?? $up !! Evolution::UserPrompter.new($up) )
      !!
      Nil;
  }

  method is_destination_reachable (
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error
    my $rc = so e_backend_is_destination_reachable($!eb, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method prepare_shutdown {
    e_backend_prepare_shutdown($!eb);
  }

  method ref_connectable (:$raw = False) {
    my $sc = e_backend_ref_connectable($!eb);

    $sc ??
      ( $raw ?? $sc !! GIO::SocketConnectable.new($sc, :!ref) )
      !!
      Nil
  }

  method ref_main_context (:$raw = False) {
    my $mc = e_backend_ref_main_context($!eb);

    $mc ??
      ( $raw ?? $mc !! GLib::MainContext.new($raw, :!ref) )
      !!
      Nil;
  }

  method schedule_authenticate (ENamedParameters() $credentials) {
    e_backend_schedule_authenticate($!eb, $credentials);
  }

  method schedule_credentials_required (
    Int()          $reason,
    Str            $certificate_pem,
    Int()          $certificate_errors,
    GError()       $op_error            = GError,
    GCancellable() $cancellable         = GCancellable,
    Str()          $who_calls           = Str
  ) {
    my ESourceCredentialsReason $r = $reason;
    my GTlsCertificateFlags     $c = $certificate_errors;

    e_backend_schedule_credentials_required(
      $!eb,
      $r,
      $certificate_pem,
      $c,
      $op_error,
      $cancellable,
      $who_calls
    );
  }

  method set_connectable (GSocketConnectable() $connectable) {
    e_backend_set_connectable($!eb, $connectable);
  }

  method set_online (Int() $online) {
    my gboolean $o = $online;

    e_backend_set_online($!eb, $o);
  }

  proto method trust_prompt (|)
  { * }

  multi method trust_prompt (
    ENamedParameters() $parameters,
                       &callback,
    gpointer           $user_data    = gpointer,
    GCancellable()     :$cancellable = GCancellable
  ) {
    samewith($parameters, $cancellable, &callback, $user_data);
  }
  multi method trust_prompt (
    ENamedParameters() $parameters,
    GCancellable()     $cancellable,
                       &callback,
    gpointer           $user_data    = gpointer
  ) {
    e_backend_trust_prompt(
      $!eb,
      $parameters,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method trust_prompt_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_backend_trust_prompt_finish($!eb, $result, $error);
    set_error($error);
    $rv;
  }

  method trust_prompt_sync (
    ENamedParameters()      $parameters,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $r = ETrustPromptResponseEnum(
      e_backend_trust_prompt_sync($!eb, $parameters, $cancellable, $error)
    );
    set_error($error);
    $r;
  }

}
