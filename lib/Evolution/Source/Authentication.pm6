use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Authentication;

use Evolution::Source::Extension;

our subset ESourceAuthenticationAncestry is export of Mu
  where ESourceAuthentication | ESourceExtensionAncestry;

class Evolution::Source::Authentication is Evolution::Source::Extension {
  has ESourceAuthentication $!esa is implementor;

  submethod BUILD (:$authentication) {
    self.setESourceAuthentication($authentication) if $authentication;
  }

  method setESourceAuthentication (ESourceAuthenticationAncestry $_) {
    my $to-parent;

    $!esa = do {
      when ESourceAuthentication {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceAuthentication, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method EDS::Raw::Definitions::ESourceAuthentication
  { $!esa }

  method new (
    ESourceAuthenticationAncestry $authentication,
                                  :$ref            = True
  ) {
    return Nil unless $authentication;

    my $o = self.bless( :$authentication );
    $o.ref if $ref;
    $o;
  }

  method credential_name is rw {
    Proxy.new:
      FETCH => -> $     { self.get_credential_name           },
      STORE => -> $, \v { self.set_credential_name($!esa, v) }
  }

  method host is rw {
    Proxy.new:
      FETCH => -> $     { self.get_host           },
      STORE => -> $, \v { self.set_host($!esa, v) }
  }

  method is_external is rw {
    Proxy.new:
      FETCH => -> $     { self.get_is_external           },
      STORE => -> $, \v { self.set_is_external($!esa, v) }
  }

  method method is rw {
    Proxy.new:
      FETCH => -> $     { self.get_method           },
      STORE => -> $, \v { self.set_method($!esa, v) }
  }

  method port is rw {
    Proxy.new:
      FETCH => -> $     { self.get_port           },
      STORE => -> $, \v { self.set_port($!esa, v) }
  }

  method proxy_uid is rw {
    Proxy.new:
      FETCH => -> $     { self.get_proxy_uid           },
      STORE => -> $, \v { self.set_proxy_uid($!esa, v) }
  }

  method remember_password is rw {
    Proxy.new:
      FETCH => -> $     { self.get_remember_password           },
      STORE => -> $, \v { self.set_remember_password($!esa, v) }
  }

  method user is rw {
    Proxy.new:
      FETCH => -> $     { self.get_user           },
      STORE => -> $, \v { self.set_user($!esa, v) }
  }

  method dup_credential_name {
    e_source_authentication_dup_credential_name($!esa);
  }

  method dup_host {
    e_source_authentication_dup_host($!esa);
  }

  method dup_method {
    e_source_authentication_dup_method($!esa);
  }

  method dup_proxy_uid {
    e_source_authentication_dup_proxy_uid($!esa);
  }

  method dup_user {
    e_source_authentication_dup_user($!esa);
  }

  method get_credential_name {
    e_source_authentication_get_credential_name($!esa);
  }

  method get_host {
    e_source_authentication_get_host($!esa);
  }

  method get_is_external {
    e_source_authentication_get_is_external($!esa);
  }

  method get_method {
    e_source_authentication_get_method($!esa);
  }

  method get_port {
    e_source_authentication_get_port($!esa);
  }

  method get_proxy_uid {
    e_source_authentication_get_proxy_uid($!esa);
  }

  method get_remember_password {
    e_source_authentication_get_remember_password($!esa);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_authentication_get_type, $n, $t );
  }

  method get_user {
    e_source_authentication_get_user($!esa);
  }

  method ref_connectable (:$raw = False) {
    use GIO::Roles::SocketConnectable;

    my $s = e_source_authentication_ref_connectable($!esa);

    $s ??
      ( $raw ?? $s !! GIO::SocketConnectable.new($s) )
      !!
      Nil;
  }

  method required {
    e_source_authentication_required($!esa);
  }

  method set_credential_name (Str() $credential_name) {
    e_source_authentication_set_credential_name($!esa, $credential_name);
  }

  method set_host (Str() $host) {
    e_source_authentication_set_host($!esa, $host);
  }

  method set_is_external (Int() $is_external) {
    my gboolean $i = $is_external.so.Int;

    e_source_authentication_set_is_external($!esa, $i);
  }

  method set_method (Str() $method) {
    e_source_authentication_set_method($!esa, $method);
  }

  method set_port (Int() $port) {
    my guint16 $p = $port;

    e_source_authentication_set_port($!esa, $p);
  }

  method set_proxy_uid (Str() $proxy_uid) {
    e_source_authentication_set_proxy_uid($!esa, $proxy_uid);
  }

  method set_remember_password (Int() $remember_password) {
    my gboolean $r = $remember_password.so.Int;

    e_source_authentication_set_remember_password($!esa, $r);
  }

  method set_user (Str() $user) {
    e_source_authentication_set_user($!esa, $user);
  }
}
