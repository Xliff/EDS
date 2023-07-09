use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Mail::Account;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-mail-account.h

sub e_source_mail_account_dup_archive_folder (ESourceMailAccount $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_account_dup_identity_uid (ESourceMailAccount $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_account_get_archive_folder (ESourceMailAccount $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_account_get_identity_uid (ESourceMailAccount $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_account_get_mark_seen (ESourceMailAccount $extension)
  returns EThreeState
  is native(eds)
  is export
{ * }

sub e_source_mail_account_get_mark_seen_timeout (ESourceMailAccount $extension)
  returns gint
  is native(eds)
  is export
{ * }

sub e_source_mail_account_get_needs_initial_setup (
  ESourceMailAccount $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_mail_account_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_mail_account_set_archive_folder (
  ESourceMailAccount $extension,
  Str                $archive_folder
)
  is native(eds)
  is export
{ * }

sub e_source_mail_account_set_identity_uid (
  ESourceMailAccount $extension,
  Str                $identity_uid
)
  is native(eds)
  is export
{ * }

sub e_source_mail_account_set_mark_seen (
  ESourceMailAccount $extension,
  EThreeState        $mark_seen
)
  is native(eds)
  is export
{ * }

sub e_source_mail_account_set_mark_seen_timeout (
  ESourceMailAccount $extension,
  gint               $timeout
)
  is native(eds)
  is export
{ * }

sub e_source_mail_account_set_needs_initial_setup (
  ESourceMailAccount $extension,
  gboolean           $needs_initial_setup
)
  is native(eds)
  is export
{ * }
