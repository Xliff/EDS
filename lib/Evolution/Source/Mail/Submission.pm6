use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Source::Mail::Submission;

use Evolution::Source::Extension;

our subset ESourceMailSubmissionAncestry is export of Mu
  where ESourceMailSubmission | ESourceExtensionAncestry;

class Evolution::Source::Mail::Submission is Evolution::Source::Extension {
  has ESourceMailSubmission $!esms;

  submethod BUILD (:$mail-submission) {
    self.setESourceMailSubmission($mail-submission) if $mail-submission;
  }

  method setESourceMailSubmission (ESourceMailSubmissionAncestry $_) {
    my $to-parent;

    $!esms = do {
      when ESourceMailSubmission {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceMailSubmission, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceMailSubmission
    is also<ESourceMailSubmission>
  { $!esms }

  method new (
    ESourceMailSubmissionAncestry $mail-submission,
                                  :$ref           = True
  ) {
    return Nil unless $mail-submission;

    my $o = self.bless( :$mail-submission );
    $o.ref if $ref;
    $o;
  }

  method replies_to_origin_folder
    is also<replies-to-origin-folder>
    is rw
    is g-property
  {
    Proxy.new:
      FETCH => -> $     { self.get_replies_to_origin_folder    },
      STORE => -> $, \v { self.set_replies_to_origin_folder(v) }
  }

  method sent_folder is also<sent-folder> is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_sent_folder    },
      STORE => -> $, \v { self.set_sent_folder(v) }
  }

  method transport_uid is also<transport-uid> is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_transport_uid    },
      STORE => -> $, \v { self.set_transport_uid(v) }
  }

  method use_sent_folder is also<use-sent-folder> is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_use_sent_folder    },
      STORE => -> $, \v { self.set_use_sent_folder(v) }
  }

  method dup_sent_folder is also<dup-sent-folder> {
    e_source_mail_submission_dup_sent_folder($!esms);
  }

  method dup_transport_uid is also<dup-transport-uid> {
    e_source_mail_submission_dup_transport_uid($!esms);
  }

  method get_replies_to_origin_folder is also<get-replies-to-origin-folder> {
    so e_source_mail_submission_get_replies_to_origin_folder($!esms);
  }

  method get_sent_folder is also<get-sent-folder> {
    e_source_mail_submission_get_sent_folder($!esms);
  }

  method get_transport_uid is also<get-transport-uid> {
    e_source_mail_submission_get_transport_uid($!esms);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_mail_submission_get_type,
      $n,
      $t
    );
  }

  method get_use_sent_folder is also<get-use-sent-folder> {
    so e_source_mail_submission_get_use_sent_folder($!esms);
  }

  method set_replies_to_origin_folder (Int() $replies_to_origin_folder)
    is also<set-replies-to-origin-folder>
  {
    my gboolean $r = $replies_to_origin_folder.so.Int;

    e_source_mail_submission_set_replies_to_origin_folder($!esms, $r);
  }

  method set_sent_folder (Str() $sent_folder) is also<set-sent-folder> {
    e_source_mail_submission_set_sent_folder($!esms, $sent_folder);
  }

  method set_transport_uid (Str() $transport_uid) is also<set-transport-uid> {
    e_source_mail_submission_set_transport_uid($!esms, $transport_uid);
  }

  method set_use_sent_folder (Int() $use_sent_folder)
    is also<set-use-sent-folder>
  {
    my gboolean $u = $use_sent_folder.so.Int;

    e_source_mail_submission_set_use_sent_folder($!esms, $u);
  }

}
