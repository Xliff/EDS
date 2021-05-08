use v6.c;

use NativeCall;

use Evolution::Raw::Types;
use Evolution::Raw::Source::CredentialsProvider;

use Evolution::Source;

use GLib::Roles::Object;

class Evolution::Source::CredentialsProvider {
  also does GLib::Roles::Object;

  has ESourceCredentialsProvider $!escp;

  method new (ESourceRegistry() $registry) {
    my $provider = e_source_credentials_provider_new($registry);

    $provider ?? self.bless( :$provider ) !! Nil;
  }

  method can_prompt (ESource() $source) {
    so e_source_credentials_provider_can_prompt($!escp, $source);
  }

  method can_store (ESource() $source) {
    so e_source_credentials_provider_can_store($!escp, $source);
  }

  multi method delete (
    ESource()      $source,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCallback
  ) {
    samewith(
      $source,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method delete (
    ESource()      $source,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_source_credentials_provider_delete(
      $!escp,
      $source,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method delete_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so e_source_credentials_provider_delete_finish(
      $!escp,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

  method delete_sync (
    ESource()               $source,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    e_source_credentials_provider_delete_sync(
      $!escp,
      $source,
      $cancellable,
      $error
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &e_source_credentials_provider_get_type,
      $n,
      $t
    );
  }

  multi method lookup (
    ESource()      $source,
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $source,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method lookup (
    ESource()      $source,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    e_source_credentials_provider_lookup(
      $!escp,
      $source,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method lookup_finish (
    GAsyncResult()            $result,
    CArray[ENamedParameters]  $out_credentials,
    CArray[Pointer[GError]]   $error            = gerror,
                              :$all             = False
  ) {
    clear_error;
    my $rv = so e_source_credentials_provider_lookup_finish(
      $!escp,
      $result,
      $out_credentials,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_credentials) );
  }

  proto method lookup_sync (|)
  { * }

  multi method lookup_sync (
    ESource()                $source,
    CArray[Pointer[GError]]  $error            = gerror,
    GCancellable()           :$cancellable     = GCancellable,
                             :$raw             = False
  ) {
    (my $oc = CArray[ENamedParameters].new)[0] = ENamedParameters;

    my $rv = samewith(
      $source,
      $cancellable,
      $oc,
      $error,
      :all,
      :$raw
    );

    $rv[0] ?? $rv[1] !! Nil;
  }
  multi method lookup_sync (
    ESource()                $source,
    GCancellable()           $cancellable,
    CArray[ENamedParameters] $out_credentials,
    CArray[Pointer[GError]]  $error            = gerror,
                             :$all             = False
  ) {
    clear_error;
    my $rv = so e_source_credentials_provider_lookup_sync(
      $!escp,
      $source,
      $cancellable,
      $out_credentials,
      $error
    );
    set_error($error);

    return $rv unless $all;

    ( $rv, ppr($out_credentials) );
  }

  method ref_credentials_source (ESource() $source, :$raw = False) {
    my $s = e_source_credentials_provider_ref_credentials_source(
      $!escp,
      $source
    );

    # Transfer: full (by virtue of ref function)
    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s, :!ref) )
      !!
      Nil
  }

  method ref_registry (:$raw = False) {
    my $r = e_source_credentials_provider_ref_registry($!escp);

    # Transfer: full (by virtue of ref function)
    $r ??
      ( $raw ?? $r !! GLib::Object.new($r, :!ref) )
      !!
      Nil;
  }

  method ref_source (Str() $uid, :$raw = False) {
    my $s = e_source_credentials_provider_ref_source($!escp, $uid);

    # Transfer: full (by virtue of ref function)
    $s ??
      ( $raw ?? $s !! Evolution::Source.new($s, :!ref) )
      !!
      Nil;
  }

  method register_impl (ESourceCredentialsProviderImpl() $provider_impl) {
    e_source_credentials_provider_register_impl($!escp, $provider_impl);
  }

  multi method store (
    $source,
    $credentials,
    &callback,
    $user_data    = gpointer,
    :$permanently = False,
    :$cancellable = GCancellable
  ) {
    samewith(
      $source,
      $credentials,
      $permanently,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method store (
    ESource()          $source,
    ENamedParameters() $credentials,
    Int()              $permanently,
    GCancellable()     $cancellable,
                       &callback,
    gpointer           $user_data    = gpointer
  ) {
    my gboolean $p = $permanently.so.Int;

    e_source_credentials_provider_store(
      $!escp,
      $source,
      $credentials,
      $permanently,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method store_finish (GAsyncResult() $result, CArray[Pointer[GError]] $error) {
    clear_error;
    my $rv = so e_source_credentials_provider_store_finish(
      $!escp,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

  method store_sync (
    ESource()                 $source,
    ENamedParameters()        $credentials,
    Int()                     $permanently,
    GCancellable()            $cancellable = GCancellable,
    CArray[Pointer[GError]]   $error       = gerror
  ) {
    my gboolean $p = $permanently.so.Int;

    clear_error;
    my $rv = so e_source_credentials_provider_store_sync(
      $!escp,
      $source,
      $credentials,
      $p,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method unregister_impl (ESourceCredentialsProviderImpl() $provider_impl) {
    e_source_credentials_provider_unregister_impl($!escp, $provider_impl);
  }

}
