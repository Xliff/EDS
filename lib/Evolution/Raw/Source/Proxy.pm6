use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;          # GError
use GIO::Raw::Definitions;       # GCancellable
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::Source::Proxy;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-source-proxy.h

sub e_source_proxy_dup_autoconfig_url (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_dup_ftp_host (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_dup_http_auth_password (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_dup_http_auth_user (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_dup_http_host (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_dup_https_host (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_dup_ignore_hosts (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_dup_socks_host (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_autoconfig_url (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_ftp_host (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_ftp_port (ESourceProxy $extension)
  returns guint16
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_http_auth_password (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_http_auth_user (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_http_host (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_http_port (ESourceProxy $extension)
  returns guint16
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_http_use_auth (ESourceProxy $extension)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_https_host (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_https_port (ESourceProxy $extension)
  returns guint16
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_ignore_hosts (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_method (ESourceProxy $extension)
  returns EProxyMethod
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_socks_host (ESourceProxy $extension)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_socks_port (ESourceProxy $extension)
  returns guint16
  is native(eds)
  is export
{ * }

sub e_source_proxy_get_type ()
  returns GType
  is native(eds)
  is export
{ * }

sub e_source_proxy_lookup (
	ESource      $source,
	Str          $uri,
	GCancellable $cancellable,
	             &callback (ESource, GAsyncResult, gpointer),
	gpointer     $user_data
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_lookup_finish (
	ESource                 $source,
	GAsyncResult            $result,
	CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(eds)
  is export
{ * }

sub e_source_proxy_lookup_sync (
	ESource                 $source,
	Str                     $uri,
	GCancellable            $cancellable,
	CArray[Pointer[GError]] $error
)
  returns Str
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_autoconfig_url (
	ESourceProxy $extension,
	Str          $autoconfig_url
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_ftp_host (
	ESourceProxy $extension,
	Str          $ftp_host
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_ftp_port (
	ESourceProxy $extension,
	guint16      $ftp_port
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_http_auth_password (
	ESourceProxy $extension,
	Str          $http_auth_password
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_http_auth_user (
	ESourceProxy $extension,
	Str          $http_auth_user
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_http_host (
	ESourceProxy $extension,
	Str          $http_host
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_http_port (
	ESourceProxy $extension,
	guint16      $http_port
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_http_use_auth (
	ESourceProxy $extension,
	gboolean     $http_use_auth
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_https_host (
	ESourceProxy $extension,
	Str          $https_host
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_https_port (
	ESourceProxy $extension,
	guint16      $https_port
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_ignore_hosts (
	ESourceProxy $extension,
	Str          $ignore_hosts
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_method (
	ESourceProxy $extension,
	EProxyMethod $method
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_socks_host (
	ESourceProxy $extension,
	Str          $socks_host
)
  is native(eds)
  is export
{ * }

sub e_source_proxy_set_socks_port (
	ESourceProxy $extension,
	guint16      $socks_port
)
  is native(eds)
  is export
{ * }
