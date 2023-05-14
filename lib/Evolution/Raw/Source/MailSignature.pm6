use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::MailSignature;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-mail-signature.h

sub e_source_mail_signature_dup_mime_type (
	ESourceMailSignature $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_get_file (
	ESourceMailSignature $extension
)
  returns GFile
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_get_mime_type (
	ESourceMailSignature $extension
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_load (
	ESource      $source,
	gint         $io_priority,
	GCancellable $cancellable,
	             &callback (ESource, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_load_finish (
	ESource                 $source,
	GAsyncResult            $result,
	Str                     $contents,
	gsize                   $length,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_load_sync (
	ESource                 $source,
	Str                     $contents,
	gsize                   $length,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_replace (
	ESource      $source,
	Str          $contents,
	gsize        $length,
	gint         $io_priority,
	GCancellable $cancellable,
	             &callback (ESource, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_replace_finish (
	ESource                 $source,
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_replace_sync (
	ESource                 $source,
	Str                     $contents,
	gsize                   $length,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_set_mime_type (
	ESourceMailSignature $extension,
	Str                  $mime_type
)
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_symlink (
	ESource             $source,
	Str                 $symlink_target,
	gint                $io_priority,
	GCancellable        $cancellable,
	                    &callback (ESource, GAsyncResult, gpointer),
	gpointer            $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_symlink_finish (
	ESource                 $source,
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_mail_signature_symlink_sync (
	ESource                 $source,
	Str                     $symlink_target,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }
