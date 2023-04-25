use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Credentials;

use GLib::GSList;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

our subset ECredentialsAncestry is export of Mu
  where ECredentials | GObject;

class Evolution::Credentials {
  also does Associative;
  also does GLib::Roles::Object;

  has ECredentials $!eds-ec is implementor;

  submethod BUILD ( :$e-credentials ) {
    self.setECredentials($e-credentials) if $e-credentials
  }

  method setECredentials (ECredentialsAncestry $_) {
    my $to-parent;

    $!eds-ec = do {
      when ECredentials {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ECredentials, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::ECredentials
    is also<ECredentials>
  { $!eds-ec }

  multi method new (
    $e-credentials where * ~~ ECredentialsAncestry,

    :$ref = True
  ) {
    return unless $e-credentials;

    my $o = self.bless( :$e-credentials );
    $o.ref if $ref;
    $o;
  }

  method AT-KEY (Str() \k) is rw is also<AT_KEY> {
    Proxy.new:
      FETCH => -> $           { self.get(k)    }
      STORE => -> $, Str() \v { self.set(k, v) };
  }

  method EXISTS-KEY (Str() \k) is also<EXISTS_KEY> {
    self.has_key(k)
  }

  method clear {
    e_credentials_clear($!eds-ec);
  }

  method clear_peek is also<clear-peek> {
    e_credentials_clear_peek($!eds-ec);
  }

  method equal (ECredentials() $credentials2) {
    so e_credentials_equal($!eds-ec, $credentials2);
  }

  method equal_keys (ECredentials() $credentials2, Str() $key1)
    is also<equal-keys>
  {
    so e_credentials_equal_keys($!eds-ec, $credentials2, $key1);
  }

  method free {
    e_credentials_free($!eds-ec);
  }

  method get (Str() $key) {
    e_credentials_get($!eds-ec, $key);
  }

  method has_key (Str() $key) is also<has-key> {
    so e_credentials_has_key($!eds-ec, $key);
  }

  method keys_size is also<keys-size> {
    e_credentials_keys_size($!eds-ec);
  }

  method list_keys ( :$raw = False, :gslist(:$glist) = False )
    is also<list-keys>
  {
    returnGSList(
      e_credentials_list_keys($!eds-ec),
      $raw,
      $glist,
      Str
    );
  }

  method peek (Str() $key) {
    e_credentials_peek($!eds-ec, $key);
  }

  method set (Str() $key, Str() $value) {
    e_credentials_set($!eds-ec, $key, $value);
  }

  method to_strv is also<to-strv> {
    e_credentials_to_strv($!eds-ec);
  }

  # cw: Handling for these not yet known.
  method util_prompt_flags_to_string is also<util-prompt-flags-to-string> {
    e_credentials_util_prompt_flags_to_string($!eds-ec);
  }

  method util_safe_free_string (Str() $str)
    is also<util-safe-free-string>
    is static
  {
    e_credentials_util_safe_free_string($str);
  }

  method util_string_to_prompt_flags (Str() $flags)
    is also<util-string-to-prompt-flags>
    is static
  {
    e_credentials_util_string_to_prompt_flags($flags);
  }

}
