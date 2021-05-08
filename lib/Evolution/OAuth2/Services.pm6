use v6.c;

use Evolution::Raw::Types;
use Evolution::Raw::OAuth2::Services;

use GLib::GList;

use GLib::Roles::Object;

use Evolution::Roles::OAuth2::Service;

our subset EOAuth2ServicesAncestry is export of Mu
  where EOAuth2Services | GObject;

class Evolution::OAuth2::Services {
  also does GLib::Roles::Object;

  has EOAuth2Services $!eos;

  submethod BUILD (:$services) {
    self.setEOAuth2Services($services) if $services;
  }

  method setEOAuth2Services (EOAuth2ServicesAncestry $_) {
    my $to-parent;

    $!eos = do {
      when EOAuth2Services {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EOAuth2Services, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Evolution::Raw::Definitions::EOAuth2Services
  { $!eos }

  multi method new (EOAuth2ServicesAncestry $services, :$ref = True) {
    return Nil unless $services;

    my $o = self.bless( :$services );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $services = e_oauth2_services_new();

    $services ?? self.bless( :$services ) !! Nil;
  }

  method add (EOAuth2Service() $service) {
    e_oauth2_services_add($!eos, $service);
  }

  method find (ESource() $source, :$raw = False) {
    my $s = e_oauth2_services_find($!eos, $source);

    # Transfer: none (assumption based on service being owned by services)
    $s ??
      ( $raw ?? $s !! Evolution::OAuth2::Service($s) )
      !!
      Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_oauth2_services_get_type, $n, $t );
  }

  method guess (Str() $protocol, Str() $hostname, :$raw = False) {
    my $s = e_oauth2_services_guess($!eos, $protocol, $hostname);

    # Transfer: none (assumption based on service being owned by services)
    $s ??
      ( $raw ?? $s !! Evolution::OAuth2::Service($s) )
      !!
      Nil;
  }

  method is_oauth2_alias (Str() $auth_method) {
    so e_oauth2_services_is_oauth2_alias($!eos, $auth_method);
  }

  method is_oauth2_alias_static (
    Evolution::OAuth2::Services:U:

    Str() $auth_method
  ) {
    so e_oauth2_services_is_oauth2_alias_static($auth_method);
  }

  method is_supported ( Evolution::OAuth2::Services:U: ) {
    so e_oauth2_services_is_supported();
  }

  method list (:$glist = False, :$raw = False) {
    returnGList(
      e_oauth2_services_list($!eos),
      $glist,
      $raw,
      EOAuth2Service,
      Evolution::OAuth2::Service
    )
  }

  method remove (EOAuth2Service() $service) {
    e_oauth2_services_remove($!eos, $service);
  }

}
