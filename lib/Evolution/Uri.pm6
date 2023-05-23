use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Uri;

# BOXED

use GLib::Roles::Implementor;

class Evolution::Uri {
  also does GLib::Roles::Implementor;

  has EUri $!eds-u is implementor handles<
    protocol
    user
    authmech
    passwd
    host
    port
    path
    query
    fragment
  >;

  submethod BUILD ( :$e-uri ) {
    $!eds-u = $e-uri if $e-uri;
  }

  method Evolution::Raw::Structs::EUri
    is also<EUri>
  { $!eds-u }

  multi method new (
    EUri $e-uri,

    # cw: U-G-L-Y spells...
    #     This-method-of-alias-specification-needs-serious-improvement!
    :euri(:e_uri(:e-uri(:$struct))) is required
  ) {
    $e-uri ?? self.bless( :$e-uri ) !! Nil;
  }
  multi method new (Str $uri, :string(:$str) is required) {
    my $e-uri = e_uri_new($uri);

    $e-uri ?? self.bless( :$e-uri ) !! Nil;
  }
  multi method new ($uri) {
    do given $uri {
      when .can('EUri') { $_ = .EUri  ; proceed }
      when .can('Str')  { $_ = .Str   ; proceed }

      when EUri         { self.new($_, :struct) }
      when Str          { self.new($_, :string) }

      default {
        # cw: Change to typed exception!
        die "Do not know how to create a Evolution::Uri from { .^name }!"
      }
    }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      e_uri_copy($!eds-u),
      $raw,
      |self.getTypePair
    );
  }

  method !free {
    e_uri_free($!eds-u);
  }

  method get_param (Str() $name) is also<get-param> {
    e_uri_get_param($!eds-u, $name);
  }

  method to_string (Int() $show_password) is also<to-string> {
    my gboolean $s = $show_password.so.Int;

    e_uri_to_string($!eds-u, $s);
  }

  method url_equal (Str() $url1, Str() $url2) is static is also<url-equal> {
    so e_url_equal($url1, $url2);
  }

  method url_shroud (Str() $url) is static is also<url-shroud> {
    e_url_shroud($url);
  }

  # Associative-like
  method keys   { self.Map.keys    }
  method values { self.Map.values  }
  method pairs  { self.Map.pairs   }

  # Coercive
  method Str    { self.to_string }
  method Map    { $!eds-u.Map    }
  method Hash   { self.Map       }
}
