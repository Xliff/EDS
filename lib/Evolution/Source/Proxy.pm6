use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Proxy;

use Evolution::Source::Extension;

our subset ESourceProxyAncestry is export of Mu
  where ESourceProxy | ESourceExtensionAncestry;

class Evolution::Source::Proxy is Evolution::Source::Extension {
  has ESourceProxy $!esp;

  submethod BUILD (:$proxy) {
    self.setESourceProxy($proxy) if $proxy;
  }

  method setESourceProxy (ESourceProxyAncestry $_) {
    my $to-parent;

    $!esp = do {
      when ESourceProxy {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceProxy, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceProxy
  { $!esp }

  method new (
    ESourceProxyAncestry $proxy,
                         :$ref           = True
  ) {
    return Nil unless $proxy;

    my $o = self.bless( :$proxy );
    $o.ref if $ref;
    $o;
  }

  method autoconfig_url is rw {
    Proxy.new:
      FETCH => -> $     { self.get_autoconfig_url    },
      STORE => -> $, \v { self.set_autoconfig_url(v) }
  }

  method ftp_host is rw {
    Proxy.new:
      FETCH => -> $     { self.get_ftp_host    },
      STORE => -> $, \v { self.set_ftp_host(v) }
  }

  method ftp_port is rw {
    Proxy.new:
      FETCH => -> $     { self.get_ftp_port    },
      STORE => -> $, \v { self.set_ftp_port(v) }
  }

  method http_auth_password is rw {
    Proxy.new:
      FETCH => -> $     { self.get_http_auth_password    },
      STORE => -> $, \v { self.set_http_auth_password(v) }
  }

  method http_auth_user is rw {
    Proxy.new:
      FETCH => -> $     { self.get_http_auth_user    },
      STORE => -> $, \v { self.set_http_auth_user(v) }
  }

  method http_host is rw {
    Proxy.new:
      FETCH => -> $     { self.get_http_host    },
      STORE => -> $, \v { self.set_http_host(v) }
  }

  method http_port is rw {
    Proxy.new:
      FETCH => -> $     { self.get_http_port    },
      STORE => -> $, \v { self.set_http_port(v) }
  }

  method http_use_auth is rw {
    Proxy.new:
      FETCH => -> $     { self.get_http_use_auth    },
      STORE => -> $, \v { self.set_http_use_auth(v) }
  }

  method https_host is rw {
    Proxy.new:
      FETCH => -> $     { self.get_https_host    },
      STORE => -> $, \v { self.set_https_host(v) }
  }

  method https_port is rw {
    Proxy.new:
      FETCH => -> $     { self.get_https_port    },
      STORE => -> $, \v { self.set_https_port(v) }
  }

  method ignore_hosts is rw {
    Proxy.new:
      FETCH => -> $     { self.get_ignore_hosts    },
      STORE => -> $, \v { self.set_ignore_hosts(v) }
  }

  method method is rw {
    Proxy.new:
      FETCH => -> $     { self.get_method    },
      STORE => -> $, \v { self.set_method(v) }
  }

  method socks_host is rw {
    Proxy.new:
      FETCH => -> $     { self.get_socks_host    },
      STORE => -> $, \v { self.set_socks_host(v) }
  }

  method socks_port is rw {
    Proxy.new:
      FETCH => -> $     { self.get_socks_port    },
      STORE => -> $, \v { self.set_socks_port(v) }
  }

  method dup_autoconfig_url {
    e_source_proxy_dup_autoconfig_url($!esp);
  }

  method dup_ftp_host {
    e_source_proxy_dup_ftp_host($!esp);
  }

  method dup_http_auth_password {
    e_source_proxy_dup_http_auth_password($!esp);
  }

  method dup_http_auth_user {
    e_source_proxy_dup_http_auth_user($!esp);
  }

  method dup_http_host {
    e_source_proxy_dup_http_host($!esp);
  }

  method dup_https_host {
    e_source_proxy_dup_https_host($!esp);
  }

  method dup_ignore_hosts {
    e_source_proxy_dup_ignore_hosts($!esp);
  }

  method dup_socks_host {
    e_source_proxy_dup_socks_host($!esp);
  }

  method get_autoconfig_url {
    e_source_proxy_get_autoconfig_url($!esp);
  }

  method get_ftp_host {
    e_source_proxy_get_ftp_host($!esp);
  }

  method get_ftp_port {
    e_source_proxy_get_ftp_port($!esp);
  }

  method get_http_auth_password {
    e_source_proxy_get_http_auth_password($!esp);
  }

  method get_http_auth_user {
    e_source_proxy_get_http_auth_user($!esp);
  }

  method get_http_host {
    e_source_proxy_get_http_host($!esp);
  }

  method get_http_port {
    e_source_proxy_get_http_port($!esp);
  }

  method get_http_use_auth {
    so e_source_proxy_get_http_use_auth($!esp);
  }

  method get_https_host {
    e_source_proxy_get_https_host($!esp);
  }

  method get_https_port {
    e_source_proxy_get_https_port($!esp);
  }

  method get_ignore_hosts {
    so e_source_proxy_get_ignore_hosts($!esp);
  }

  method get_method {
    EProxyMethodEnum( e_source_proxy_get_method($!esp) );
  }

  method get_socks_host {
    e_source_proxy_get_socks_host($!esp);
  }

  method get_socks_port {
    e_source_proxy_get_socks_port($!esp);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_proxy_get_type,
      $n,
      $t
    );
  }

  multi method lookup (
    Str()          $uri,
                   &callback (ESource, GAsyncResult, gpointer),
    gpointer       $user_data                                   = gpointer,
    GCancellable() :$cancellable                                = GCancellable
  ) {
    samewith(
      $uri,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method lookup (
    Str()          $uri,
    GCancellable() $cancellable,
                   &callback (ESource, GAsyncResult, gpointer),
    gpointer       $user_data
  ) {
    e_source_proxy_lookup($!esp, $uri, $cancellable, &callback, $user_data);
  }

  method lookup_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
                            :$raw    = False
  ) {
    clear_error;
    my $ca = so e_source_proxy_lookup_finish($!esp, $result, $error);
    set_error($error);
    return $ca if $raw;

    my @a = CArrayToArray($ca);
    free( cast(Pointer, $ca) );
    @a;
  }

  method lookup_sync (
    Str()                   $uri,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror,
                            :$raw        = False
  ) {
    clear_error;
    my $ca = e_source_proxy_lookup_sync($!esp, $uri, $cancellable, $error);
    set_error($error);
    return $ca if $raw;

    my @a = CArrayToArray($ca);
    free( cast(Pointer, $ca) );
    @a;
  }

  method set_autoconfig_url (Str() $autoconfig_url) {
    e_source_proxy_set_autoconfig_url($!esp, $autoconfig_url);
  }

  method set_ftp_host (Str() $ftp_host) {
    e_source_proxy_set_ftp_host($!esp, $ftp_host);
  }

  method set_ftp_port (Int() $ftp_port) {
    my guint16 $f = $ftp_port;

    e_source_proxy_set_ftp_port($!esp, $f);
  }

  method set_http_auth_password (Str() $http_auth_password) {
    e_source_proxy_set_http_auth_password($!esp, $http_auth_password);
  }

  method set_http_auth_user (Str() $http_auth_user) {
    e_source_proxy_set_http_auth_user($!esp, $http_auth_user);
  }

  method set_http_host (Str() $http_host) {
    e_source_proxy_set_http_host($!esp, $http_host);
  }

  method set_http_port (Int() $http_port) {
    my guint16 $h = $http_port;

    e_source_proxy_set_http_port($!esp, $h);
  }

  method set_http_use_auth (Int() $http_use_auth) {
    my gboolean $h = $http_use_auth.so.Int;

    e_source_proxy_set_http_use_auth($!esp, $h);
  }

  method set_https_host (Str() $https_host) {
    e_source_proxy_set_https_host($!esp, $https_host);
  }

  method set_https_port (Int() $https_port) {
    my guint16 $h = $https_port;

    e_source_proxy_set_https_port($!esp, $https_port);
  }

  method set_ignore_hosts (Str() $ignore_hosts) {
    e_source_proxy_set_ignore_hosts($!esp, $ignore_hosts);
  }

  method set_method (Int() $method) {
    my EProxyMethod $m = $method;

    e_source_proxy_set_method($!esp, $m);
  }

  method set_socks_host (Str() $socks_host) {
    e_source_proxy_set_socks_host($!esp, $socks_host);
  }

  method set_socks_port (Int() $socks_port) {
    my guint16 $s = $socks_port;

    e_source_proxy_set_socks_port($!esp, $s);
  }

}
