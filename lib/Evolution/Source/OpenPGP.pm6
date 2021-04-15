use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::OpenPGP;

use Evolution::Source::Extension;

our subset ESourceOpenPGPAncestry is export of Mu
  where ESourceOpenPGP | ESourceExtensionAncestry;

class Evolution::Source::OpenPGP is Evolution::Source::Extension {
  has ESourceOpenPGP $!esp;

  submethod BUILD (:$openpgp) {
    self.setESourceOpenPGP($openpgp) if $openpgp;
  }

  method setESourceOpenPGP (ESourceOpenPGPAncestry $_) {
    my $to-parent;

    $!esp = do {
      when ESourceOpenPGP {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceOpenPGP, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceOpenPGP
  { $!esp }

  method new (
    ESourceOpenPGPAncestry $openpgp,
                           :$ref           = True
  ) {
    return Nil unless $openpgp;

    my $o = self.bless( :$openpgp );
    $o.ref if $ref;
    $o;
  }

  method always_trust is rw {
    Proxy.new:
      FETCH => -> $     { self.get_always_trust    },
      STORE => -> $, \v { self.set_always_trust(v) }
  }

  method encrypt_by_default is rw {
    Proxy.new:
      FETCH => -> $     { self.get_encrypt_by_default    },
      STORE => -> $, \v { self.set_encrypt_by_default(v) }
  }

  method encrypt_to_self is rw {
    Proxy.new:
      FETCH => -> $     { self.get_encrypt_to_self    },
      STORE => -> $, \v { self.set_encrypt_to_self(v) }
  }

  method key_id is rw {
    Proxy.new:
      FETCH => -> $     { self.get_key_id    },
      STORE => -> $, \v { self.set_key_id(v) }
  }

  method prefer_inline is rw {
    Proxy.new:
      FETCH => -> $     { self.get_prefer_inline    },
      STORE => -> $, \v { self.set_prefer_inline(v) }
  }

  method sign_by_default is rw {
    Proxy.new:
      FETCH => -> $     { self.get_sign_by_default    },
      STORE => -> $, \v { self.set_sign_by_default(v) }
  }

  method signing_algorithm is rw {
    Proxy.new:
      FETCH => -> $     { self.get_signing_algorithm    },
      STORE => -> $, \v { self.set_signing_algorithm(v) }
  }

  method dup_key_id {
    e_source_openpgp_dup_key_id($!esp);
  }

  method dup_signing_algorithm {
    e_source_openpgp_dup_signing_algorithm($!esp);
  }

  method get_always_trust {
    so e_source_openpgp_get_always_trust($!esp);
  }

  method get_encrypt_by_default {
    so e_source_openpgp_get_encrypt_by_default($!esp);
  }

  method get_encrypt_to_self {
    so e_source_openpgp_get_encrypt_to_self($!esp);
  }

  method get_key_id {
    e_source_openpgp_get_key_id($!esp);
  }

  method get_prefer_inline {
    so e_source_openpgp_get_prefer_inline($!esp);
  }

  method get_sign_by_default {
    so e_source_openpgp_get_sign_by_default($!esp);
  }

  method get_signing_algorithm {
    e_source_openpgp_get_signing_algorithm($!esp);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_openpgp_get_type,
      $n,
      $t
    );
  }

  method set_always_trust (Int() $always_trust) {
    my gboolean $a = $always_trust.so.Int;

    e_source_openpgp_set_always_trust($!esp, $a);
  }

  method set_encrypt_by_default (Int() $encrypt_by_default) {
    my gboolean $e = $encrypt_by_default.so.Int;

    e_source_openpgp_set_encrypt_by_default($!esp, $e);
  }

  method set_encrypt_to_self (Int() $encrypt_to_self) {
    my gboolean $e = $encrypt_to_self.so.Int;

    e_source_openpgp_set_encrypt_to_self($!esp, $e);
  }

  method set_key_id (Str() $key_id) {
    e_source_openpgp_set_key_id($!esp, $key_id);
  }

  method set_prefer_inline (Int() $prefer_inline) {
    my gboolean $p = $prefer_inline.so.Int;

    e_source_openpgp_set_prefer_inline($!esp, $p);
  }

  method set_sign_by_default (Int() $sign_by_default) {
    my gboolean $s = $sign_by_default.so.Int;

    e_source_openpgp_set_sign_by_default($!esp, $s);
  }

  method set_signing_algorithm (Str() $signing_algorithm) {
    e_source_openpgp_set_signing_algorithm($!esp, $signing_algorithm);
  }

}
