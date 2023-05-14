use v6.c;

use NativeCall;
use Method::Also;

use Evolution::Raw::Types;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role Evolution::Roles::OAuth2::Support {
  has EOAuth2Support $!eoa2-support is implementor;

  method Evolution::Raw::Definition::EOAuth2Support
    is also<EOAuth2Support>
  { $!eoa2-support }

  method roleInit-EOAuth2Support is also<roleInit_EOAuth2Support> {
    my \i = findProperImplementor(self.^attributes);
    $!eoa2-support = cast(EOAuth2Support, i);
  }

  proto method get_access_token (|)
    is also<get-access-token>
  { * }

  multi method get_access_token (
     $source,
     &callback,
     $user_data    = gpointer,
    :$cancellable  = GCancellable
  ) {
    samewith($source, $cancellable, &callback, $user_data)
  }
  multi method get_access_token (
    ESource()      $source,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    so e_oauth2_support_get_access_token(
      $!eoa2-support,
      $source,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method get_access_token_finish (|)
    is also<get-access-token-finish>
  { * }

  multi method get_access_token_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    my $oat = newCArray(Str);

    return-with-all( samewith($result, $oat, $, $error, :all) );
  }
  multi method get_access_token_finish (
    GAsyncResult()           $result,
    CArray[Str]              $out_access_token,
                             $out_expires_in    is rw,
    CArray[Pointer[GError]]  $error             =  gerror,
                            :$all               =  False
  ) {
    my gint $oei = 0;

    clear_error;
    my $rv = so e_oauth2_support_get_access_token_finish(
      $!eoa2-support,
      $result,
      $out_access_token,
      $oei,
      $error
    );
    set_error($error);
    $out_expires_in = $oei;

    $all.not ?? $rv !! ($rv, ppr($out_access_token), $out_expires_in);
  }

  proto method get_access_token_sync (|)
    is also<get-access-token-sync>
  { * }

  multi method get_access_token_sync (
    ESource()               $source,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        =  gerror
  ) {
    my $oat = newCArray(Str);

    return-with-all(
      samewith($source, $cancellable, $oat, $, $error, :all)
    );
  }
  multi method get_access_token_sync (
    ESource()                $source,
    GCancellable()           $cancellable,
    CArray[Str]              $out_access_token,
                             $out_expires_in    is rw,
    CArray[Pointer[GError]]  $error             =  gerror,
                            :$all               =  False
  ) {
    my gint $oei = 0;

    clear_error;
    my $rv = so e_oauth2_support_get_access_token_sync(
      $!eoa2-support,
      $source,
      $cancellable,
      $out_access_token,
      $oei,
      $error
    );
    set_error($error);
    $out_expires_in = $oei;

    $all.not ?? $rv !! ($rv, ppr($out_access_token), $out_expires_in)
  }

  method eoauth2support_get_type is also<eoauth2support-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &e_oauth2_support_get_type, $n, $t );
  }

}

our subset EOAuth2SupportAncestry is export of Mu
  where EOAuth2Support | GObject;

class Evolution::OAuth2::Support {
  also does GLib::Roles::Object;
  also does Evolution::Roles::OAuth2::Support;

  submethod BUILD ( :$e-oauth2-support ) {
    self.setEOAuth2Support( $e-oauth2-support ) if $e-oauth2-support;
  }

  method setEOAuth2Support (EOAuth2SupportAncestry $_) {
    my $to-parent;

    when EOAuth2Support {
      $to-parent = cast(GObject, $_);
      $!eoa2-support = $_;
    }

    default {
      $to-parent = $_;
      $!eoa2-support = cast(EOAuth2Support, $_);
    }
    self!setObject($to-parent);
  }

  method new (EOAuth2SupportAncestry $e-oauth2-support, :$ref = True) {
    return Nil unless $e-oauth2-support;

    my $o = self.bless( :$e-oauth2-support );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    self.eoauth2support_get_type;
  }
}

### /usr/src/evolution-data-server-3.48.0/src/libebackend/e-oauth2-support.h

sub e_oauth2_support_get_access_token (
  EOAuth2Support $support,
  ESource        $source,
  GCancellable   $cancellable,
                 &callback (EOAuth2Support, GAsyncResult, gpointer),
  gpointer       $user_data
)
  is native(eds)
  is export
{ * }

sub e_oauth2_support_get_access_token_finish (
  EOAuth2Support          $support,
  GAsyncResult            $result,
  CArray[Str]             $out_access_token,
  gint                    $out_expires_in    is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_support_get_access_token_sync (
  EOAuth2Support          $support,
  ESource                 $source,
  GCancellable            $cancellable,
  CArray[Str]             $out_access_token,
  gint                    $out_expires_in    is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_oauth2_support_get_type ()
  returns GType
  is native(eds)
  is export
{ * }
