use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use GLib::Roles::Implementor;

use Evolution::CollectionBackend;

our subset EWebDAVCollectionBackendAncestry is export of Mu
  where EWebDAVCollectionBackend | ECollectionBackendAncestry;

class Evolution::WebDAV::Collection::Backend
  is Evolution::CollectionBackend
{
  has EWebDAVCollectionBackend $!ebackend-wcb is implementor;

  submethod BUILD ( :$e-webdav-backend ) {
    self.setEWebDAVCollectionBackend($e-webdav-backend)
      if $e-webdav-backend
  }

  method setEWebDAVCollectionBackend (EWebDAVCollectionBackendAncestry $_) {
    my $to-parent;

    $!ebackend-wcb = do {
      when EWebDAVCollectionBackend {
        $to-parent = cast(ECollectionBackend, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EWebDAVCollectionBackend, $_);
      }
    }
    self.setECollectionBackend($to-parent);
  }

  method Evolution::Raw::Definitions::EWebDAVCollectionBackend
    is also<EWebDAVCollectionBackend>
  { $!ebackend-wcb }

  method new (
    $e-webdav-backend where * ~~ EWebDAVCollectionBackendAncestry,

    :$ref = True
  ) {
    return unless $e-webdav-backend;

    my $o = self.bless( :$e-webdav-backend );
    $o.ref if $ref;
    $o;
  }

  proto method discover_sync (|)
    is also<discover-sync>
  { * }

  multi method discover_sync (
    CArray[Pointer[GError]]  $error       = gerror,
    ENamedParameters()      :$credentials = ENamedParameters,
    GCancellable()          :$cancellable = GCancellable,

    Str                     :cal(:calendar-url(:$calendar_url)) = Str,
    Str                     :con(:contacts-url(:$contacts_url)) = Str
  ) {
    samewith(
       $calendar_url,
       $contacts_url,
       $credentials,
       newCArray(Str),
       $,
       $cancellable,
       $error,
      :all
    );
  }
  multi method discover_sync (
    Str()                    $calendar_url,
    Str()                    $contacts_url,
    ENamedParameters()       $credentials,
    CArray[Str]              $out_certificate_pem,
                             $out_certificate_errors is rw,
    GCancellable             $cancellable                  = GCancellable,
    CArray[Pointer[GError]]  $error                        = gerror,
                            :$all                          = False
  ) {
    my GTlsCertificateFlags $oce = 0;

    clear_error;
    my $rv = so e_webdav_collection_backend_discover_sync(
      $!ebackend-wcb,
      $calendar_url,
      $contacts_url,
      $credentials,
      $out_certificate_pem,
      $oce,
      $cancellable,
      $error
    );
    set_error($error);
    $out_certificate_errors = $oce;

    $all.not ?? $rv !! ( ppr($out_certificate_pem), $oce );
  }

  method get_resource_id (ESource() $source) is also<get-resource-id> {
    e_webdav_collection_backend_get_resource_id($!ebackend-wcb, $source);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_webdav_collection_backend_get_type,
      $n,
      $t
    );
  }

  method is_custom_source (ESource() $source) is also<is-custom-source> {
    so e_webdav_collection_backend_is_custom_source($!ebackend-wcb, $source);
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-webdav-collection-backend.h

sub e_webdav_collection_backend_discover_sync (
  EWebDAVCollectionBackend $webdav_backend,
  Str                      $calendar_url,
  Str                      $contacts_url,
  ENamedParameters         $credentials,
  CArray[Str]              $out_certificate_pem,
  GTlsCertificateFlags     $out_certificate_errors is rw,
  GCancellable             $cancellable,
  CArray[Pointer[GError]]  $error
)
  returns ESourceAuthenticationResult
  is      native(ebackend)
  is      export
{ * }

sub e_webdav_collection_backend_get_resource_id (
  EWebDAVCollectionBackend $webdav_backend,
  ESource                  $source
)
  returns Str
  is      native(ebackend)
  is      export
{ * }

sub e_webdav_collection_backend_is_custom_source (
  EWebDAVCollectionBackend $webdav_backend,
  ESource                  $source
)
  returns uint32
  is      native(ebackend)
  is      export
{ * }

sub e_webdav_collection_backend_get_type
  returns GType
  is      native(ebackend)
  is      export
{ * }
