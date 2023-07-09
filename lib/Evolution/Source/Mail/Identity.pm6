use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Source::Mail::Identity;

use Evolution::Source::Extension;

our subset ESourceMailIdentityAncestry is export of Mu
  where ESourceMailIdentity | ESourceExtensionAncestry;

class Evolution::Source::Mail::Identity is Evolution::Source::Extension {
  has ESourceMailIdentity $!esi;

  submethod BUILD (:$mail-identity) {
    self.setESourceMailIdentity($mail-identity) if $mail-identity;
  }

  method setESourceMailIdentity (ESourceMailIdentityAncestry $_) {
    my $to-parent;

    $!esi = do {
      when ESourceMailIdentity {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceMailIdentity, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceMailIdentity
    is also<ESourceMailIdentity>
  { $!esi }

  method new (
    ESourceMailIdentityAncestry $mail-identity,
                                :$ref           = True
  ) {
    return Nil unless $mail-identity;

    my $o = self.bless( :$mail-identity );
    $o.ref if $ref;
    $o;
  }

  method address is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_address    },
      STORE => -> $, \v { self.set_address(v) }
  }

  method aliases is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_aliases    },
      STORE => -> $, \v { self.set_aliases(v) }
  }

  method name is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_name    },
      STORE => -> $, \v { self.set_name(v) }
  }

  method organization is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_organization    },
      STORE => -> $, \v { self.set_organization(v) }
  }

  method reply_to is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_reply_to    },
      STORE => -> $, \v { self.set_reply_to(v) }
  }

  method signature_uid is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_signature_uid    },
      STORE => -> $, \v { self.set_signature_uid(v) }
  }

  method dup_address is also<dup-address> {
    e_source_mail_identity_dup_address($!esi);
  }

  method dup_aliases is also<dup-aliases> {
    e_source_mail_identity_dup_aliases($!esi);
  }

  method dup_name is also<dup-name> {
    e_source_mail_identity_dup_name($!esi);
  }

  method dup_organization is also<dup-organization> {
    e_source_mail_identity_dup_organization($!esi);
  }

  method dup_reply_to is also<dup-reply-to> {
    e_source_mail_identity_dup_reply_to($!esi);
  }

  method dup_signature_uid is also<dup-signature-uid> {
    e_source_mail_identity_dup_signature_uid($!esi);
  }

  method get_address is also<get-address> {
    e_source_mail_identity_get_address($!esi);
  }

  method get_aliases is also<get-aliases> {
    e_source_mail_identity_get_aliases($!esi);
  }

  method get_aliases_as_hash_table is also<get-aliases-as-hash-table> {
    e_source_mail_identity_get_aliases_as_hash_table($!esi);
  }

  method get_name is also<get-name> {
    e_source_mail_identity_get_name($!esi);
  }

  method get_organization is also<get-organization> {
    e_source_mail_identity_get_organization($!esi);
  }

  method get_reply_to is also<get-reply-to> {
    e_source_mail_identity_get_reply_to($!esi);
  }

  method get_signature_uid is also<get-signature-uid> {
    e_source_mail_identity_get_signature_uid($!esi);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_mail_identity_get_type,
      $n,
      $t
    );
  }

  method set_address (Str() $address) is also<set-address> {
    e_source_mail_identity_set_address($!esi, $address);
  }

  method set_aliases (Str() $aliases) is also<set-aliases> {
    e_source_mail_identity_set_aliases($!esi, $aliases);
  }

  method set_name (Str() $name) is also<set-name> {
    e_source_mail_identity_set_name($!esi, $name);
  }

  method set_organization (Str() $organization) is also<set-organization> {
    e_source_mail_identity_set_organization($!esi, $organization);
  }

  method set_reply_to (Str() $reply_to) is also<set-reply-to> {
    e_source_mail_identity_set_reply_to($!esi, $reply_to);
  }

  method set_signature_uid (Str() $signature_uid) is also<set-signature-uid> {
    e_source_mail_identity_set_signature_uid($!esi, $signature_uid);
  }

}
