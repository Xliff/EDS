use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::WebDAV::Source::Discover;

use GLib::GSList;

use GLib::Roles::Implementor;

class Evolution::WebDAV::Source::Discovered {
  also does GLib::Roles::Implementor;

  has EWebDAVDiscoveredSource $!eds-wds is implementor;

  submethod BUILD ( :$e-discovered-source ) {
    $!eds-wds = $e-discovered-source if $e-discovered-source;
  }

  method Evolution::Raw::Definitions::EWebDAVDiscoveredSource
    is also<EWebDAVDiscoveredSource>
  { $!eds-wds }

  method new (EWebDAVDiscoveredSource $e-discovered-source, :$ref = True) {
    $e-discovered-source ?? self.bless( :$e-discovered-source ) !! Nil;
  }
  method copy ( :$raw = False ) {
    propReturnObject(
      e_webdav_discovered_source_copy($!eds-wds),
      $raw,
      |self.getTypePair
    );
  }

  method free {
    e_webdav_discovered_source_free($!eds-wds);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_webdav_discovered_source_get_type,
      $n,
      $t
    );
  }

  proto method free_discovered (|)
    is also<free-discovered>
  { * }

  multi method free_discovered (@sources) {
    samewith( GLib::GSList.new(@sources, typed => EWebDAVDiscoveredSource) );
  }
  multi method free_discovered (GSList() $sources) is static {
    e_webdav_discover_free_discovered_sources($sources);
  }

}

role Evolution::Roles::WebDAV::Discovery {

  multi method sources (
    Str()                $url_use_path,
                         &callback,
    ENamedParameters()  :$credentials   = ENamedParameters,
    Int()               :$only_supports = 0,
    GCancellable()      :$cancellable   = GCancellable,
    gpointer            :$user_data     = gpointer
  ) {
    samewith(
      $url_use_path,
      $only_supports,
      $credentials,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method sources (
    Str()               $url_use_path,
    Int()               $only_supports,
    ENamedParameters()  $credentials,
    GCancellable()      $cancellable,
                        &callback,
    gpointer            $user_data      = gpointer
  ) {
    my guint32 $o = $only_supports;

    e_webdav_discover_sources(
      self.ESource,
      $url_use_path,
      $only_supports,
      $credentials,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method sources_finish (|)
    is also<sources-finish>
  { * }

  multi method sources_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False,
                            :glist(:$gslist) = False
  ) {
    samewith(
       $result,
       newCArray(Str),
       $,
       newCArray(GSList),
       newCArray(GSList),
       $error,
      :all,
      :$raw
    )
  }
  multi method sources_finish (
    GAsyncResult             $result,
    CArray[Str]              $out_certificate_pem,
                             $out_certificate_errors       is rw,
    CArray[GSList]           $out_discovered_sources,
    CArray[GSList]           $out_calendar_user_addresses,
    CArray[Pointer[GError]]  $error,
                            :$all                                 = False,
                            :$raw                                 = False,
                            :glist(:$gslist)                      = False
  ) {
    my GTlsCertificateFlags $oce = 0;

    clear_error;
    my $rv = so e_webdav_discover_sources_finish(
      self.ESource,
      $result,
      $out_certificate_pem,
      $oce,
      $out_discovered_sources,
      $out_calendar_user_addresses,
      $error
    );
    set_error($error);
    $out_certificate_errors = $oce;

    my $ocp = ppr($out_certificate_pem);

    my $ods = propReturnObject(
      ppr($out_discovered_sources),
      $raw,
      $gslist,
      |Evolution::Sources::Discovered.getTypePair
    );

    my $ocua = propReturnObject(
      ppr($out_calendar_user_addresses),
      $raw,
      $gslist,
      Str
    );

    $all.not ?? $rv
             !! ($ocp, $oce, $ods, $ocua);
  }

  proto method sources_full (|)
    is also<sources-full>
  { * }

  multi method sources_full (
    Str()               $url_use_path,
                        &callback,
    gpointer            $user_data                         = gpointer,
    Int()              :only-supports(:$only_supports)     = 0,
    ENamedParameters() :$credentials                       = ENamedParameters,
                       :ref-source-func(:&ref_source_func) = Callable,
    gpointer           :ref-user-data(:$ref_user_data)     = gpointer,
    GCancellable()     :$cancellable                       = GCancellable
  ) {
    samewith(
      $url_use_path,
      $only_supports,
      $credentials,
      &ref_source_func,
      $ref_user_data,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method sources_full (
    Str()              $url_use_path,
    Int()              $only_supports,
    ENamedParameters() $credentials,
                       &ref_source_func,
    gpointer           $ref_source_func_user_data,
    GCancellable()     $cancellable,
                       &callback,
    gpointer           $user_data                  = gpointer
  ) {
    my guint32 $o = $only_supports;

    e_webdav_discover_sources_full(
      self.ESource,
      $url_use_path,
      $o,
      $credentials,
      &ref_source_func,
      $ref_source_func_user_data,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method sources_full_sync (|)
    is also<sources-full-sync>
  { * }

  multi method sources_full_sync (
    Str()                          $url_use_path,
    Int()                          $only_supports,
    CArray[Pointer[GError]]        $error               = gerror,
    ENamedParameters()             $credentials         = ENamedParameters,
                                  :ref-source-func(
                                    :&ref_source_func
                                  )                     = Callable,
    gpointer                      :ref-user-data(
                                     :$ref_user_data
                                  )                     = gpointer,
    GCancellable()                :$cancellable         = GCancellable,
                                  :$raw                 = False,
                                  :glist(:$gslist)      = False
  ) {
    samewith(
      $url_use_path,
      $only_supports,
      $credentials,
      &ref_source_func,
      $ref_user_data,
      newCArray(Str),
      $,
      newCArray(GSList),
      newCArray(GSList),
      $cancellable,
      $error,
    )
  }
  multi method sources_full_sync (
    Str()                         $url_use_path,
    Int()                         $only_supports,
    ENamedParameters()            $credentials,
                                  &ref_source_func,
    gpointer                      $ref_user_data,
    CArray[Str]                   $out_certificate_pem,
                                  $out_certificate_errors is rw,
    CArray[GSList]                $out_discovered_sources,
    CArray[GSList]                $out_calendar_user_addresses,
    GCancellable()                $cancellable,
    CArray[Pointer[GError]]       $error,

                                 :$all            = False,
                                 :$raw            = False,
                                 :glist(:$gslist) = False
  ) {
    my guint32              $o   = $only_supports;
    my GTlsCertificateFlags $oce = 0;

    clear_error;
    my $rv = so e_webdav_discover_sources_full_sync(
      self.ESource,
      $url_use_path,
      $o,
      $credentials,
      &ref_source_func,
      $ref_user_data,
      $out_certificate_pem,
      $oce,
      $out_discovered_sources,
      $out_calendar_user_addresses,
      $cancellable,
      $error
    );
    set_error($error);
    $out_certificate_errors = $oce;

    my $ocp = ppr($out_certificate_pem);

    my $ods = returnGSList(
      ppr($out_discovered_sources),
      $raw,
      $gslist,
      |Evolution::WebDAV::Sources::Discovered.getTypePair
    );

    my $ocua = returnGSList(
      ppr($out_calendar_user_addresses),
      $raw,
      $gslist,
      Str
    );

    $all.not ?? $rv
             !! ($ocp, $oce, $ods, $ocua);
  }

  proto method sources_sync (|)
    is also<sources-sync>
  { * }

  multi method sources_sync (
    Str()                     $url_use_path,
    CArray[Pointer[GError]]   $error          = gerror,
    GCancellable()           :$cancellable    = GCancellable,
    Int()                    :$only_supports  = 0,
    ENamedParameters()       :$credentials    = ENamedParameters,
                             :$raw            = False,
                             :glist(:$gslist) = False
  ) {
    samewith(
       $url_use_path,
       $only_supports,
       $credentials,
       newCArray(Str),
       $,
       newCArray(GSList),
       newCArray(GSList),
       $cancellable,
       $error,
      :all,
      :$raw,
      :$gslist
    );
  }
  multi method sources_sync (
    Str()                    $url_use_path,
    Int()                    $only_supports,
    ENamedParameters()       $credentials,
    CArray[Str]              $out_certificate_pem,
                             $out_certificate_errors        is rw,
    CArray[GSList]           $out_discovered_sources,
    CArray[GSList]           $out_calendar_user_addresses,
    GCancellable()           $cancellable,
    CArray[Pointer[GError]]  $error                                = gerror,
                            :$all                                  = False,
                            :$raw                                  = False,
                            :glist(:$gslist)                       = False
  ) {
    my guint32              $o   = $only_supports;
    my GTlsCertificateFlags $oce = 0;

    clear_error;
    my $rv = so e_webdav_discover_sources_sync(
      self.ESource,
      $url_use_path,
      $o,
      $credentials,
      $out_certificate_pem,
      $oce,
      $out_discovered_sources,
      $out_calendar_user_addresses,
      $cancellable,
      $error
    );
    set_error($error);
    $out_certificate_errors = $oce;

    my $ocp = ppr($out_certificate_pem);

    my $ods = returnGSList(
      ppr($out_discovered_sources),
      $raw,
      $gslist,
      |Evolution::WebDAV::Sources::Discovered.getTypePair
    );

    my $ocua = returnGSList(
      ppr($out_calendar_user_addresses),
      $raw,
      $gslist,
      Str
    );

    $all.not ?? $rv
             !! ($ocp, $oce, $ods, $ocua);
  }

}
