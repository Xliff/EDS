use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::OpenPGP;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-openpgp.h

sub e_source_openpgp_dup_key_id (
	ESourceOpenPGP $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_openpgp_dup_signing_algorithm (
	ESourceOpenPGP $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_openpgp_get_always_trust (
	ESourceOpenPGP $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_openpgp_get_encrypt_by_default (
	ESourceOpenPGP $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_openpgp_get_encrypt_to_self (
	ESourceOpenPGP $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_openpgp_get_key_id (
	ESourceOpenPGP $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_openpgp_get_prefer_inline (
	ESourceOpenPGP $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_openpgp_get_sign_by_default (
	ESourceOpenPGP $extension
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_openpgp_get_signing_algorithm (
	ESourceOpenPGP $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_openpgp_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_openpgp_set_always_trust (
	ESourceOpenPGP $extension,
	gboolean       $always_trust
)
  is native(eds)
  is export
{ * }

sub e_source_openpgp_set_encrypt_by_default (
	ESourceOpenPGP $extension,
	gboolean       $encrypt_by_default
)
  is native(eds)
  is export
{ * }

sub e_source_openpgp_set_encrypt_to_self (
	ESourceOpenPGP $extension,
	gboolean       $encrypt_to_self
)
  is native(eds)
  is export
{ * }

sub e_source_openpgp_set_key_id (
	ESourceOpenPGP $extension,
	Str            $key_id
)
  is native(eds)
  is export
{ * }

sub e_source_openpgp_set_prefer_inline (
	ESourceOpenPGP $extension,
  gboolean       $prefer_inline
)
  is native(eds)
  is export
{ * }

sub e_source_openpgp_set_sign_by_default (
	ESourceOpenPGP $extension,
	gboolean       $sign_by_default
)
  is native(eds)
  is export
{ * }

sub e_source_openpgp_set_signing_algorithm (
	ESourceOpenPGP $extension,
	Str            $signing_algorithm
)
  is native(eds)
  is export
{ * }
