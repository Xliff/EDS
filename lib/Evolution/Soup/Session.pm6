use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Soup::Session;

use GLib::ByteArray;
use GIO::InputStream;
use SOUP::Session;
use Evolution::NamedParameters;
use Evolution::Source;

use GLib::Roles::Implementor;

class Evolution::Soup::Session is SOUP::Session {
  has ESoupSession $!eds-ss is implementor;

  method new (ESource() $source) {
    my $e-soup-session = e_soup_session_new($source);

    $e-soup-session ?? self.bless( $e-soup-session ) !! Nil;
  }

  method new_message (
    ESoupSession()          $session,
    Str()                   $method,
    Str()                   $uri_string,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my $e-soup-session = e_soup_session_new_message(
      $session,
      $method,
      $uri_string,
      $error
    );

    $e-soup-session ?? self.bless( $e-soup-session ) !! Nil;
  }

  method new_message_from_uri (
    ESoupSession()          $session,
    Str()                   $method,
    GUri()                  $uri,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    my $e-soup-session = e_soup_session_new_message_from_uri(
      $session,
      $method,
      $uri,
      $error
    );

    $e-soup-session ?? self.bless( $e-soup-session ) !! Nil;
  }

  method check_result (
    SoupMessage()           $message,
    gpointer                $read_bytes,
    Int()                   $bytes_length,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    my gsize $b = $bytes_length;

    clear_error;
    my $rv = so e_soup_session_check_result(
      $!eds-ss,
      $message,
      $read_bytes,
      $b,
      $error
    );
    set_error($error);
    $rv;
  }

  method dup_credentials ( :$raw = False ) {
    propReturnObject(
      e_soup_session_dup_credentials($!eds-ss),
      $raw,
      |Evolution::NamedParameters.getTyperPair
    );
  }

  method error_quark is static {
    e_soup_session_error_quark();
  }

  method get_authentication_requires_credentials {
    so e_soup_session_get_authentication_requires_credentials($!eds-ss);
  }

  method get_force_http1 {
    so e_soup_session_get_force_http1($!eds-ss);
  }

  method get_log_level ( :$enum = True ) {
    my $sll = e_soup_session_get_log_level($!eds-ss);
    return $sll unless $enum;
    SoupLoggerLogLevel($sll);
  }

  method get_source ( :$raw = False ) {
    propReturnObject(
      e_soup_session_get_source($!eds-ss),
      $raw,
      |Evolution::Source.getTypePair
    );
  }

  proto method get_ssl_error_details (|)
  { * }

  multi method get_ssl_error_details {
    samewith( newCArray(Str), $, :all );
  }
  multi method get_ssl_error_details (
    CArray[Str]  $out_certificate_pem,
                 $out_certificate_errors is rw,
                :$all                           = False,
                :set(:$flags)                   = True
  ) {
    my GTlsCertificateFlags $oce = 0;

    my $rv = so e_soup_session_get_ssl_error_details(
      $!eds-ss,
      $out_certificate_pem,
      $oce
    );

    $out_certificate_errors = $flags.not
      ?? $oce
      !! getFlags(GTlsCertificateFlagsEnum, $oce);

    $all.not ?? $rv !! ( ppr($out_certificate_pem), $out_certificate_errors );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &e_soup_session_get_type, $n, $t );
  }

  proto method handle_authentication_failure (|)
  { * }

  multi method handle_authentication_failure (
    ESoupSession()           $session,
    ENamedParameters()       $credentials,
    GError()                 $op_error,
    CArray[Pointer[GError]]  $error         = gerror,
                            :$enum          = True,
                            :$flags         = True
  ) {
    samewith(
       $session,
       $credentials,
       $op_error,
       $,
       newCArray(Str),
       $,
       $error,
      :$enum,
      :$flags
    );
  }
  multi method handle_authentication_failure (
    ESoupSession()           $session,
    ENamedParameters()       $credentials,
    GError()                 $op_error,
                             $out_auth_result         is rw,
    CArray[Str]              $out_certificate_pem,
                             $out_certificate_errors  is rw,
    CArray[Pointer[GError]]  $error                          = gerror,
                            :$enum                           = True,
                            :set(:$flags)                    = True
  ) {
    my ESourceAuthenticationResult $oar = 0;
    my GTlsCertificateFlags        $oce = 0;

    e_soup_session_handle_authentication_failure(
      $!eds-ss,
      $credentials,
      $op_error,
      $oar,
      $out_certificate_pem,
      $oce,
      $error
    );

    $out_auth_result = $enum.not ?? $oar !! ESourceAuthenticationResult($oar);

    $out_certificate_errors = $flags.not
      ?? $oce
      !! getFlags(GTlsCertificateFlagsEnum, $oce);

    ($out_auth_result, $out_certificate_pem, $out_certificate_errors);
  }

  method prepare_message_send_sync (
    SoupMessage()           $message,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $p = e_soup_session_prepare_message_send_sync(
      $!eds-ss,
      $message,
      $cancellable,
      $error
    );
    set_error($error);
    $p;
  }

  proto method send_message (|)
  { * }

  multi method send_message (
    SoupMessage()   $message,
    gpointer        $prepare_data,
                    &callback,
    GCancellable() :$cancellable    = GCancellable,
    Int()          :$io_priority    = G_PRIORITY_DEFAULT,
    gpointer       :$user_data      = gpointer
  ) {
    samewith(
      $message,
      $io_priority,
      $prepare_data,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method send_message (
    SoupMessage()  $message,
    Int()          $io_priority,
    gpointer       $prepare_data,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data     = gpointer
  ) {
    my gint $i = $io_priority;

    e_soup_session_send_message(
      $!eds-ss,
      $message,
      $i,
      $prepare_data,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method send_message_finish (|)
  { * }

  multi method send_message_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error    = gerror,
                            :$flags    = True
  ) {
    samewith( newCArray(Str), $, :all, :$flags );
  }
  multi method send_message_finish (
    GAsyncResult             $result,
    CArray[Str]              $out_certificate_pem,
                             $out_certificate_errors is rw,
    CArray[Pointer[GError]]  $error,
                            :$all                           = False,
                            :$raw                           = False,
                            :$flags                         = True
  ) {
    my GTlsCertificateFlags $oce = 0;

    my $is = e_soup_session_send_message_finish(
      $!eds-ss,
      $result,
      $out_certificate_pem,
      $oce,
      $error
    );

    $out_certificate_errors = $flags.not
      ?? $oce
      !! getFlags(GTlsCertificateFlagsEnum, $oce);

    $is = propReturnObject( $is, $raw, |GIO::InputStream.getTypePair );

    $all.not ?? $is
             !! ($is, $out_certificate_pem, $out_certificate_errors);
  }

  method send_message_simple_sync (
    SoupMessage()            $message,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$raw         = False
  ) {
    clear_error;
    my $ba = e_soup_session_send_message_simple_sync(
      $!eds-ss,
      $message,
      $cancellable,
      $error
    );
    set_error($error);

    propReturnObject($ba, $raw, |GLib::ByteArray.getTypePair);
  }

  method send_message_sync (
    SoupMessage()             $message,
    GCancellable()            $cancellable = GCancellable,
    CArray[Pointer[GError]]   $error       = gerror,
                             :$raw         = False
  ) {
    clear_error;
    my $is = e_soup_session_send_message_sync(
      $!eds-ss,
      $message,
      $cancellable,
      $error
    );
    set_error($error);

    propReturnObject( $is, $raw, |GIO::InputStream.getTypePair )
  }

  method set_credentials (ENamedParameters() $credentials) {
    e_soup_session_set_credentials($!eds-ss, $credentials);
  }

  method set_force_http1 (Int() $force_http1) {
    my gboolean $f = $force_http1.so.Int;

    e_soup_session_set_force_http1($!eds-ss, $f);
  }

  method setup_logging (Str() $logging_level) {
    e_soup_session_setup_logging($!eds-ss, $logging_level);
  }

}

# cw: Currently out of scope until needed!
# class Evolution::Soup::Session::Util {
#   also does GLib::Roles::StaticClass;
#
#   method util_get_force_http1_supported {
#     e_soup_session_util_get_force_http1_supported();
#   }
#
#   method util_get_message_bytes {
#     e_soup_session_util_get_message_bytes();
#   }
#
#   method util_normalize_uri_path {
#     e_soup_session_util_normalize_uri_path();
#   }
#
#   method util_ref_message_request_body (
#     SoupMessage $message,
#     gssize      $out_length
#   ) {
#     e_soup_session_util_ref_message_request_body($message, $out_length);
#   }
#
#   method util_set_message_request_body (
#     SoupMessage  $message,
#     Str          $content_type,
#     GInputStream $input_stream,
#     gssize       $length
#   ) {
#     e_soup_session_util_set_message_request_body($message, $content_type, $input_stream, $length);
#   }
#
#   method util_set_message_request_body_from_data (
#     SoupMessage    $message,
#     gboolean       $create_copy,
#     Str            $content_type,
#     gpointer       $data,
#     gssize         $length,
#     GDestroyNotify $free_func
#   ) {
#     e_soup_session_util_set_message_request_body_from_data(
#       $message, $create_copy, $content_type, $data, $length, $free_func);
#   }
#
#   method util_status_to_string (Str() $reason_phrase) {
#     e_soup_session_util_status_to_string($reason_phrase);
#   }
# }
