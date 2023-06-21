use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::MailIdentity;

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

  method dup_address {
    e_source_mail_identity_dup_address($!esi);
  }

  method dup_aliases {
    e_source_mail_identity_dup_aliases($!esi);
  }

  method dup_name {
    e_source_mail_identity_dup_name($!esi);
  }

  method dup_organization {
    e_source_mail_identity_dup_organization($!esi);
  }

  method dup_reply_to {
    e_source_mail_identity_dup_reply_to($!esi);
  }

  method dup_signature_uid {
    e_source_mail_identity_dup_signature_uid($!esi);
  }

  method get_address {
    e_source_mail_identity_get_address($!esi);
  }

  method get_aliases {
    e_source_mail_identity_get_aliases($!esi);
  }

  method get_aliases_as_hash_table {
    e_source_mail_identity_get_aliases_as_hash_table($!esi);
  }

  method get_name {
    e_source_mail_identity_get_name($!esi);
  }

  method get_organization {
    e_source_mail_identity_get_organization($!esi);
  }

  method get_reply_to {
    e_source_mail_identity_get_reply_to($!esi);
  }

  method get_signature_uid {
    e_source_mail_identity_get_signature_uid($!esi);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_mail_identity_get_type,
      $n,
      $t
    );
  }

  method set_address (Str() $address) {
    e_source_mail_identity_set_address($!esi, $address);
  }

  method set_aliases (Str() $aliases) {
    e_source_mail_identity_set_aliases($!esi, $aliases);
  }

  method set_name (Str() $name) {
    e_source_mail_identity_set_name($!esi, $name);
  }

  method set_organization (Str() $organization) {
    e_source_mail_identity_set_organization($!esi, $organization);
  }

  method set_reply_to (Str() $reply_to) {
    e_source_mail_identity_set_reply_to($!esi, $reply_to);
  }

  method set_signature_uid (Str() $signature_uid) {
    e_source_mail_identity_set_signature_uid($!esi, $signature_uid);
  }

}
