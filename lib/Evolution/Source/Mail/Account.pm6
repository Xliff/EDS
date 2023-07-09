use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Source::Mail::Account;

use Evolution::Source::Backend;

our subset ESourceMailAccountAncestry is export of Mu
  where ESourceMailAccount | ESourceBackendAncestry;

class Evolution::Source::Mail::Account is Evolution::Source::Backend {
  has ESourceMailAccount $!esm;

  submethod BUILD ( :$mail-account ) {
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
    is also<ESourceMailAccount>
  { $!esm }

  multi method new (ESourceMailAccountAncestry $mail-account, :$ref = True) {
    return Nil unless $mail-account;

    my $o = self.bless( :$mail-account );
    $o.ref if $ref;
    $o;
  }

  method archive_folder is rw is g-property is also<archive-folder> {
    Proxy.new:
      FETCH => -> $     { self.get_archive_folder    },
      STORE => -> $, \v { self.set_archive_folder(v) }
  }

  method identity_uid is rw is g-property is also<identity-uid> {
    Proxy.new:
      FETCH => -> $     { self.get_identity_uid    },
      STORE => -> $, \v { self.set_identity_uid(v) }
  }

  method mark_seen is rw is g-property is also<mark-seen> {
    Proxy.new:
      FETCH => -> $     { self.get_mark_seen    },
      STORE => -> $, \v { self.set_mark_seen(v) }
  }

  method mark_seen_timeout is rw is g-property is also<mark-seen-timeout> {
    Proxy.new:
      FETCH => -> $     { self.get_mark_seen_timeout    },
      STORE => -> $, \v { self.set_mark_seen_timeout(v) }
  }

  method needs_initial_setup
    is rw
    is g-property
    is also<needs-initial-setup>
  {
    Proxy.new:
      FETCH => -> $     { self.get_needs_initial_setup    },
      STORE => -> $, \v { self.set_needs_initial_setup(v) }
  }

  method dup_archive_folder is also<dup-archive-folder> {
     e_source_mail_account_dup_archive_folder($!esm);
   }

   method dup_identity_uid is also<dup-identity-uid> {
     e_source_mail_account_dup_identity_uid($!esm);
   }

   method get_archive_folder is also<get-archive-folder> {
     e_source_mail_account_get_archive_folder($!esm);
   }

   method get_identity_uid is also<get-identity-uid> {
     e_source_mail_account_get_identity_uid($!esm);
   }

   method get_mark_seen is also<get-mark-seen> {
     EThreeStateEnum( e_source_mail_account_get_mark_seen($!esm) );
   }

   method get_mark_seen_timeout is also<get-mark-seen-timeout> {
     e_source_mail_account_get_mark_seen_timeout($!esm);
   }

   method get_needs_initial_setup is also<get-needs-initial-setup> {
     e_source_mail_account_get_needs_initial_setup($!esm);
   }

   method get_type is also<get-type> {
     state ($n, $t);

     unstable_get_type(
       self.^name,
       &e_source_mail_account_get_type,
       $n,
       $t
     );
   }

   method set_archive_folder (Str() $archive_folder)
     is also<set-archive-folder>
   {
     e_source_mail_account_set_archive_folder($!esm, $archive_folder);
   }

   method set_identity_uid (Str() $identity_uid) is also<set-identity-uid> {
     e_source_mail_account_set_identity_uid($!esm, $identity_uid);
   }

   method set_mark_seen (Int() $mark_seen) is also<set-mark-seen> {
     my EThreeState $m = $mark_seen;

     e_source_mail_account_set_mark_seen($!esm, $m);
   }

   method set_mark_seen_timeout (Int() $timeout)
     is also<set-mark-seen-timeout>
   {
     my gint $t = $timeout;

     e_source_mail_account_set_mark_seen_timeout($!esm, $t);
   }

   method set_needs_initial_setup (Int() $needs_initial_setup)
     is also<set-needs-initial-setup>
   {
     my gboolean $n = $needs_initial_setup.so.Int;

     e_source_mail_account_set_needs_initial_setup($!esm, $n);
   }

 }
