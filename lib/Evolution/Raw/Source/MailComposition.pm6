use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::MailComposition;

### /usr/include/evolution-data-server/libedataserver/e-source-mail-composition.h

sub e_source_mail_composition_dup_bcc (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_dup_cc (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_dup_drafts_folder (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_dup_language (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_dup_templates_folder (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_bcc (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_cc (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_drafts_folder (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_language (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_reply_style (
	ESourceMailComposition $extension
)
  returns ESourceMailCompositionReplyStyle
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_sign_imip (
	ESourceMailComposition $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_start_bottom (
	ESourceMailComposition $extension
)
  returns EThreeState
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_templates_folder (
	ESourceMailComposition $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_top_signature (
	ESourceMailComposition $extension
)
  returns EThreeState
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_set_bcc (
	ESourceMailComposition $extension,
	Str                    $bcc
)
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_set_cc (
	ESourceMailComposition $extension,
	Str                    $cc
)
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_set_drafts_folder (
	ESourceMailComposition $extension,
	Str                    $drafts_folder
)
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_set_language (
	ESourceMailComposition $extension,
	Str                    $language
)
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_set_reply_style (
	ESourceMailComposition           $extension,
	ESourceMailCompositionReplyStyle $reply_style
)
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_set_sign_imip (
	ESourceMailComposition $extension,
	gboolean               $sign_imip
)
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_set_start_bottom (
	ESourceMailComposition $extension,
	EThreeState            $start_bottom
)
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_set_templates_folder (
	ESourceMailComposition $extension,
	Str                    $templates_folder
)
  is native(eds)
  is export
{ * }

sub e_source_mail_composition_set_top_signature (
	ESourceMailComposition $extension,
	EThreeState            $top_signature
)
  is native(eds)
  is export
{ * }
