use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Enums;
use GIO::Raw::Definitions;
use GIO::Raw::Enums;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::RAw::WebDAV::Source::Discover;

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-webdav-discover.h

sub e_webdav_discovered_source_copy (
  EWebDAVDiscoveredSource $discovered_source
)
  returns EWebDAVDiscoveredSource
  is      native(eds)
  is      export
{ * }

sub e_webdav_discovered_source_free (
  EWebDAVDiscoveredSource $discovered_source
)
  is      native(eds)
  is      export
{ * }

sub e_webdav_discovered_source_get_type
  returns GType
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_free_discovered_sources (GSList $discovered_sources)
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_sources (
  ESource             $source,
  Str                 $url_use_path,
  guint32             $only_supports,
  ENamedParameters    $credentials,
  GCancellable        $cancellable,
  GAsyncReadyCallback $callback,
  gpointer            $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_sources_finish (
  ESource                 $source,
  GAsyncResult            $result,
  CArray[Str]             $out_certificate_pem,
  GTlsCertificateFlags    $out_certificate_errors,
  CArray[GSList]          $out_discovered_sources,
  CArray[GSList]          $out_calendar_user_addresses,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_sources_full (
  ESource                      $source,
  Str                          $url_use_path,
  guint32                      $only_supports,
  ENamedParameters             $credentials,
                               &ref_source_func (gpointer, Str --> ESource),
  gpointer                     $ref_source_func_user_data,
  GCancellable                 $cancellable,
  GAsyncReadyCallback          $callback,
  gpointer                     $user_data
)
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_sources_full_sync (
  ESource                      $source,
  Str                          $url_use_path,
  guint32                      $only_supports,
  ENamedParameters             $credentials,
                               &ref_source_func (gpointer, Str --> ESource),
  gpointer                     $ref_source_func_user_data,
  CArray[Str]                  $out_certificate_pem,
  GTlsCertificateFlags         $out_certificate_errors,
  CArray[GSList]               $out_discovered_sources,
  CArray[GSList]               $out_calendar_user_addresses,
  GCancellable                 $cancellable,
  CArray[Pointer[GError]]      $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_discover_sources_sync (
  ESource                 $source,
  Str                     $url_use_path,
  guint32                 $only_supports,
  ENamedParameters        $credentials,
  CArray[Str]             $out_certificate_pem,
  GTlsCertificateFlags    $out_certificate_errors,
  CArray[GSList]          $out_discovered_sources,
  CArray[GSList]          $out_calendar_user_addresses,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }
