use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::OAuth2::Service;

role Evolution::Roles::OAuth2::Service {
  has EOAuth2Service $!eos;

  method roleInit-EOAuth2Service {
    return if $!eos;

    my \i = findProperImplementor(self.^attributes);
    $!eos = cast( EOAuth2Service, i.get_value(self) );
  }

  method Evolution::Raw::Definitions::EOAuth2Service
  { $!eos }

  method can_process (ESource() $source) {
    so e_oauth2_service_can_process($!eos, $source);
  }

  method delete_token_sync (
    ESource()               $source,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so e_oauth2_service_delete_token_sync(
      $!eos,
      $source,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method extract_authorization_code (|)
  { *}

  # cw: Note lack of type checking, this is due to the main routine already
  #     being coercive.
  multi method extract_authorization_code (
    $source,
    $page_title,
    $page_url,
    :$page_content = Str
  ) {
    (my $oac = CArray[Str].new)[0] = Str;

    samewith(
      $source,
      $page_title,
      $page_url,
      $page_content,
      $oac
    );
  }
  multi method extract_authorization_code (
    ESource()     $source,
    Str()         $page_title,
    Str()         $page_uri,
    Str()         $page_content,
    CArray[Str]   $out_authorization_code
  ) {
    e_oauth2_service_extract_authorization_code(
      $!eos,
      $source,
      $page_title,
      $page_uri,
      $page_content,
      $out_authorization_code
    );

    ppr($out_authorization_code);
  }

  proto method get_access_token_sync (|)
  { * }

  multi method get_access_token_sync (
    ESource()               $source,
                            &ref_source,
    CArray[Pointer[GError]] $error,
    gpointer                :$ref_source_user_data = gpointer,
    GCancellable            :$cancellable          = GCancellable
  ) {
    (my $oat = CArray[Str].new)[0] = Str;

    my gint $oei = 0;

    my $rv = samewith(
      $source,
      &ref_source,
      $ref_source_user_data,
      $oat,
      $oei,
      $cancellable,
      $error,
      :all
    );

    $rv ?? $rv.skip(1) !! Nil;
  }
  multi method get_access_token_sync (
    ESource()               $source,
                            &ref_source,
    gpointer                $ref_source_user_data,
    CArray[Str]             $out_access_token,
    gint                    $out_expires_in       is rw,
    GCancellable()          $cancellable           = GCancellable,
    CArray[Pointer[GError]] $error                 = gerror,
                            :$all                  = False
  ) {
    clear_error;
    my $rv = so e_oauth2_service_get_access_token_sync(
      $!eos,
      $source,
      &ref_source,
      $ref_source_user_data,
      $out_access_token,
      $out_expires_in,
      $cancellable,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ($rv, ppr($out_access_token), $out_expires_in)
  }

  method get_authentication_policy (
    ESource() $source,
    Str()     $uri
  ) {
    EOAuth2ServiceNavigationPolicyEnum(
      e_oauth2_service_get_authentication_policy($!eos, $source, $uri)
    );
  }

  method get_authentication_uri (ESource() $source) {
    e_oauth2_service_get_authentication_uri($!eos, $source);
  }

  method get_client_id (ESource() $source) {
    e_oauth2_service_get_client_id($!eos, $source);
  }

  method get_client_secret (ESource() $source) {
    e_oauth2_service_get_client_secret($!eos, $source);
  }

  method get_display_name {
    e_oauth2_service_get_display_name($!eos);
  }

  method get_flags {
    e_oauth2_service_get_flags($!eos);
  }

  method get_name {
    e_oauth2_service_get_name($!eos);
  }

  method get_redirect_uri (ESource() $source) {
    e_oauth2_service_get_redirect_uri($!eos, $source);
  }

  method get_refresh_uri (ESource() $source) {
    e_oauth2_service_get_refresh_uri($!eos, $source);
  }

  method eoauth2service_get_type {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &e_oauth2_service_get_type, $n, $t );
  }

  method guess_can_process (Str() $protocol = Str, Str() $hostname = Str) {
    so e_oauth2_service_guess_can_process($!eos, $protocol, $hostname);
  }

  method prepare_authentication_uri_query (
    ESource()    $source,
    GHashTable() $uri_query
  ) {
    # cw: Note that keys and values of GHashTable will be freed once
    #     this routine executes!
    e_oauth2_service_prepare_authentication_uri_query(
      $!eos,
      $source,
      $uri_query
    );
  }

  method prepare_get_token_form (
    ESource()    $source,
    Str()        $authorization_code,
    GHashTable() $form
  ) {
    e_oauth2_service_prepare_get_token_form(
      $!eos,
      $source,
      $authorization_code,
      $form
    );
  }

  # cw: This expects $message to get changed.
  method prepare_get_token_message (
    ESource()     $source,
    SoupMessage() $message
  ) {
    e_oauth2_service_prepare_get_token_message($!eos, $source, $message);
  }

  method prepare_refresh_token_form (
    ESource()    $source,
    Str()        $refresh_token,
    GHashTable() $form
  ) {
    e_oauth2_service_prepare_refresh_token_form(
      $!eos,
      $source,
      $refresh_token,
      $form
    );
  }

  method prepare_refresh_token_message (
    ESource()     $source,
    SoupMessage() $message
  ) {
    e_oauth2_service_prepare_refresh_token_message($!eos, $source, $message);
  }


  method receive_and_store_token_sync (
    ESource()               $source,
    Str()                   $authorization_code,
                            &ref_source,
    gpointer                $ref_source_user_data = gpointer,
    GCancellable()          $cancellable          = GCancellable,
    CArray[Pointer[GError]] $error                = gerror
  ) {
    clear_error;
    my $rv = so e_oauth2_service_receive_and_store_token_sync(
      $!eos,
      $source,
      $authorization_code,
      &ref_source,
      $ref_source_user_data,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method refresh_and_store_token_sync (
    ESource()               $source,
    Str()                   $refresh_token,
                            &ref_source,
    gpointer                $ref_source_user_data = gpointer,
    GCancellable()          $cancellable          = GCancellable,
    CArray[Pointer[GError]] $error                = gerror
  ) {
    clear_error;
    my $rv = e_oauth2_service_refresh_and_store_token_sync(
      $!eos,
      $source,
      $refresh_token,
      &ref_source,
      $ref_source_user_data,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

}

class Evolution::OAuth2::Service::Util {
  also does GLib::Roles::StaticClass;

  method set_to_form (GHashTable() $form, Str() $name, Str() $value) {
    e_oauth2_service_util_set_to_form($form, $name, $value);
  }

  method take_to_form (GHashTable() $form, Str() $name, Str() $value) {
    e_oauth2_service_util_take_to_form($form, $name, $value);
  }

}

use GLib::Roles::Object;

our subset EOAuth2ServiceAncestry is export of Mu
  where EOAuth2Service | GObject;

class Evolution::OAuth2::Service {
  also does GLib::Roles::Object;
  also does Evolution::Roles::OAuth2::Service;

  submethod BUILD (:$service) {
    self.setEOAuth2Service($service) if $service;
  }

  method setEOAuth2Service (EOAuth2ServiceAncestry $_) {
    my $to-parent;

    $!eos = do {
      when EOAuth2Service {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(EOAuth2Service, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (EOAuth2ServiceAncestry $service, :$ref = True) {
    return Nil unless $service;

    my $o = self.bless( :$service );
    $o.ref if $ref;
    $o;
  }

}
