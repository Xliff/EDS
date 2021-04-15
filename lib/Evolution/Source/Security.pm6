use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Security;

use Evolution::Source::Extension;

our subset ESourceSecurityAncestry is export of Mu
  where ESourceSecurity | ESourceExtensionAncestry;

class Evolution::Source::Security is Evolution::Source::Extension {
  has ESourceSecurity $!essec;

  submethod BUILD (:$security) {
    self.setESourceSecurity($security) if $security;
  }

  method setESourceSecurity (ESourceSecurityAncestry $_) {
    my $to-parent;

    $!essec = do {
      when ESourceSecurity {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceSecurity, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceSecurity
  { $!essec }

  method new (
    ESourceSecurityAncestry $security,
                            :$ref   = True
  ) {
    return Nil unless $security;

    my $o = self.bless( :$security );
    $o.ref if $ref;
    $o;
  }

  method method is rw {
    Proxy.new:
      FETCH => -> $     { self.get_method    },
      STORE => -> $, \v { self.set_method(v) }
  }

  method secure is rw {
    Proxy.new:
      FETCH => -> $     { self.get_secure    },
      STORE => -> $, \v { self.set_secure(v) }
  }

  method dup_method {
    e_source_security_dup_method($!essec);
  }

  method get_method {
    e_source_security_get_method($!essec);
  }

  method get_secure {
    so e_source_security_get_secure($!essec);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_security_get_type,
      $n,
      $t
    );
  }

  method set_method (Str() $method) {
    e_source_security_set_method($!essec, $method);
  }

  method set_secure (Int() $secure) {
    my gboolean $s = $secure.so.Int;

    e_source_security_set_secure($!essec, $secure);
  }

}
