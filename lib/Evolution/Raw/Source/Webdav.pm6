use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GIO::Raw::Enums;
use SOUP::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Webdav;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-webdav.h

sub e_source_webdav_dup_color (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_dup_display_name (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_dup_email_address (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_dup_resource_path (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_dup_resource_query (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_dup_soup_uri (ESourceWebdav $extension)
  returns SoupURI
  is native(eds)
  is export
{ * }

sub e_source_webdav_dup_ssl_trust (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_avoid_ifmatch (ESourceWebdav $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_calendar_auto_schedule (ESourceWebdav $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_color (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_display_name (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_email_address (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_resource_path (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_resource_query (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_ssl_trust (ESourceWebdav $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_ssl_trust_response (ESourceWebdav $extension)
  returns ETrustPromptResponse
  is native(eds)
  is export
{ * }

sub e_source_webdav_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_avoid_ifmatch (
	ESourceWebdav $extension,
	gboolean      $avoid_ifmatch
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_calendar_auto_schedule (
	ESourceWebdav $extension,
	gboolean      $calendar_auto_schedule
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_color (
	ESourceWebdav $extension,
	Str           $color
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_display_name (
	ESourceWebdav $extension,
	Str           $display_name
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_email_address (
	ESourceWebdav $extension,
	Str           $email_address
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_resource_path (
	ESourceWebdav $extension,
	Str           $resource_path
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_resource_query (
	ESourceWebdav $extension,
	Str           $resource_query
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_soup_uri (
	ESourceWebdav $extension,
	SoupURI       $soup_uri
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_ssl_trust (
	ESourceWebdav $extension,
	Str           $ssl_trust
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_set_ssl_trust_response (
	ESourceWebdav        $extension,
	ETrustPromptResponse $response
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_unset_temporary_ssl_trust (ESourceWebdav $extension)
  is native(eds)
  is export
{ * }

sub e_source_webdav_update_ssl_trust (
	ESourceWebdav        $extension,
	Str                  $host,
	GTlsCertificate      $cert,
	ETrustPromptResponse $response
)
  is native(eds)
  is export
{ * }

sub e_source_webdav_verify_ssl_trust (
	ESourceWebdav        $extension,
	Str                  $host,
	GTlsCertificate      $cert,
	GTlsCertificateFlags $cert_errors
)
  returns ETrustPromptResponse
  is native(eds)
  is export
{ * }
