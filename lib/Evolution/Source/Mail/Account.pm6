use Evolution::Raw::Types;
use Evolution::Raw::Source::Mail::Account;

use Evolution::Source::Backend;

our subset ESourceMailAccountAncestry is export of Mu
  where ESourceMailAccount | ESourceBackendAncestry;

class Evolution::Source::Mail::Account is Evolution::Source::Backend {
  has ESourceMailAccount $!esm;

  submethod BUILD (:$mail-account) {
    self.setESourceMailAccount($mail-account) if $mail-account;
  }

  method setESourceMailAccount (ESourceMailAccountAncestry $_) {
    my $to-parent;

    $!esm = do {
      when ESourceMailAccount {
        $to-parent = cast(ESourceBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceMailAccount, $_);
      }
    }
    self.setESourceBackend($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceMailAccount
  { $!esm }

  multi method new (ESourceMailAccountAncestry $mail-account, :$ref = True) {
    return Nil unless $mail-account;

    my $o = self.bless( :$mail-account );
    $o.ref if $ref;
    $o;
  }

  method dup_archive_folder {
     e_source_mail_account_dup_archive_folder($!esm);
   }

   method dup_identity_uid {
     e_source_mail_account_dup_identity_uid($!esm);
   }

   method get_archive_folder {
     e_source_mail_account_get_archive_folder($!esm);
   }

   method get_identity_uid {
     e_source_mail_account_get_identity_uid($!esm);
   }

   method get_mark_seen {
     EThreeStateEnum( e_source_mail_account_get_mark_seen($!esm) );
   }

   method get_mark_seen_timeout {
     e_source_mail_account_get_mark_seen_timeout($!esm);
   }

   method get_needs_initial_setup {
     e_source_mail_account_get_needs_initial_setup($!esm);
   }

   method get_type {
     state ($n, $t);

     unstable_get_type( self.^name, &e_source_mail_account_get_type, $n, $t );
   }

   method set_archive_folder (Str() $archive_folder) {
     e_source_mail_account_set_archive_folder($!esm, $archive_folder);
   }

   method set_identity_uid (Str() $identity_uid) {
     e_source_mail_account_set_identity_uid($!esm, $identity_uid);
   }

   method set_mark_seen (Int() $mark_seen) {
     my EThreeState $m = $mark_seen;

     e_source_mail_account_set_mark_seen($!esm, $m);
   }

   method set_mark_seen_timeout (Int() $timeout) {
     my gint $t = $timeout;

     e_source_mail_account_set_mark_seen_timeout($!esm, $t);
   }

   method set_needs_initial_setup (Int() $needs_initial_setup) {
     my gboolean $n = $needs_initial_setup.so.Int;

     e_source_mail_account_set_needs_initial_setup($!esm, $n);
   }

 }
