use v6.c;

use NativeCall;
use Method::Also;

use LibXML::Raw;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::WebDAV::Session;

use Evolution::Soup::Session;
use LibXML::Document;
use GLib::GSList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset EWebDAVSessionAncestry is export of Mu
  where EWebDAVSession | ESoupSessionAncestry;

class Evolution::WebDAV::Session is Evolution::Soup::Session {
  has EWebDAVSession $!eds-ws is implementor;

  submethod BUILD ( :$eds-ws ) {
    self.setEWebDAVSession($eds-ws) if $eds-ws
  }

  method setEWebDAVSession (EWebDAVSessionAncestry $_) {
    my $to-parent;

    $!eds-ws = do {
      when EWebDAVSession {
        $to-parent = cast(ESoupSession, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EWebDAVSession, $_);
      }
    }
    self.setESoupSession($to-parent);
  }

  method Evolution::Raw::Definitions::EWebDAVSession
    is also<EWebDAVSession>
  { $!eds-ws }

  multi method new (
     $eds-ws where * ~~ EWebDAVSessionAncestry,

    :$ref = True
  ) {
    return unless $eds-ws;

    my $o = self.bless( :$eds-ws );
    $o.ref if $ref;
    $o;
  }
  multi method new (ESource() $source) {
    my $e-dav-session = e_webdav_session_new($source);

    $e-dav-session ?? self.bless( :$e-dav-session ) !! Nil;
  }

  method new_message (
    EWebDAVSession()          $session,
    Str()                     $method,
    Str()                     $uri,
    CArray[Pointer[GError]]   $error    = gerror
  )
    is also<new-message>
  {
    clear_error;
    my $e-dav-session = e_webdav_session_new_message(
      $session,
      $method,
      $uri,
      $error
    );
    set_error($error);

    $e-dav-session ?? self.bless( :$e-dav-session ) !! Nil;
  }


  method acl_sync (
    Str()                   $uri,
    EXmlDocument()          $xml,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<acl-sync>
  {
    clear_error
    my $r = e_webdav_session_acl_sync($!eds-ws, $uri, $xml, $cancellable, $error);
    set_error($error);
    $r;
  }

  method copy_sync (
    Str()                   $source_uri,
    Str()                   $destination_uri,
    Str()                   $depth            = E_WEBDAV_DEPTH_THIS,
    Int()                   $can_overwrite    = False,
    GCancellable()          $cancellable      = GCancellable,
    CArray[Pointer[GError]] $error            = gerror
  )
    is also<copy-sync>
  {
    my gboolean $c = $can_overwrite.so.Int;

    clear_error;
    my $rv = so e_webdav_session_copy_sync(
      $!eds-ws,
      $source_uri,
      $destination_uri,
      $depth,
      $c,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method delete_sync (
    Str()                    $uri,
    Str()                    $depth,
    Str()                    $etag,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$all         = False
  )
    is also<delete-sync>
  {
    clear_error;
    my $rv = so e_webdav_session_delete_sync(
      $!eds-ws,
      $uri,
      $depth,
      $etag,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method ensure_full_uri (GUri() $request_uri, Str() $href)
    is also<ensure-full-uri>
  {
    e_webdav_session_ensure_full_uri($!eds-ws, $request_uri, $href);
  }

  proto method get_acl_restrictions_sync (|)
    is also<get-acl-restrictions-sync>
  { * }

  multi method get_acl_restrictions_sync (
    Str()                   $uri,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    samewith($uri, $, $, newCArray(GSList), $cancellable, $error);
  }
  multi method get_acl_restrictions_sync (
    Str()                    $uri,
                             $out_restrictions     is rw,
                             $out_principal_kind   is rw,
    CArray[Pointer[GSList]]  $out_principal_hrefs,
    GCancellable()           $cancellable                = GCancellable,
    CArray[Pointer[GError]]  $error                      = gerror,
                            :$all                        = False,
                            :$raw                        = False,
                            :glist(:$gslist)             = False
  ) {
    my gint                    $or  = 0;
    my EWebDAVACEPrincipalKind $opk = 0;

    clear_error;
    my $rv = so e_webdav_session_get_acl_restrictions_sync(
      $!eds-ws,
      $uri,
      $or,
      $opk,
      $out_principal_hrefs,
      $cancellable,
      $error
    );
    set_error($error);

    ($out_restrictions, $out_principal_kind) = ($or, $opk);
    return Nil unless $rv;
    my $hrefs = returnGSList(
      ppr($out_principal_hrefs),
      $raw,
      $gslist,
      Str
    );
    ($out_restrictions, $out_principal_kind) = ($or, $opk);

    return Nil unless $rv;

    $all.not ?? $rv
             !! ($out_restrictions, $out_principal_kind, $hrefs)
  }

  proto method get_acl_sync (|)
  { * }

  multi method get_acl_sync (
    Str                     $uri,
    GCancellable            $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    samewith($uri, newCArray(GSList), $cancellable, $error, :all);
  }
  multi method get_acl_sync (
    Str                      $uri,
    CArray[Pointer[GSList]]  $out_entries,
    GCancellable             $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$all            = False,
                            :$raw            = False,
                            :glist(:$gslist) = False
  )
    is also<get-acl-sync>
  {
    clear_error;
    my $rv = so e_webdav_session_get_acl_sync(
      $!eds-ws,
      $uri,
      $out_entries,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;
    $all.not ?? $rv !! returnGSList( ppr($out_entries), $raw, $gslist, Str );
  }

  proto method get_current_user_privilege_set_sync (|)
  { * }

  multi method get_current_user_privilege_set_sync (
    Str()                     $uri,
    GCancellable()            $cancellable     = GCancellable,
    CArray[Pointer[GError]]   $error           = gerror,
                             :$raw             = False,
                             :glist(:$gslist)  = False
  ) {
    samewith(
      $uri,
      newCArray(GSList),
      $cancellable,
      $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method get_current_user_privilege_set_sync (
    Str()                    $uri,
    CArray[Pointer[GSList]]  $out_privileges,
    GCancellable()           $cancellable     = GCancellable,
    CArray[Pointer[GError]]  $error           = gerror,
                            :$raw             = False,
                            :$all             = False,
                            :glist(:$gslist)  = False
  )
    is also<get-current-user-privilege-set-sync>
  {
    clear_error;
    my $rv = so e_webdav_session_get_current_user_privilege_set_sync(
      $!eds-ws,
      $uri,
      $out_privileges,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    $all.not ?? $rv
             !! returnGSList(
                  ppr($out_privileges),
                  $raw,
                  $gslist,
                  |Evolution::WebDAV::Privilege.getTypePair
                );
  }

  proto method get_data_sync (|)
   is also<get-data-sync>
  { * }

  multi method get_data_sync (
    Str                       $uri,
    GCancellable()            $cancellable = GCancellable,
    CArray[Pointer[GError]]   $error       = gerror,
                             :$raw         = False
  ) {
    samewith(
      $uri,
      newCArray(Str),
      newCArray(Str),
      newCArray(SoupMessageHeaders),
      newCArray(Str),
      $,
      $cancellable,
      $error,
      :all,
      :$raw
    );
  }
  multi method get_data_sync (
    Str                        $uri,
    CArray[Str]                $out_href,
    CArray[Str]                $out_etag,
    CArray[SoupMessageHeaders] $out_headers,
    CArray[Str]                $out_bytes,
                               $out_length    is rw,
    GCancellable               $cancellable,
    CArray[Pointer[GError]]    $error                = gerror,
                              :$all                  = False,
                              :$raw                  = False
  ) {
    my gsize $ol = 0;

    clear_error;
    my $rv = so e_webdav_session_get_data_sync(
      $!eds-ws,
      $uri,
      $out_href,
      $out_etag,
      $out_headers,
      $out_bytes,
      $ol,
      $cancellable,
      $error
    );
    set_error($error);
    $out_length = $ol;

    my ($href, $etag, $bytes) = ppr($out_href, $out_etag, $out_bytes);

    my $headers = propReturnObject(
      ppr($out_headers),
      $raw,
      |Soup::Message::Headers.getTypePair
    );

    return Nil unless $rv;

    $all.not ?? $rv
             !! ($href, $etag, $headers, $bytes, $out_length);
  }

  method get_last_dav_error_code is also<get-last-dav-error-code> {
    e_webdav_session_get_last_dav_error_code($!eds-ws);
  }

  method get_last_dav_error_is_permission is also<get-last-dav-error-is-permission> {
    so e_webdav_session_get_last_dav_error_is_permission($!eds-ws);
  }

  proto method get_principal_collection_set_sync (|)
    is also<get-principal-collection-set-sync>
  { * }

  multi method get_principal_collection_set_sync (
    Str()                    $uri,
    GCancellable()           $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    samewith(
      $uri,
      newCArray(GSList),
      $cancellable,
      $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method get_principal_collection_set_sync (
    Str()                    $uri,
    CArray[Pointer[GSList]]  $out_principal_hrefs,
    GCancellable()           $cancellable          = GCancellable,
    CArray[Pointer[GError]]  $error                = gerror,
                            :$all                  = False,
                            :$raw                  = False,
                            :glist(:$gslist)       = False
  ) {
    clear_error;
    my $rv = e_webdav_session_get_principal_collection_set_sync(
      $!eds-ws,
      $uri,
      $out_principal_hrefs,
      $cancellable,
      $error
    );
    set_error($error);

    my $hrefs = returnGSList( ppr($out_principal_hrefs), $raw, $gslist );

    return Nil unless $rv;

    $all.not ?? $rv !! $hrefs
  }

  proto method get_supported_privilege_set_sync (|)
    is also<get-supported-privilege-set-sync>
  { * }

  multi method get_supported_privilege_set_sync (
    Str                      $uri,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$raw         = False
  ) {
    samewith($uri, newCArray(GNode), $cancellable, $error, :all, :$raw);
  }
  multi method get_supported_privilege_set_sync (
    Str()                    $uri,
    CArray[Pointer[GNode]]   $out_privileges,
    GCancellable()           $cancellable     = GCancellable,
    CArray[Pointer[GError]]  $error           = gerror,
                            :$all             = False,
                            :$raw             = False
  ) {
    clear_error;
    my $rv = so e_webdav_session_get_supported_privilege_set_sync(
      $!eds-ws,
      $uri,
      $out_privileges,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    $all.not ?? $rv
             !! propReturnObject(
                  ppr($out_privileges),
                  $raw,
                  |GLib::Node.getTypePair
                );
  }

  proto method get_sync (|)
    is also<get-sync>
  { * }

  multi method get_sync (
    Str()                      $uri,
    GCancellable()             $cancellable = GCancellable,
    CArray[Pointer[GError]]    $error       = gerror,
                              :$raw         = False
  ) {
    samewith(
       $uri,
       newCArray(Str),
       newCArray(Str),
       newCArray(SoupMessageHeaders),
       GOutputStream.alloc,
       $cancellable,
       $error,
      :all,
      :$raw
    );
  }
  multi method get_sync (
    Str()                      $uri,
    CArray[Str]                $out_href,
    CArray[Str]                $out_etag,
    CArray[SoupMessageHeaders] $out_headers,
    GOutputStream()            $out_stream,
    GCancellable()             $cancellable  = GCancellable,
    CArray[Pointer[GError]]    $error        = gerror,
                              :$all          = False,
                              :$raw          = False
  ) {
    clear_error;
    my $rv = so e_webdav_session_get_sync(
      $!eds-ws,
      $uri,
      $out_href,
      $out_etag,
      $out_headers,
      $out_stream,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    my $headers = propReturnObject(
      ppr($out_headers),
      $raw,
      |SOUP::Message::Headers.getTypePair
    );

    my $stream = propReturnObject(
      $out_stream,
      $raw,
      |GIO::GOutputStream.getTypePair
    );

    $all.not ?? $rv
             !! ( |ppr($out_href, $out_etag), $headers, $stream );
  }

  proto method getctag_sync (|)
    is also<getctag-sync>
  { * }

  multi method getctag_sync (
    Str                     $uri,
    GCancellable            $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    samewith($uri, newCArray(Str), $cancellable, $error, :all)
  }
  multi method getctag_sync (
    Str                      $uri,
    CArray[Str]              $out_ctag,
    GCancellable             $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$all         = False
  ) {
    clear_error;
    my $rv = so e_webdav_session_getctag_sync(
      $!eds-ws,
      $uri,
      $out_ctag,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    $all.not ?? $rv !! ppr($out_ctag);
  }

  proto method list_sync (|)
  { * }

  multi method list_sync (
    Str()                    $uri,
    Str()                    $depth          = E_WEBDAV_DEPTH_THIS,
    GCancellable             $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
    Int()                   :$flags          = E_WEBDAV_LIST_ALL,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    samewith(
       $uri,
       $depth,
       $flags,
       newCArray(GSList),
       $cancellable,
       $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method list_sync (
    Str()                    $uri,
    Str()                    $depth,
    Int()                    $flags,
    CArray[Pointer[GSList]]  $out_resources,
    GCancellable             $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$all            = False,
                            :$raw            = False,
                            :glist(:$gslist) = False
  )
    is also<list-sync>
  {
    my guint32 $f = $flags,

    clear_error;
    my $rv = so e_webdav_session_list_sync(
      $!eds-ws,
      $uri,
      $depth,
      $f,
      $out_resources,
      $cancellable,
      $error
    );
    set_error($error);

    return Nil unless $rv;

    $all.not ?? $rv
             !! returnGSList(
                  ppr($out_resources),
                  $raw,
                  $gslist,
                  |Evolution::WebDAV::Resources.getTypePair
                )
  }

  proto method lock_resource_sync (|)
  { * }

  multi method lock_resource_sync (
    Str()                   $uri,
    Int()                   $lock_scope,
    Int()                   $lock_timeout,
    Str()                   $owner,
    GCancellable            $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    samewith(
      $uri,
      $lock_scope,
      $lock_timeout,
      $owner,
      newCArray(Str),
      $cancellable,
      $error,
      :all
    );
  }
  multi method lock_resource_sync (
    Str()                     $uri,
    Int()                     $lock_scope,
    Int()                     $lock_timeout,
    Str()                     $owner,
    CArray[Str]               $out_lock_token,
    GCancellable()            $cancellable     = GError,
    CArray[Pointer[GError]]   $error           = gerror,
                             :$all             = False
  )
    is also<lock-resource-sync>
  {
    my gint32 $l = $lock_timeout;

    clear_error;
    my $rv = so e_webdav_session_lock_resource_sync(
      $!eds-ws,
      $uri,
      $lock_scope,
      $lock_timeout,
      $owner,
      $out_lock_token,
      $cancellable,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ppr($out_lock_token);
  }

  proto method lock_sync (|)
  { * }

  multi method lock_sync (
    Str()                    $uri,
    Str()                    $depth,
    Int()                    $lock_timeout,
    EXmlDocument()           $xml,
    CArray[Pointer[GError]]  $error         = gerror,
    GCancellable()          :$cancellable   = GCancellable,
                            :$raw           = False
  ) {
    samewith(
      $uri,
      $depth,
      $lock_timeout,
      $xml,
      newCArray(Str),
      newCArray(xmlDoc),
      $cancellable,
      $error,
      :all,
      :$raw
    );
  }
  multi method lock_sync (
    Str()                    $uri,
    Str()                    $depth,
    Int()                    $lock_timeout,
    EXmlDocument()           $xml,
    CArray[Str]              $out_lock_token,
    CArray[xmlDoc]           $out_xml_response,
    GCancellable             $cancellable       = GCancellable,
    CArray[Pointer[GError]]  $error             = gerror,
                            :$all               = False,
                            :$raw               = False
  )
    is also<lock-sync>
  {
    my gint32 $l = $lock_timeout;

    clear_error;
    my $rv = so e_webdav_session_lock_sync(
      $!eds-ws,
      $uri,
      $depth,
      $lock_timeout,
      $xml,
      $out_lock_token,
      $out_xml_response,
      $cancellable,
      $error
    );
    set_error($error);

    my $ox = propReturnObject(
      ppr($out_xml_response),
      $raw,
      xmlDoc,
      LibXML::Document,
      construct         => &create-xml-document
    );

    $all.not ?? $rv !! ( ppr($out_lock_token), $ox );
  }

  method mkcalendar_sync (
    Str()                   $uri,
    Str()                   $display_name,
    Str()                   $description,
    Str()                   $color,
    Int()                   $supports,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<mkcalendar-sync>
  {
    my guint32 $s = $supports;

    clear_error;
    my $rv = so e_webdav_session_mkcalendar_sync(
      $!eds-ws,
      $uri,
      $display_name,
      $description,
      $color,
      $supports,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method mkcol_addressbook_sync (
    Str()                   $uri,
    Str()                   $display_name,
    Str()                   $description,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<mkcol-addressbook-sync>
  {
    clear_error;
    my $rv = so e_webdav_session_mkcol_addressbook_sync(
      $!eds-ws,
      $uri,
      $display_name,
      $description,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method mkcol_sync (
    Str()                   $uri,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<mkcol-sync>
  {
    clear_error;
    my $rv = so e_webdav_session_mkcol_sync(
      $!eds-ws,
      $uri,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method move_sync (
    Str()                   $source_uri,
    Str()                   $destination_uri,
    Int()                   $can_overwrite,
    GCancellable()          $cancellable      = GCancellable,
    CArray[Pointer[GError]] $error            = gerror
  )
    is also<move-sync>
  {
    my gboolean $c = $can_overwrite.so.Int;

    clear_error;
    my $rv = e_webdav_session_move_sync(
      $!eds-ws,
      $source_uri,
      $destination_uri,
      $can_overwrite,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method options_sync (|)
   is also<options-sync>
  { * }

  multi method options_sync (
    Str()                    $uri,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$raw         = False,
                            :$hash        = True
  ) {
    samewith(
       $uri,
       |newCArray(GHashTable) xx 2,
       $cancellable,
       $error,
      :all,
      :$raw,
      :$hash
    );
  }
  multi method options_sync (
    Str                      $uri,
    CArray[GHashTable]       $out_capabilities,
    CArray[GHashTable]       $out_allows,
    GCancellable()           $cancellable       = GCancellable,
    CArray[Pointer[GError]]  $error             = gerror,
                            :$all               = False,
                            :$raw               = False,
                            :$hash              = False
  ) {
    clear_error;
    my $rv = e_webdav_session_options_sync(
      $!eds-ws,
      $uri,
      $out_capabilities,
      $out_allows,
      $cancellable,
      $error
    );
    set_error($error);

    my $oc = propReturnObject(
      ppr($out_capabilities),
      $raw,
      |GLib::HashTable.getTypePair
    );

    my $oa = propReturnObject(
      ppr($out_allows),
      $raw,
      |GLib::HashTable.getTypePair
    );

    return $rv if $all.not;

    return ( my @a = ($oc, $oa) ) unless $hash && $raw.not;

    @a».Hash;
  }

  proto method post_sync (|)
    is also<post-sync>
  { * }

  multi method post_sync (
    Str()                      $uri,
    Str()                      $data,
    Int()                      $data_length,
    Str()                      $in_content_type,
    SoupMessageHeaders()       $in_headers,
    GCancellable()             $cancellable,
    CArray[Pointer[GError]]    $error             = gerror,
                              :$raw               = False
  ) {
    samewith(
      $uri,
      $data,
      $data_length,
      $in_content_type,
      $in_headers,
      newCArray(Str),
      newCArray(SoupMessageHeaders),
      newCArray(GByteArray),
      $error,
      :all
      :$raw
    );
  }
  multi method post_sync (
    Str()                       $uri,
    Str()                       $data,
    Int()                       $data_length,
    Str()                       $in_content_type,
    SoupMessageHeaders()        $in_headers,
    CArray[Str]                 $out_content_type,
    CArray[SoupMessageHeaders]  $out_headers,
    CArray[Pointer[GByteArray]] $out_content,
    GCancellable()              $cancellable,
    CArray[Pointer[GError]]     $error             = gerror,
                               :$all               = False,
                               :$raw               = False
  ) {
    my gsize $dl = $data_length;

    clear_error;
    my $rv = so e_webdav_session_post_sync(
      $!eds-ws,
      $uri,
      $data,
      $dl,
      $in_content_type,
      $in_headers,
      $out_content_type,
      $out_headers,
      $out_content,
      $cancellable,
      $error
    );
    set_error($error);

    my ($oct, $oh, $oc) = ppr($out_content_type, $out_headers, $out_content);
    $oh = propReturnObject($oh, $raw, |SOUP::Message::Headers.getTypePair);
    $oc = propReturnObject($oc, $raw, |GLib::Array::Bytes.getTypePair);

    $all.not ?? $rv !! ($oct, $oh, $oc);
  }

  proto method principal_property_search_sync (|)
    is also<principal-property-search-sync>
  { * }

  multi method principal_property_search_sync (
    Str()                   $uri,
    Int()                   $apply_to_principal_collection_set,
    Str()                   $match_ns_uri,
    Str()                   $match_property,
    Str()                   $match_value,
    GCancellable()          $cancellable                        = GCancellable,
    CArray[Pointer[GError]] $error                              = gerror,
                            :$raw                               = False
  ) {
    samewith(
      $uri,
      $apply_to_principal_collection_set,
      $match_ns_uri,
      $match_property,
      $match_value,
      newCArray(GSList),
      $cancellable,
      $error,
      :all,
      :$raw
    );
  }
  multi method principal_property_search_sync (
    Str()                   $uri,
    Int()                   $apply_to_principal_collection_set,
    Str()                   $match_ns_uri,
    Str()                   $match_property,
    Str()                   $match_value,
    CArray[Pointer[GSList]] $out_principals,
    GCancellable()          $cancellable                        = GCancellable,
    CArray[Pointer[GError]] $error                              = gerror,
                            :$all                               = False,
                            :$raw                               = False,
                            :glist(:$gslist)                    = False
  ) {
    my gboolean $a = $apply_to_principal_collection_set.so.Int;

    clear_error;
    my $rv = e_webdav_session_principal_property_search_sync(
      $!eds-ws,
      $uri,
      $a,
      $match_ns_uri,
      $match_property,
      $match_value,
      $out_principals,
      $cancellable,
      $error
    );
    set_error($error);

    $all.not ?? $rv
             !! returnGSList(
                  ppr($out_principals),
                  $raw,
                  $gslist,
                  |Evolution::WebDAV::Resource.getTypePair
                );
  }

  method propfind_sync (
    Str()                   $uri,
    Str()                   $depth,
    EXmlDocument()          $xml,
                            &func,
    gpointer                $func_user_data = gpointer,
    GCancellable()          $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<propfind-sync>
  {
    clear_error;
    my $rv = so e_webdav_session_propfind_sync(
      $!eds-ws,
      $uri,
      $depth,
      $xml,
      &func,
      $func_user_data,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method proppatch_sync (
    Str()                   $uri,
    EXmlDocument()          $xml,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<proppatch-sync>
  {
    clear_error;
    my $rv = so e_webdav_session_proppatch_sync(
      $!eds-ws,
      $uri,
      $xml,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method put_data_sync (|)
    is also<put-data-sync>
  { * }

  multi method put_data_sync (
    Str()                       $uri,
    Str()                       $etag,
    Str()                       $content_type,
    SoupMessageHeaders()        $in_headers,
    Str()                       $bytes,
    Int()                       $length,
    CArray[Str]                 $out_href,
    CArray[Str]                 $out_etag,
    CArray[SoupMessageHeaders]  $out_headers,
    GCancellable()              $cancellable    = GCancellable,
    CArray[Pointer[GError]]     $error          = gerror,
                               :$raw            = False
  ) {
    samewith(
      $uri,
      $etag,
      $content_type,
      $in_headers,
      $bytes,
      $length,
      newCArray(Str),
      newCArray(Str),
      newCArray(SoupMessageHeaders),
      $cancellable,
      $error,
      :all,
      :$raw
    );
  }
  multi method put_data_sync (
    Str()                       $uri,
    Str()                       $etag,
    Str()                       $content_type,
    SoupMessageHeaders()        $in_headers,
    Str()                       $bytes,
    Int()                       $length,
    CArray[Str]                 $out_href,
    CArray[Str]                 $out_etag,
    CArray[SoupMessageHeaders]  $out_headers,
    GCancellable()              $cancellable    = GCancellable,
    CArray[Pointer[GError]]     $error          = gerror,
                               :$all            = False,
                               :$raw            = False
  ) {
    my gsize $l = $length;

    clear_error;
    my $rv = so e_webdav_session_put_data_sync(
      $!eds-ws,
      $uri,
      $etag,
      $content_type,
      $in_headers,
      $bytes,
      $l,
      newCArray(Str),
      newCArray(Str),
      newCArray(SoupMessageHeaders),
      $cancellable,
      $error
    );
    set_error($error);

    my ($oh, $oe) = ppr($out_href, $out_etag);

    my $ohd = propReturnObject(
      ppr($out_headers),
      $raw,
      |SOUP::Message::Headers.getTypePair
    );

    $all.not ?? $rv
             !! ($oh, $oe, $ohd);
  }

  proto method put_sync (|)
    is also<put-sync>
  { * }

  multi method put_sync (
    Str()                    $uri,
    Str()                    $etag,
    Str()                    $content_type,
    SoupMessageHeaders()     $in_headers,
    GInputStream()           $stream,
    Int()                    $stream_length,
    GCancellable()           $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False
  ) {
    samewith(
      $!eds-ws,
      $uri,
      $etag,
      $content_type,
      $in_headers,
      $stream,
      $stream_length,
      newCArray(Str),
      newCArray(Str),
      newCArray(SoupMessageHeaders),
      $cancellable,
      $error,
      :all,
      :$raw
    );
  }
  multi method put_sync (
    Str()                       $uri,
    Str()                       $etag,
    Str()                       $content_type,
    SoupMessageHeaders()        $in_headers,
    GInputStream()              $stream,
    Int()                       $stream_length,
    CArray[Str]                 $out_href,
    CArray[Str]                 $out_etag,
    CArray[SoupMessageHeaders]  $out_headers,
    GCancellable()              $cancellable    = GCancellable,
    CArray[Pointer[GError]]     $error          = gerror,
                               :$all            = False,
                               :$raw            = False
  ) {
    my gsize $l = $stream_length;

    clear_error;
    my $rv = so e_webdav_session_put_sync(
      $!eds-ws,
      $uri,
      $etag,
      $content_type,
      $in_headers,
      $stream,
      $l,
      $out_href,
      $out_etag,
      $out_headers,
      $cancellable,
      $error
    );
    set_error($error);

    my ($oh, $oe) = ppr($out_href, $out_etag);

    my $ohd = propReturnObject(
      ppr($out_headers),
      $raw,
      |SOUP::Message::Headers.getTypePair
    );

    $all.not ?? $rv
             !! ($oh, $oe, $ohd);
  }

  method refresh_lock_sync (
    Str()                   $uri,
    Str()                   $lock_token,
    Int()                   $lock_timeout,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error         = gerror
  )
    is also<refresh-lock-sync>
  {
    my gint32 $l = $lock_timeout;

    clear_error;
    my $rv = so e_webdav_session_refresh_lock_sync(
      $!eds-ws,
      $uri,
      $lock_token,
      $l,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method replace_with_detailed_error (
    SoupMessage()           $message,
    GByteArray()            $response_data,
    Int()                   $ignore_multistatus,
    Str()                   $prefix,
    CArray[Pointer[GError]] $inout_error         = no-error
  )
    is also<replace-with-detailed-error>
  {
    my gboolean $i = $ignore_multistatus.so.Int;

    clear_error;
    my $rv = so e_webdav_session_replace_with_detailed_error(
      $!eds-ws,
      $message,
      $response_data,
      $i,
      $prefix,
      $inout_error
    );
    set_error($inout_error);
    $rv;
  }

  proto method report_sync (|)
    is also<report-sync>
  { * }

  multi method report_sync (
    Str()                    $uri,
    Str()                    $depth,
    EXmlDocument()           $xml,
                             &func,
    gpointer                 $func_user_data = gpointer,
    GCancellable()           $cancellable    = GCancellable,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False
  ) {
    samewith(
      $uri,
      $depth,
      $xml,
      &func,
      $func_user_data,
      newCArray(Str),
      newCArray(GByteArray);
      $cancellable,
      $error,
      :all,
      :$raw
    );
  }
  multi method report_sync (
    Str()                        $uri,
    Str()                        $depth,
    EXmlDocument()               $xml,
                                 &func,
    gpointer                     $func_user_data,
    CArray[Str]                  $out_content_type,
    CArray[Pointer[GByteArray]]  $out_content,
    GCancellable()               $cancellable       = GCancellable,
    CArray[Pointer[GError]]      $error             = gerror,
                                :$all               = False,
                                :$raw               = False
  ) {
    clear_error;
    my $rv = so e_webdav_session_report_sync(
      $!eds-ws,
      $uri,
      $depth,
      $xml,
      &func,
      $func_user_data,
      $out_content_type,
      $out_content,
      $cancellable,
      $error
    );
    set_error($error);

    my $oc = propReturnObject(
      ppr($out_content),
      $raw,
      GLib::Array::Bytes.getTypePair
    );

    $all.not ?? $rv
             !! ( ppr($out_content_type), $oc );
  }

  method set_acl_sync (
    Str()                   $uri,
    GSList()                $entries,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<set-acl-sync>
  {
    clear_error;
    my $rv = so e_webdav_session_set_acl_sync(
      $!eds-ws,
      $uri,
      $entries,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method traverse_mkcalendar_response (
    SoupMessage()           $message,
    GByteArray()            $xml_data,
                            &func,
    gpointer                $func_user_data = gpointer,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<traverse-mkcalendar-response>
  {
    clear_error;
    my $rv = so e_webdav_session_traverse_mkcalendar_response(
      $!eds-ws,
      $message,
      $xml_data,
      &func,
      $func_user_data,
      $error
    );
    set_error($error);
    $rv;
  }

  method traverse_mkcol_response (
    SoupMessage()           $message,
    GByteArray()            $xml_data,
                            &func,
    gpointer                $func_user_data = gpointer,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<traverse-mkcol-response>
  {
    clear_error;
    my $rv = so e_webdav_session_traverse_mkcol_response(
      $!eds-ws,
      $message,
      $xml_data,
      &func,
      $func_user_data,
      $error
    );
    set_error($error);
    $rv;
  }

  method traverse_multistatus_response (
    SoupMessage()           $message,
    GByteArray()            $xml_data,
                            &func,
    gpointer                $func_user_data = gpointer,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<traverse-multistatus-response>
  {
    clear_error;
    my $rv = so e_webdav_session_traverse_multistatus_response(
      $!eds-ws,
      $message,
      $xml_data,
      &func,
      $func_user_data,
      $error
    );
    set_error($error);
    $rv;
  }

  method unlock_sync (
    Str()                   $uri,
    Str()                   $lock_token,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<unlock-sync>
  {
    clear_error;
    my $rv = so e_webdav_session_unlock_sync(
      $!eds-ws,
      $uri,
      $lock_token,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method update_properties_sync (
    Str()                   $uri,
    GSList()                $changes,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<update-properties-sync>
  {
    clear_error;
    my $rv = e_webdav_session_update_properties_sync(
      $!eds-ws,
      $uri,
      $changes,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method util_free_privileges (GNode() $privileges)
    is also<util-free-privileges>
    is static
  {
    e_webdav_session_util_free_privileges($privileges);
  }

  method util_item_href_equal (Str() $href1, Str() $href2)
    is also<util-item-href-equal>
    is static
  {
    e_webdav_session_util_item_href_equal($!eds-ws, $href2);
  }

  method util_maybe_dequote (Str() $text)
    is also<util-maybe-dequote>
    is static
  {
    e_webdav_session_util_maybe_dequote($text);
  }

}
