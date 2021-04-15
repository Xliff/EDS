use v6.c

use Evolution::Raw::Types;
use Evolution::Raw::Source::SMIME;

use Evolution::Source::Extension;

our subset ESourceSMIMEAncestry is export of Mu
  where ESourceSMIME | ESourceExtensionAncestry;

class Evolution::Source::SMIME is Evolution::Source::Extension {
  has ESourceSMIME $!esm;

  submethod BUILD (:$smime) {
    self.setESourceSMIME($smime) if $smime;
  }

  method setESourceSMIME (ESourceSMIMEAncestry $_) {
    my $to-parent;

    $!esm = do {
      when ESourceSMIME {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceSMIME, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceSMIME
  { $!esm }

  method new (
    ESourceSMIMEAncestry $smime,
                         :$ref   = True
  ) {
    return Nil unless $smime;

    my $o = self.bless( :$smime );
    $o.ref if $ref;
    $o;
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

  method encryption_certificate is rw {
    Proxy.new:
      FETCH => -> $     { self.get_encryption_certificate    },
      STORE => -> $, \v { self.set_encryption_certificate(v) }
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

  method signing_certificate is rw {
    Proxy.new:
      FETCH => -> $     { self.get_signing_certificate    },
      STORE => -> $, \v { self.set_signing_certificate(v) }
  }

  method dup_encryption_certificate {
    e_source_smime_dup_encryption_certificate($!esm);
  }

  method dup_signing_algorithm {
    e_source_smime_dup_signing_algorithm($!esm);
  }

  method dup_signing_certificate {
    e_source_smime_dup_signing_certificate($!esm);
  }

  method get_encrypt_by_default {
    so e_source_smime_get_encrypt_by_default($!esm);
  }

  method get_encrypt_to_self {
    e_source_smime_get_encrypt_to_self($!esm);
  }

  method get_encryption_certificate {
    e_source_smime_get_encryption_certificate($!esm);
  }

  method get_sign_by_default {
    so e_source_smime_get_sign_by_default($!esm);
  }

  method get_signing_algorithm {
    e_source_smime_get_signing_algorithm($!esm);
  }

  method get_signing_certificate {
    e_source_smime_get_signing_certificate($!esm);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_smime_get_type, $n, $t );
  }

  method set_encrypt_by_default (Int() $encrypt_by_default) {
    my gboolean $e = $encrypt_by_default.so.Int;

    e_source_smime_set_encrypt_by_default($!esm, $e);
  }

  method set_encrypt_to_self (Int() $encrypt_to_self) {
    my gboolean $e = $encrypt_to_self.so.Int;

    e_source_smime_set_encrypt_to_self($!esm, $e);
  }

  method set_encryption_certificate (Str() $encryption_certificate) {
    e_source_smime_set_encryption_certificate($!esm, $encryption_certificate);
  }

  method set_sign_by_default (Int() $sign_by_default) {
    my gboolean $s = $sign_by_default.so.Int;

    e_source_smime_set_sign_by_default($!esm, $s);
  }

  method set_signing_algorithm (Str() $signing_algorithm) {
    e_source_smime_set_signing_algorithm($!esm, $signing_algorithm);
  }

  method set_signing_certificate (Str() $signing_certificate) {
    e_source_smime_set_signing_certificate($!esm, $signing_certificate);
  }

}
