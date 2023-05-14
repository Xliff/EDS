use v6.c;

use Method::Also;

use NativeCall;

use Evolution::Raw::Types;

use GLib::Roles::StaticClass;

class Evolution::SecretStore {
  also does GLib::Roles::StaticClass;

  method delete_sync (
    Str()                   $uid,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error
  )
    is also<delete-sync>
  {
    clear_error;
    my $rv = so e_secret_store_delete_sync($uid, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method lookup_sync (|)
    is also<lookup-sync>
  { * }

  multi method lookup_sync (
    Str()                    $uid,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    return-with-all(
      samewith($uid, newCArray(Str), $cancellable, $error, :all)
    )
  }
  multi method lookup_sync (
    Str()                    $uid,
    CArray[Str]              $out_secret,
    GCancellable()           $cancellable = GCancellable,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$all         = False
  ) {
    clear_error;
    my $rv = so e_secret_store_lookup_sync(
      $uid,
      $out_secret,
      $cancellable,
      $error
    );
    set_error($error);

    $all.not ?? $rv !! ( $rv, ppr($out_secret) )
  }

  method store_sync (
    Str()                   $uid,
    Str()                   $secret,
    Str()                   $label,
    Int()                   $permanently,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<store-sync>
  {
    my gboolean $p = $permanently.so.Int;

    clear_error;
    my $rv = so e_secret_store_store_sync(
      $uid,
      $secret,
      $label,
      $permanently,
      $cancellable,
      $error
    );
    set_error($error);
  }

}

### /usr/src/evolution-data-server-3.48.0/src/libedataserver/e-secret-store.h

sub e_secret_store_delete_sync (
  Str                     $uid,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_secret_store_lookup_sync (
  Str                     $uid,
  CArray[Str]             $out_secret,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }

sub e_secret_store_store_sync (
  Str                     $uid,
  Str                     $secret,
  Str                     $label,
  gboolean                $permanently,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(eds)
  is export
{ * }
