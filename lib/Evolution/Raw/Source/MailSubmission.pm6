use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::MailSubmission;

### /usr/include/evolution-data-server/libedataserver/e-source-mail-submission.h

sub e_source_mail_submission_dup_sent_folder (
	ESourceMailSubmission $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_dup_transport_uid (
	ESourceMailSubmission $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_get_replies_to_origin_folder (
	ESourceMailSubmission $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_get_sent_folder (
	ESourceMailSubmission $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_get_transport_uid (
	ESourceMailSubmission $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_get_type (
	)
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_get_use_sent_folder (
	ESourceMailSubmission $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_set_replies_to_origin_folder (
	ESourceMailSubmission $extension,
	gboolean              $replies_to_origin_folder
)
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_set_sent_folder (
	ESourceMailSubmission $extension,
	Str                   $sent_folder
)
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_set_transport_uid (
	ESourceMailSubmission $extension,
	Str                   $transport_uid
)
  is native(eds)
  is export
{ * }

sub e_source_mail_submission_set_use_sent_folder (
	ESourceMailSubmission $extension,
	gboolean              $use_sent_folder
)
  is native(eds)
  is export
{ * }
