use v6.c

use Evolution::Raw::Types;
use Evolution::Raw::Source::Webdav;

use Evolution::Source::Extension;

our subset ESourceWebdavAncestry is export of Mu
  where ESourceWebdav | ESourceExtensionAncestry;

class Evolution::Source::Webdav is Evolution::Source::Extension {
  has ESourceWebdav $!esw;

  submethod BUILD (:$webdav) {
    self.setESourceWebdav($webdav) if $webdav;
  }

  method setESourceWebdav (ESourceWebdavAncestry $_) {
    my $to-parent;

    $!esw = do {
      when ESourceWebdav {
        $to-parent = cast(ESourceExtension, $_);
          $_;
      }

      default {
        $to-parent = $_;
        cast(ESourceWebdav, $_);
      }
    }
    self.setESourceExtension($to-parent);
  }

  method Evolution::Raw::Structs::ESourceWebdav
  { $!esw }

  method new (
    ESourceWebdavAncestry $webdav,
                          :$ref   = True
  ) {
    return Nil unless $webdav;

    my $o = self.bless( :$webdav );
    $o.ref if $ref;
    $o;
  }

  method avoid_ifmatch is rw {
    Proxy.new:
      FETCH => -> $     { self.get_avoid_ifmatch    },
      STORE => -> $, \v { self.set_avoid_ifmatch(v) }
  }

  method calendar_auto_schedule is rw {
    Proxy.new:
      FETCH => -> $     { self.get_calendar_auto_schedule    },
      STORE => -> $, \v { self.set_calendar_auto_schedule(v) }
  }

  method color is rw {
    Proxy.new:
      FETCH => -> $     { self.get_color    },
      STORE => -> $, \v { self.set_color(v) }
  }

  method display_name is rw {
    Proxy.new:
      FETCH => -> $     { self.get_display_name    },
      STORE => -> $, \v { self.set_display_name(v) }
  }

  method email_address is rw {
    Proxy.new:
      FETCH => -> $     { self.get_email_address    },
      STORE => -> $, \v { self.set_email_address(v) }
  }

  method resource_path is rw {
    Proxy.new:
      FETCH => -> $     { self.get_resource_path    },
      STORE => -> $, \v { self.set_resource_path(v) }
  }

  method resource_query is rw {
    Proxy.new:
      FETCH => -> $     { self.get_resource_query    },
      STORE => -> $, \v { self.set_resource_query(v) }
  }

  method ssl_trust is rw {
    Proxy.new:
      FETCH => -> $     { self.get_ssl_trust    },
      STORE => -> $, \v { self.set_ssl_trust(v) }
  }

  method ssl_trust_response is rw {
    Proxy.new:
      FETCH => -> $     { self.get_ssl_trust_response    },
      STORE => -> $, \v { self.set_ssl_trust_response(v) }
  }

  method dup_color {
    e_source_webdav_dup_color($!esw);
  }

  method dup_display_name {
    e_source_webdav_dup_display_name($!esw);
  }

  method dup_email_address {
    e_source_webdav_dup_email_address($!esw);
  }

  method dup_resource_path {
    e_source_webdav_dup_resource_path($!esw);
  }

  method dup_resource_query {
    e_source_webdav_dup_resource_query($!esw);
  }

  method dup_soup_uri (:$raw = False) {
    my $u = e_source_webdav_dup_soup_uri($!esw);

    # Transfer: full
    $u ??
      ( $raw ?? $u !! SOUP::URI($u, :!ref) )
      !!
      Nil;
  }

  method dup_ssl_trust {
    e_source_webdav_dup_ssl_trust($!esw);
  }

  method get_avoid_ifmatch {
    e_source_webdav_get_avoid_ifmatch($!esw);
  }

  method get_calendar_auto_schedule {
    so e_source_webdav_get_calendar_auto_schedule($!esw);
  }

  method get_color {
    e_source_webdav_get_color($!esw);
  }

  method get_display_name {
    e_source_webdav_get_display_name($!esw);
  }

  method get_email_address {
    e_source_webdav_get_email_address($!esw);
  }

  method get_resource_path {
    e_source_webdav_get_resource_path($!esw);
  }

  method get_resource_query {
    e_source_webdav_get_resource_query($!esw);
  }

  method get_ssl_trust {
    e_source_webdav_get_ssl_trust($!esw);
  }

  method get_ssl_trust_response {
    ETrustPromptResponseEnum( e_source_webdav_get_ssl_trust_response($!esw) );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_webdav_get_type,
      $n,
      $t
    );
  }

  method set_avoid_ifmatch (Int() $avoid_ifmatch) {
    my gboolean $a = $avoid_ifmatch.so.Int;

    e_source_webdav_set_avoid_ifmatch($!esw, $a);
  }

  method set_calendar_auto_schedule (gboolean $calendar_auto_schedule) {
    my gboolean $c = $calendar_auto_schedule.so.Int;

    e_source_webdav_set_calendar_auto_schedule($!esw, $c);
  }

  method set_color (Str() $color) {
    e_source_webdav_set_color($!esw, $color);
  }

  method set_display_name (Str() $display_name) {
    e_source_webdav_set_display_name($!esw, $display_name);
  }

  method set_email_address (Str() $email_address) {
    e_source_webdav_set_email_address($!esw, $email_address);
  }

  method set_resource_path (Str() $resource_path) {
    e_source_webdav_set_resource_path($!esw, $resource_path);
  }

  method set_resource_query (Str() $resource_query) {
    e_source_webdav_set_resource_query($!esw, $resource_query);
  }

  method set_soup_uri (SoupURI() $soup_uri) {
    e_source_webdav_set_soup_uri($!esw, $soup_uri);
  }

  method set_ssl_trust (Str() $ssl_trust) {
    e_source_webdav_set_ssl_trust($!esw, $ssl_trust);
  }

  method set_ssl_trust_response (Int() $response) {
    my ETrustPromptResponse $r = $response;

    e_source_webdav_set_ssl_trust_response($!esw, $response);
  }

  method unset_temporary_ssl_trust {
    e_source_webdav_unset_temporary_ssl_trust($!esw);
  }

  method update_ssl_trust (
    Str()             $host,
    GTlsCertificate() $cert,
    Int()             $response
  ) {
    my ETrustPromptResponse $r = $response;

    e_source_webdav_update_ssl_trust($!esw, $host, $cert, $r);
  }

  method verify_ssl_trust (
    Str()             $host,
    GTlsCertificate() $cert,
    Int()             $cert_errors
  ) {
    my GTlsCertificateFlags $c = $cert_errors;

    e_source_webdav_verify_ssl_trust($!esw, $host, $cert, $c);
  }

}
