use v6.c;

use NativeCall;

use LibXML::Raw;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Structs;
use SOUP::Raw::Definitions;
use Evolution::Raw::Definitions;
use Evolution::Raw::Enums;
use Evolution::Raw::Structs;

unit package Evolution::Raw::WebDAV::Session;

# our constant E_WEBDAV_CAPABILITY_CLASS_1                  is export = '1';
# our constant E_WEBDAV_CAPABILITY_CLASS_2                  is export = '2';
# our constant E_WEBDAV_CAPABILITY_CLASS_3                  is export = '3';
# our constant E_WEBDAV_CAPABILITY_ACCESS_CONTROL           is export = 'access-control';
# our constant E_WEBDAV_CAPABILITY_BIND                     is export = 'bind';
# our constant E_WEBDAV_CAPABILITY_EXTENDED_MKCOL           is export = 'extended-mkcol';
# our constant E_WEBDAV_CAPABILITY_ADDRESSBOOK              is export = 'addressbook';
# our constant E_WEBDAV_CAPABILITY_CALENDAR_ACCESS          is export = 'calendar-access';
# our constant E_WEBDAV_CAPABILITY_CALENDAR_SCHEDULE        is export = 'calendar-schedule';
# our constant E_WEBDAV_CAPABILITY_CALENDAR_AUTO_SCHEDULE   is export = 'calendar-auto-schedule';
# our constant E_WEBDAV_CAPABILITY_CALENDAR_PROXY           is export = 'calendar-proxy';
# our constant E_WEBDAV_DEPTH_THIS                          is export = '0';
# our constant E_WEBDAV_DEPTH_THIS_AND_CHILDREN             is export = '1';
# our constant E_WEBDAV_DEPTH_INFINITY                      is export = 'infinity';
# our constant E_WEBDAV_CONTENT_TYPE_XML                    is export = 'application/xml; charset="utf-8"';
# our constant E_WEBDAV_CONTENT_TYPE_CALENDAR               is export = 'text/calendar; charset="utf-8"';
# our constant E_WEBDAV_CONTENT_TYPE_VCARD                  is export = 'text/vcard; charset="utf-8"';
# our constant E_WEBDAV_NS_DAV                              is export = 'DAV:';
# our constant E_WEBDAV_NS_CALDAV                           is export = 'urn:ietf:params:xml:ns:caldav';
# our constant E_WEBDAV_NS_CARDDAV                          is export = 'urn:ietf:params:xml:ns:carddav';
# our constant E_WEBDAV_NS_CALENDARSERVER                   is export = 'http://calendarserver.org/ns/';
# our constant E_WEBDAV_NS_ICAL                             is export = 'http://apple.com/ns/ical/';

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-webdav-session.h

sub e_webdav_session_acl_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  EXmlDocument            $xml,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_copy_sync (
  EWebDAVSession          $webdav,
  Str                     $source_uri,
  Str                     $destination_uri,
  Str                     $depth,
  gboolean                $can_overwrite,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_delete_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  Str                     $depth,
  Str                     $etag,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_ensure_full_uri (
  EWebDAVSession $webdav,
  GUri           $request_uri,
  Str            $href
)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_get_acl_restrictions_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  guint32                 $out_restrictions is rw,
  EWebDAVACEPrincipalKind $out_principal_kind,
  CArray[Pointer[GSList]] $out_principal_hrefs,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_get_acl_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  CArray[Pointer[GSList]] $out_entries,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_get_current_user_privilege_set_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  CArray[Pointer[GSList]] $out_privileges,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_get_data_sync (
  EWebDAVSession             $webdav,
  Str                        $uri,
  CArray[Str]                $out_href,
  CArray[Str]                $out_etag,
  CArray[SoupMessageHeaders] $out_headers,
  CArray[Str]                $out_bytes,
  gsize                      $out_length,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_get_last_dav_error_code (EWebDAVSession $webdav)
  returns Str
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_get_last_dav_error_is_permission (EWebDAVSession $webdav)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_get_principal_collection_set_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  CArray[Pointer[GSList]] $out_principal_hrefs,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_get_supported_privilege_set_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  CArray[GNode]           $out_privileges,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_get_sync (
  EWebDAVSession             $webdav,
  Str                        $uri,
  CArray[Str]                $out_href,
  CArray[Str]                $out_etag,
  CArray[SoupMessageHeaders] $out_headers,
  GOutputStream              $out_stream,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_getctag_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  CArray[Str]             $out_ctag,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_list_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  Str                     $depth,
  guint32                 $flags,
  CArray[Pointer[GSList]] $out_resources,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_lock_resource_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  EWebDAVLockScope        $lock_scope,
  gint32                  $lock_timeout,
  Str                     $owner,
  CArray[Str]             $out_lock_token,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_lock_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  Str                     $depth,
  gint32                  $lock_timeout,
  EXmlDocument            $xml,
  CArray[Str]             $out_lock_token,
  CArray[xmlDoc]          $out_xml_response,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_mkcalendar_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  Str                     $display_name,
  Str                     $description,
  Str                     $color,
  guint32                 $supports,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_mkcol_addressbook_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  Str                     $display_name,
  Str                     $description,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_mkcol_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_move_sync (
  EWebDAVSession          $webdav,
  Str                     $source_uri,
  Str                     $destination_uri,
  gboolean                $can_overwrite,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_new (ESource $source)
  returns EWebDAVSession
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_new_message (
  EWebDAVSession          $webdav,
  Str                     $method,
  Str                     $uri,
  CArray[Pointer[GError]] $error
)
  returns SoupMessage
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_options_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  CArray[GHashTable]      $out_capabilities,
  CArray[GHashTable]      $out_allows,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_post_sync (
  EWebDAVSession             $webdav,
  Str                        $uri,
  Str                        $data,
  gsize                      $data_length,
  Str                        $in_content_type,
  SoupMessageHeaders         $in_headers,
  CArray[Str]                $out_content_type,
  CArray[SoupMessageHeaders] $out_headers,
  CArray[GByteArray]         $out_content,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_principal_property_search_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  gboolean                $apply_to_principal_collection_set,
  Str                     $match_ns_uri,
  Str                     $match_property,
  Str                     $match_value,
  CArray[Pointer[GSList]] $out_principals,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_propfind_sync (
  EWebDAVSession              $webdav,
  Str                         $uri,
  Str                         $depth,
  EXmlDocument                $xml,
                              & (
                                EWebDAVSession,
                                xmlNode,
                                GUri,
                                Str,
                                gint,
                                gpointer
                                --> gboolean
                              ),
  gpointer                    $func_user_data,
  GCancellable                $cancellable,
  CArray[Pointer[GError]]     $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_proppatch_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  EXmlDocument            $xml,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_put_data_sync (
  EWebDAVSession             $webdav,
  Str                        $uri,
  Str                        $etag,
  Str                        $content_type,
  SoupMessageHeaders         $in_headers,
  Str                        $bytes,
  gsize                      $length,
  CArray[Str]                $out_href,
  CArray[Str]                $out_etag,
  CArray[SoupMessageHeaders] $out_headers,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_put_sync (
  EWebDAVSession             $webdav,
  Str                        $uri,
  Str                        $etag,
  Str                        $content_type,
  SoupMessageHeaders         $in_headers,
  GInputStream               $stream,
  gssize                     $stream_length,
  CArray[Str]                $out_href,
  CArray[Str]                $out_etag,
  CArray[SoupMessageHeaders] $out_headers,
  GCancellable               $cancellable,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_refresh_lock_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  Str                     $lock_token,
  gint32                  $lock_timeout,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_replace_with_detailed_error (
  EWebDAVSession          $webdav,
  SoupMessage             $message,
  GByteArray              $response_data,
  gboolean                $ignore_multistatus,
  Str                     $prefix,
  CArray[Pointer[GError]] $inout_error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_report_sync (
  EWebDAVSession              $webdav,
  Str                         $uri,
  Str                         $depth,
  EXmlDocument                $xml,
                              & (
                                EWebDAVSession,
                                xmlNode,
                                GUri,
                                Str,
                                gint,
                                gpointer
                                --> gboolean
                              ),
  gpointer                    $func_user_data,
  CArray[Str]                 $out_content_type,
  CArray[GByteArray]          $out_content,
  GCancellable                $cancellable,
  CArray[Pointer[GError]]     $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_set_acl_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  GSList                  $entries,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_traverse_mkcalendar_response (
  EWebDAVSession              $webdav,
  SoupMessage                 $message,
  GByteArray                  $xml_data,
                              & (
                                EWebDAVSession,
                                xmlNode,
                                GUri,
                                Str,
                                gint,
                                gpointer
                                --> gboolean
                              ),
  gpointer                    $func_user_data,
  CArray[Pointer[GError]]     $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_traverse_mkcol_response (
  EWebDAVSession              $webdav,
  SoupMessage                 $message,
  GByteArray                  $xml_data,
                              & (
                                EWebDAVSession,
                                xmlNode,
                                GUri,
                                Str,
                                gint,
                                gpointer
                                --> gboolean
                              ),
  gpointer                    $func_user_data,
  CArray[Pointer[GError]]     $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_traverse_multistatus_response (
  EWebDAVSession              $webdav,
  SoupMessage                 $message,
  GByteArray                  $xml_data,
                              & (
                                EWebDAVSession,
                                xmlNode,
                                GUri,
                                Str,
                                gint,
                                gpointer
                                --> gboolean
                              ),
  gpointer                    $func_user_data,
  CArray[Pointer[GError]]     $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_unlock_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  Str                     $lock_token,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_update_properties_sync (
  EWebDAVSession          $webdav,
  Str                     $uri,
  GSList                  $changes,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_util_free_privileges (GNode $privileges)
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_util_item_href_equal (
  Str $href1,
  Str $href2
)
  returns uint32
  is      native(eds)
  is      export
{ * }

sub e_webdav_session_util_maybe_dequote (Str $text)
  returns Str
  is      native(eds)
  is      export
{ * }
