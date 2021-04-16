use v6.c;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Source::Extension;

our subset ESourceMDNAncestry is export of Mu
  where ESourceMDN | ESourceExtensionAncestry;

class Evolution::Source::MDN is Evolution::Source::Extension {
  has ESourceMDN $!esm;

  submethod BUILD (:$MDN) {
    self.setESourceMDN($MDN) if $MDN;
  }

  method setESourceMDN (ESourceMDNAncestry $_) {
    my $to-parent;

    $!esm = do {
      when ESourceMDN {
        $to-parent = cast(ESourceExtension, $_);
          $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceMDN, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceMDN
  { $!esm }

  method new (
    ESourceMDNAncestry $MDN,
                       :$ref   = True
  ) {
    return Nil unless $MDN;

    my $o = self.bless( :$MDN );
    $o.ref if $ref;
    $o;
  }

  method get_response_policy {
    EMdnResponsePolicyEnum( e_source_mdn_get_response_policy($!esm) );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_source_mdn_get_type, $n, $t );
  }

  method set_response_policy (Int() $response_policy) {
    my EMdnResponsePolicy $r = $response_policy;

    e_source_mdn_set_response_policy($!esm, $r);
  }


}


### /usr/include/evolution-data-server/libedataserver/e-source-mdn.h

sub e_source_mdn_get_response_policy (ESourceMDN $extension)
  returns EMdnResponsePolicy
  is native(eds)
  is export
{ * }

sub e_source_mdn_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_mdn_set_response_policy (
  ESourceMDN         $extension,
  EMdnResponsePolicy $response_policy
)
  is native(eds)
  is export
{ * }
