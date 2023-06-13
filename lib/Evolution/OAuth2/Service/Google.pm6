use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use Evolution::Roles::OAuth2::Service;

our subset EOAuth2ServiceGoogleAncestry is export of Mu
  where EOAuth2ServiceGoogle | EOAuth2Service | GObject;

class Evolution::OAuth2::Service::Google {
  also does GLib::Roles::Object;
  also does Evolution::Roles::OAuth2::Service;

  has EOAuth2ServiceGoogle $!eds-osg is implementor;

  submethod BUILD ( :$e-oauth2-google ) {
    self.setEOAuth2ServiceGoogle($e-oauth2-google) if $e-oauth2-google
  }

  method setEOAuth2ServiceGoogle (EOAuth2ServiceGoogleAncestry $_) {
    my $to-parent;

    $!eds-osg = do {
      when EOAuth2ServiceGoogle {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when EOAuth2Service {
        $to-parent = cast(GObject, $_);
        $!eos      = $_;
        cast(EOAuth2ServiceGoogle, $_);
      }

      default {
        $to-parent = $_;
        cast(EOAuth2ServiceGoogle, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-EOAuth2Service;
  }

  method Evolution::Raw::Definitions::EOAuth2ServiceGoogle
    is also<EOAuth2ServiceGoogle>
  { $!eds-osg }

  multi method new (
    $e-oauth2-google where * ~~ EOAuth2ServiceGoogleAncestry,

    :$ref = True
  ) {
    return unless $e-oauth2-google;

    my $o = self.bless( :$e-oauth2-google );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $e-oauth2-google = self.new_gobject_ptr( self.get_type );

    my $o = $e-oauth2-google ?? self.bless( :$e-oauth2-google ) !! Nil;
    $o.setAttributes(%a) if $o && %a;
    $o
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_oauth2_service_google_get_type,
      $n,
      $t
    );
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-oauth2-service-google.h

sub e_oauth2_service_google_get_type
  returns GType
  is      native(eds)
  is      export
{ * }
