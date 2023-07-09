use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Mail::Identity;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-mail-identity.h

sub e_source_mail_identity_dup_address (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_dup_aliases (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_dup_name (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_dup_organization (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_dup_reply_to (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_dup_signature_uid (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_get_address (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_get_aliases (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_get_aliases_as_hash_table (
	ESourceMailIdentity $extension
)
  returns GHashTable
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_get_name (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_get_organization (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_get_reply_to (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_get_signature_uid (
	ESourceMailIdentity $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_set_address (
	ESourceMailIdentity $extension,
	Str                 $address
)
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_set_aliases (
	ESourceMailIdentity $extension,
	Str                 $aliases
)
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_set_name (
	ESourceMailIdentity $extension,
	Str                 $name
)
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_set_organization (
	ESourceMailIdentity $extension,
	Str                 $organization
)
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_set_reply_to (
	ESourceMailIdentity $extension,
	Str                 $reply_to
)
  is native(eds)
  is export
{ * }

sub e_source_mail_identity_set_signature_uid (
	ESourceMailIdentity $extension,
	Str                 $signature_uid
)
  is native(eds)
  is export
{ * }
