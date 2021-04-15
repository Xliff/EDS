use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::SMIME;

### /usr/include/evolution-data-server/libedataserver/e-source-smime.h

sub e_source_smime_dup_encryption_certificate (ESourceSMIME $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_smime_dup_signing_algorithm (ESourceSMIME $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_smime_dup_signing_certificate (ESourceSMIME $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_smime_get_encrypt_by_default (ESourceSMIME $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_smime_get_encrypt_to_self (ESourceSMIME $extensi)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_smime_get_encryption_certificate (ESourceSMIME $extensi)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_smime_get_sign_by_default (ESourceSMIME $extension)
  returns uint32
is native(eds)is export
{ *}

sub e_source_smime_get_signing_algorithm (ESourceSMIME $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_smime_get_signing_certificate (ESourceSMIME $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_smime_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_smime_set_encrypt_by_default (
	ESourceSMIME $extension,
	gboolean     $encrypt_by_default
)
  is native(eds)
  is export
{ * }

sub e_source_smime_set_encrypt_to_self (
	ESourceSMIME $extension,
	gboolean     $encrypt_to_self
)
  is native(eds)
  is export
{ * }

sub e_source_smime_set_encryption_certificate (
	ESourceSMIME $extension,
	Str          $encryption_certificate
)
  is native(eds)
  is export
{ * }

sub e_source_smime_set_sign_by_default (
	ESourceSMIME $extension,
	gboolean     $sign_by_default
)
  is native(eds)
  is export
{ * }

sub e_source_smime_set_signing_algorithm (
	ESourceSMIME $extension,
	Str          $signing_algorithm
)
  is native(eds)
  is export
{ * }

sub e_source_smime_set_signing_certificate (
	ESourceSMIME $extension,
	Str          $signing_certificate
)
  is native(eds)
  is export
{ * }
