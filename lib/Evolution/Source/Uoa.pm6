use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Extension;

our subset ESourceUoaAncestry is export of Mu
  where ESourceUoa | ESourceExtensionAncestry;

class Evoluton::Source::UOA is Evolution::Source::Extension {
  has ESourceUoa $!esu;

  submethod BUILD (:$uoa) {
    self.setESourceUoa($uoa) if $uoa;
  }

  method setESourceUoa (ESourceUoaAncestry $_) {
    my $to-parent;

    $!esu = do {
      when ESourceUoa {
        $to-parent = cast(ESourceExtension, $_);
          $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceUoa, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceUoa
  { $!esu }

  method new (
    ESourceUoaAncestry $uoa,
                       :$ref   = True
  ) {
    return Nil unless $uoa;

    my $o = self.bless( :$uoa );
    $o.ref if $ref;
    $o;
  }

  method account_id is rw {
    Proxy.new:
      FETCH => -> $     { self.get_account_id    },
      STORE => -> $, \v { self.set_account_id(v) }
  }

  method get_account_id {
    e_source_uoa_get_account_id($!esu);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_uoa_get_type, $n, $t );
  }

  method set_account_id (Int() $account_id) {
    my guint $a = $account_id;

    e_source_uoa_set_account_id($!esu, $a);
  }

}

### /usr/include/evolution-data-server/libedataserver/e-source-uoa.h

sub e_source_uoa_get_account_id (ESourceUoa $extension)
  returns guint
  is native(eds)
  is export
{ * }

sub e_source_uoa_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_uoa_set_account_id (ESourceUoa $extension, guint $account_id)
  is native(eds)
  is export
{ * }
