use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::Source::Mail::Composition;

use Evolution::Source::Extension;

our subset ESourceMailCompositionAncestry is export of Mu
  where ESourceMailComposition | ESourceExtensionAncestry;

class Evolution::Source::Mail::Composition
  is Evolution::Source::Extension
{
  has ESourceMailComposition $!esmc;

  submethod BUILD (:$mail-composition) {
    self.setESourceMailComposition($mail-composition) if $mail-composition;
  }

  method setESourceMailComposition (ESourceMailCompositionAncestry $_) {
    my $to-parent;

    $!esmc = do {
      when ESourceMailComposition {
        $to-parent = cast(ESourceExtension, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceMailComposition, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Definitions::ESourceMailComposition
  { $!esmc }

  method new (
    ESourceMailCompositionAncestry $mail-composition,
                                   :$ref              = True
  ) {
    return Nil unless $mail-composition;

    my $o = self.bless( :$mail-composition );
    $o.ref if $ref;
    $o;
  }

  method dup_bcc {
    e_source_mail_composition_dup_bcc($!esmc);
  }

  method dup_cc {
    e_source_mail_composition_dup_cc($!esmc);
  }

  method dup_drafts_folder {
    e_source_mail_composition_dup_drafts_folder($!esmc);
  }

  method dup_language {
    e_source_mail_composition_dup_language($!esmc);
  }

  method dup_templates_folder {
    e_source_mail_composition_dup_templates_folder($!esmc);
  }

  method get_bcc {
    e_source_mail_composition_get_bcc($!esmc);
  }

  method get_cc {
    e_source_mail_composition_get_cc($!esmc);
  }

  method get_drafts_folder {
    e_source_mail_composition_get_drafts_folder($!esmc);
  }

  method get_language {
    e_source_mail_composition_get_language($!esmc);
  }

  method get_reply_style {
    ESourceMailCompositionReplyStyleEnum(
      e_source_mail_composition_get_reply_style($!esmc)
    );
  }

  method get_sign_imip {
    e_source_mail_composition_get_sign_imip($!esmc);
  }

  method get_start_bottom {
    e_source_mail_composition_get_start_bottom($!esmc);
  }

  method get_templates_folder {
    e_source_mail_composition_get_templates_folder($!esmc);
  }

  method get_top_signature {
    e_source_mail_composition_get_top_signature($!esmc);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_mail_composition_get_type,
      $n,
      $t
    );
  }

  method set_bcc (Str() $bcc) {
    e_source_mail_composition_set_bcc($!esmc, $bcc);
  }

  method set_cc (Str() $cc) {
    e_source_mail_composition_set_cc($!esmc, $cc);
  }

  method set_drafts_folder (Str() $drafts_folder) {
    e_source_mail_composition_set_drafts_folder($!esmc, $drafts_folder);
  }

  method set_language (Str() $language) {
    e_source_mail_composition_set_language($!esmc, $language);
  }

  method set_reply_style (Int() $reply_style) {
    my ESourceMailCompositionReplyStyle $r = $reply_style;

    e_source_mail_composition_set_reply_style($!esmc, $r);
  }

  method set_sign_imip (Int() $sign_imip) {
    my gboolean $s = $sign_imip.so.Int;

    e_source_mail_composition_set_sign_imip($!esmc, $sign_imip);
  }

  method set_start_bottom (Int() $start_bottom) {
    my EThreeState $s = $start_bottom;

    e_source_mail_composition_set_start_bottom($!esmc, $s);
  }

  method set_templates_folder (Str() $templates_folder) {
    e_source_mail_composition_set_templates_folder($!esmc, $templates_folder);
  }

  method set_top_signature (Int() $top_signature) {
    my EThreeState $t = $top_signature;

    e_source_mail_composition_set_top_signature($!esmc, $t);
  }

}
